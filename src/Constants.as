package 
{
	import flash.utils.getQualifiedClassName;
	
	import game.scene.GameScene;
	
	import loading.scene.LoadingScene;
	
	import menu.MainMenuScene;
	import menu.mediator.MainMenuSceneMediator;
	
	import selectmap.scene.SelectMapScene;
	import selectmap.scene.mediator.SelectMapSceneMediator;

	public class Constants 
	{
		public static const MAIN_MENU_SCENE:String  = getQualifiedClassName(MainMenuScene);
		public static const MAIN_MENU_SCENE_BACK:String  = getQualifiedClassName(MainMenuSceneMediator);
		public static const GAME_SCENE:String       = getQualifiedClassName(GameScene);
		public static const SELECT_MAP_SCENE:String = getQualifiedClassName(SelectMapSceneMediator);
		public static const LOADING_SCENE:String    = getQualifiedClassName(LoadingScene);
		
		public static var SOUND_STATUS:Boolean = true;
		public static const STAGE_WIDTH:int  = 1280;
		public static const STAGE_HEIGHT:int = 720;		
	}
}