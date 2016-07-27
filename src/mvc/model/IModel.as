package mvc.model
{
	import mvc.utilinterfaces.IDisposeble;
	
	import starling.animation.IAnimatable;

	public interface IModel extends IAnimatable,IDisposeble
	{
		function reset():void;
	}
}