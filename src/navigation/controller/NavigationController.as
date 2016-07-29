package navigation.controller
{
	import flash.utils.getDefinitionByName;
	
	import game.controller.GameController;
	import game.map.models.MapModel;
	import game.scene.mediator.GameSceneMediator;
	
	import loading.model.AssetsModel;
	import loading.scene.mediator.LoadingSceneMediator;
	
	import menu.mediator.MainMenuSceneMediator;
	
	import mvc.mediator.SceneMediator;
	
	import navigation.model.NavigationModel;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;
	
	public class NavigationController extends EventDispatcher
	{
		private static var _instance:NavigationController;
		
		public static function get instance( ):NavigationController
		{
			if (_instance == null)
			{
				_instance = new NavigationController (new PrivateClass());		
			}
			return _instance;
		}
		
		public function NavigationController(pvt:PrivateClass)
		{
			super();
		}
		
		public function changeScene(sceneDef:String):void
		{
			var navModel:NavigationModel = NavigationModel.instance,
				assetsModel:AssetsModel = AssetsModel.instance;
				
				assetsModel.addEventListener(AssetsModel.LOADING_COMPLETE,onLoadingComplete);
				assetsModel.addEventListener(AssetsModel.LOADING_PRECOMPLETE, onLoadingPREComplete);
				
			switch(sceneDef)
			{
				case Constants.MAIN_MENU_SCENE:
				{
					navModel.curentScene  = new LoadingSceneMediator();
					navModel.nextScene = new MainMenuSceneMediator();
					assetsModel.enqueueAsset("GUI","mapIcons");
					assetsModel.loadAssets();
					break;
				}
				case Constants.GAME_SCENE:
				{
					assetsModel.enqueueAsset(MapModel.instance.mapLoadingName);
					assetsModel.loadAssets();
					navModel.curentScene  = new LoadingSceneMediator();
					navModel.nextScene = new GameSceneMediator();
					break;
				}
				case Constants.SELECT_MAP_SCENE:
				default:
				{
					var sceneClass:Class = getDefinitionByName(sceneDef) as Class;
					navModel.nextScene  = new sceneClass() as SceneMediator;
					onLoadingPREComplete();
					onLoadingComplete();
					break;
				}
			}
		}
		
		private function onLoadingPREComplete(event:Event = null):void
		{
			if (event)
				event.target.removeEventListener(AssetsModel.LOADING_PRECOMPLETE,onLoadingPREComplete);
			
			if(NavigationModel.instance.nextScene is GameSceneMediator)
			{
				GameController.instance.initGameModels(AssetsModel.instance.getJSONObject("LevelData"));
			}	
		}
		
		//TODO:Add change scene animation class
		private function onLoadingComplete(event:Event = null):void
		{
			if (event)
				event.target.removeEventListener(AssetsModel.LOADING_COMPLETE,onLoadingComplete);
			
			var navModel:NavigationModel = NavigationModel.instance;
			navModel.curentScene  = navModel.nextScene;
			navModel.nextScene = null;
		}
	}
}
class PrivateClass
{
	public function PrivateClass( )	{}
}