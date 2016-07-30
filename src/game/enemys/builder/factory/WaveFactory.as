package game.enemys.builder.factory
{
	import mvc.command.interfaces.ICommandExecutor;
	import mvc.factory.IContentProduct;
	
	import starling.display.DisplayObjectContainer;
	import game.enemys.builder.factory.products.CommandsProduct;
	import game.enemys.builder.factory.products.EnemysViewProduct;
	import game.enemys.builder.factory.comands.IntervalCommandExecuter;

	public class WaveFactory extends AbstractWvaeFactory
	{	
		public function WaveFactory()
		{
		}
		
		override protected function createExecutor():ICommandExecutor
		{
			return new IntervalCommandExecuter(1);
		}
		
		override protected function createCommands(target:DisplayObjectContainer, prod:IContentProduct):IContentProduct
		{
			return new CommandsProduct(target,prod);
		}
		
		override protected function createViewProduct(obj:Object = null):IContentProduct
		{
			return new EnemysViewProduct(obj);
		}
	}
}