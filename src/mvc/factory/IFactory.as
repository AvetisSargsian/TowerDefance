package mvc.factory
{
	import mvc.model.IModel;
	
	import starling.display.DisplayObjectContainer;

	public interface IFactory
	{
		function produce(canvas:DisplayObjectContainer, model:IModel = null):void
	}
}