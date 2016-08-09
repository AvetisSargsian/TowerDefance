package navigation.model
{
	import mvc.mediator.AbstractMediator;
	import mvc.view.AbstractView;
	
	import starling.events.EventDispatcher;
	
	public class NavigationModel extends EventDispatcher
	{
		public static const NAVIGATION_EVENT:String = "navigationEvent";
		
		private var _curentMediator:AbstractMediator;
		private var _nextMediator:AbstractMediator;
		private var _canvas:AbstractView;
		private static var _instance:NavigationModel;
		
		public static function get instance( ):NavigationModel
		{
			if (_instance == null)
			{
				_instance = new NavigationModel (new PrivateClass());		
			}
			return _instance;
		}
				
		public function NavigationModel(pvt:PrivateClass)
		{
			super();
		}
		
		public function init(displayObject:AbstractView):void
		{
			if (_canvas == null)
				_canvas = displayObject;
		}
		
		public function get nextScene():AbstractMediator
		{
			return _nextMediator;
		}
		
		public function set nextScene(value:AbstractMediator):void
		{
			_nextMediator = value;
		}

		public function get curentScene():AbstractMediator
		{
			return _curentMediator;
		}

		public function set curentScene(value:AbstractMediator):void
		{
			if (_curentMediator)
			{
				_curentMediator.dispose();
			}
			
			_curentMediator = value;
			_curentMediator.contextView = _canvas; 
		}
	}
}
class PrivateClass
{
	public function PrivateClass( ) 
	{
		
	}
}