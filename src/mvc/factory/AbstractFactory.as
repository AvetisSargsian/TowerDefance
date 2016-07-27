package mvc.factory
{
	import flash.errors.IllegalOperationError;
	
	import mvc.model.IModel;
	
	import starling.display.DisplayObjectContainer;
	import starling.events.EventDispatcher;
	
	public class AbstractFactory extends EventDispatcher implements IFactory
	{	
		public function AbstractFactory()
		{
			super();
		}
		
		public final function produce(canvas:DisplayObjectContainer, model:IModel = null):void
		{
			var prodactionLine:IProdactionLine = createProdactionLine(canvas,model);
			prodactionLine.start();
		}
		
		protected function createProdactionLine(canvas:DisplayObjectContainer,model:IModel = null):IProdactionLine
		{
			throw new IllegalOperationError("Abstract method: must be overridden in a subclass");
			return null;
		}
	}
}