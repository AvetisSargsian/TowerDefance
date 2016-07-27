package mvc.mediator
{
	import mvc.utilinterfaces.IDisposeble;
	import mvc.view.AbstractView;

	public interface IMediator extends IDisposeble 
	{
		function get nativeVIew():AbstractView;
		function set contextView(view:AbstractView):void
	}
}