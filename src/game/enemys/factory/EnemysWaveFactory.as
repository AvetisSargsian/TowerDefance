package game.enemys.factory
{
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
			var product:IContentProduct = createProduct(object);			
			var executer:ICommandExecutor = createExecutor();
			executer.loadCommands( createCommands(canvas,product) );
			executer.executeCommand();
		}
		
		private function createExecutor():ICommandExecutor
		{
			return new IntervalCommandExecuter(1);
		}
		
		private function createCommands(target:DisplayObjectContainer, prod:IContentProduct):Vector.<ICommand>
		{
			var array:Array = prod.content as Array;
			var vector:Vector.<ICommand> = new Vector.<ICommand>();
			for (var i:int = 0, len:int = array.length; i < len; ++i) 
			{
				vector.push(new addChildCommand(target,array[i])); 
			}
			return vector;
		}
		
		private function createProduct(obj:Object = null):IContentProduct
		{
			return new EnemysProduct(obj);
		}
	}
}