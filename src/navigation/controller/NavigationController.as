package navigation.controller
{
	import flash.utils.getDefinitionByName;
	
	import game.controller.GameController;
	import game.map.models.MapModel;
	import game.scene.mediator.GameSceneMediator;
	
	import loading.model.AssetsModel;
	import loading.scene.mediator.LoadingSceneMediator;
	
	import menu.mediator.MainMenuSceneMediator;
	
	import mvc.controller.AbstractController;
	import mvc.mediator.SceneMediator;
	
	import navigation.model.NavigationModel;
	
	import starling.events.Event;
	
	public class NavigationController extends AbstractController
	{
		private static var _instance:NavigationController;
		private var navModel:NavigationModel;
		private var assetsModel:AssetsModel;
		
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
			navModel = NavigationModel.instance;
			assetsModel = AssetsModel.instance;
			assetsModel.addEventListener(AssetsModel.LOADING_COMPLETE,onLoadingComplete);
			assetsModel.addEventListener(AssetsModel.LOADING_PRECOMPLETE, onLoadingPREComplete);
		}
		
		public function changeScene(sceneDef:String):void
		{	
			switch(sceneDef)
			{
				case Constants.MAIN_MENU_SCENE:
				{
					navModel.nextScene = new MainMenuSceneMediator();
					loadAssets("GUI","mapIcons");
					break;
				}
				case Constants.GAME_SCENE:
				{
					navModel.nextScene = new GameSceneMediator();
					loadAssets(MapModel.instance.mapLoadingName);
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
		
		private function loadAssets(...loads):void
		{
			navModel.curentScene  = new LoadingSceneMediator();
			assetsModel.enqueueAsset(loads);
			assetsModel.loadAssets();
		}
		
		private function onLoadingPREComplete(event:Event = null):void
		{	
			if(NavigationModel.instance.nextScene is GameSceneMediator)
				GameController.instance.initGameModels(AssetsModel.instance.getJSONObject("LevelData"));
		}
		
		//TODO:Add change scene animation class
		private function onLoadingComplete(event:Event = null):void
		{
			var navModel:NavigationModel = NavigationModel.instance;
			navModel.curentScene  = navModel.nextScene;
			navModel.nextScene = null;
		}
		
		override public function dispose():void
		{
			assetsModel.removeEventListener(AssetsModel.LOADING_COMPLETE,onLoadingComplete);
			assetsModel.removeEventListener(AssetsModel.LOADING_PRECOMPLETE, onLoadingPREComplete);
			assetsModel = null;
			navModel = null;
			super.dispose();
		}
	}
}
class PrivateClass
{
	public function PrivateClass( )	{}
}