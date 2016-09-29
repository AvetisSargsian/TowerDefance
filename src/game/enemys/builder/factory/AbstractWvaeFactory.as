package game.enemys.builder.factory
{
	import mvc.command.interfaces.ICommandExecutor;
	import mvc.factory.IContentProduct;
	
	import starling.display.DisplayObjectContainer;

	public class AbstractWvaeFactory
	{
		public function AbstractWvaeFactory()
		{
			if(Object(this).constructor == AbstractWvaeFactory)
				throw new Error("Abstract classes can not be instantiated");
		}
		
		public final function produceWaveLauncher():ICommandExecutor
		{
			return createExecutor();
		}
		
		public final function produceWaveViews(obj:Object):IContentProduct
		{
			return createViewProduct(obj);
		}
		
		public final function produceViewCommandWraper(canvas:DisplayObjectContainer, viewProd:IContentProduct):IContentProduct
		{
			return createCommands(canvas,viewProd);
		}
		
		protected function createExecutor():ICommandExecutor
		{
			return new null;
		}
		
		protected function createCommands(target:DisplayObjectContainer, prod:IContentProduct):IContentProduct
		{
			return null;
		}
		
		protected function createViewProduct(obj:Object = null):IContentProduct
		{
			return null;
		}
	}
}