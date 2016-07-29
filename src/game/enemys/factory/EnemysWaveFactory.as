package game.enemys.factory
{
	import flash.utils.getTimer;
	
	import mvc.command.interfaces.ICommand;
	import mvc.command.interfaces.ICommandExecutor;
	import mvc.factory.IContentProduct;
	import mvc.factory.IFactory;
	
	import starling.display.DisplayObjectContainer;

	public class EnemysWaveFactory implements IFactory
	{	
		public function EnemysWaveFactory()
		{
		}
		
		public final function produce(canvas:DisplayObjectContainer, object:Object = null):void
		{
//			var startTime:Number = getTimer();
//			var took:Number = getTimer() - startTime
//			trace("Time measure", took,"milliseconds");
			
			var viewProduct:IContentProduct = createProduct(object);			
			var executer:ICommandExecutor = createExecutor();
			var commandProduct:IContentProduct = createCommands(canvas, viewProduct);
			executer.loadCommands( Vector.<ICommand>(commandProduct.content as Array) );
			executer.executeCommand();
			viewProduct.dispose();
			commandProduct.dispose();
		}
		
		private function createExecutor():ICommandExecutor
		{
			return new IntervalCommandExecuter(1);
		}
		
		private function createCommands(target:DisplayObjectContainer, prod:IContentProduct):IContentProduct
		{
			return new CommandsProduct(target,prod);
		}
		
		private function createProduct(obj:Object = null):IContentProduct
		{
			return new EnemysProduct(obj);
		}
	}
}