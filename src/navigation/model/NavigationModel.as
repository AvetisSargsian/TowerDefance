package navigation.model
{
	import mvc.mediator.AbstractMediator;
	import mvc.model.AbstractModel;
	import mvc.view.BaseView;
	
	public class NavigationModel extends AbstractModel
	{
		public static const NAVIGATION_EVENT:String = "navigationEvent";
		
		private var _curentMediator:AbstractMediator;
		private var _nextMediator:AbstractMediator;
		private var _canvas:BaseView;
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
		
		public function init(displayObject:BaseView):void
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
			_curentMediator.addToParent( _canvas);
		}
	}
}
class PrivateClass
{
	public function PrivateClass( ) 
	{
		
	}
}