package game.map.controllers
{
	import game.map.models.MapModel;
	
	import loading.model.AssetsModel;
	
	import mvc.controller.AbstractController;
	
	import navigation.controller.NavigationController;
	
	public class MapController extends AbstractController
	{
		private static var _instance:MapController;
		
		public static function get instance( ):MapController
		{
			if (_instance == null)
			{
				_instance = new MapController (new PrivateClass());		
			}
			return _instance;
		}
		
		public function MapController(pvt:PrivateClass)
		{
			super();
		}
		
		public function set selectedMapName(name:String):void
		{
//			var preload:Boolean = name != MapModel.instance.mapName;
			MapModel.instance.mapName = name;
			NavigationController.instance.changeScene(Constants.GAME_SCENE);//preload
		}
		
		public function onExitFromGameScene():void
		{
			AssetsModel.instance.removeTexture(MapModel.instance.mapName);
			MapModel.instance.mapName = "";
		}
	}
}
class PrivateClass
{
	public function PrivateClass( ) 
	{
		
	}
}