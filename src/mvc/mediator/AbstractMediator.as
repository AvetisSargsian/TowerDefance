package mvc.mediator
{
	import mvc.view.AbstractView;

	public class AbstractMediator implements IMediator
	{
		private var _contextView:AbstractView;
		private var _nativeVIew:AbstractView;
		
		public function AbstractMediator() 
		{
			_nativeVIew = setNativeVIew();
		}
		
		public function dispose():void
		{
			_contextView.removeChild(_nativeVIew);
			_contextView = null;
			_nativeVIew = null;
		}
		
		public final function get nativeVIew():AbstractView	{ return _nativeVIew; }
		public final function get contextView():AbstractView {	return _contextView; }
		
		public final function set contextView(view:AbstractView):void
		{
			if (_contextView) return;
			_contextView = view;
			_contextView.addChild(_nativeVIew);
		}
		
		protected function setNativeVIew():AbstractView
		{
			return new AbstractView();
		}
	}
}