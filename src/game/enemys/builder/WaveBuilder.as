package game.enemys.builder
{
	import game.enemys.builder.factory.AbstractWvaeFactory;
	import game.enemys.builder.factory.WaveFactory;
	
	import mvc.builder.IBuilder;
	import mvc.command.interfaces.ICommand;
	import mvc.command.interfaces.ICommandExecutor;
	import mvc.disposeble.IDisposeble;
	import mvc.factory.IContentProduct;
	import mvc.factory.IStartProduct;
	
	import starling.display.DisplayObjectContainer;
	import game.enemys.builder.products.WaveStarterProduct;

	public final class WaveBuilder implements IBuilder, IDisposeble
	{
		private var waveFactory:AbstractWvaeFactory;
		private var commandProduct:IContentProduct;
		private var viewProduct:IContentProduct;
		private var executer:ICommandExecutor;
		
		public function WaveBuilder()
		{
			waveFactory = new WaveFactory();
		}
		
		public  function buildWaveView(obj):void
		{
			viewProduct = waveFactory.produceWaveViews(obj);
		}
		
		public function buildLauncher():void
		{
			executer = waveFactory.produceWaveLauncher();
			executer.loadCommands( Vector.<ICommand>(commandProduct.content as Array) );
		}
		
		public function buildLauncherComands(canvas:DisplayObjectContainer):void
		{
			commandProduct = waveFactory.produceViewCommandWraper(canvas,viewProduct);
		}
		
		public function getProduct():IStartProduct
		{
			return new WaveStarterProduct(executer);
		}
		
		public function dispose():void
		{
			waveFactory = null;
			commandProduct.dispose();
			commandProduct = null;
			viewProduct.dispose();
			viewProduct = null;
		}								
	}
}