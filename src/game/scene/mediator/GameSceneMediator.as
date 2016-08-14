package game.scene.mediator
{
	import game.bullets.view.mediator.AmmunitionLayerMediator;
	import game.enemys.view.mediator.EnemyLayerMediator;
	import game.gui.UserInterfaceMediator;
	import game.map.controllers.MapController;
	import game.map.models.MapModel;
	import game.models.GameModel;
	import game.scene.GameScene;
	import game.towers.views.mediator.TowerLayerMediator;
	
	import mvc.mediator.AbstractMediator;
	import mvc.mediator.SceneMediator;
	import mvc.view.AbstractView;
	
	import navigation.controller.NavigationController;
	
	import starling.events.Event;
	
	public class GameSceneMediator extends SceneMediator
	{
		private var gameModel:GameModel;
		private var mapModel:MapModel;
		
		private var UIMediator:AbstractMediator;
		private var towerLayerMediator:AbstractMediator;
		private var enemyLayerMediator:AbstractMediator;
		private var ammosLayerMediator:AbstractMediator;
		
		
		public function GameSceneMediator()
		{
			super();
			
			nativeVIew.addEventListener(Event.REMOVED_FROM_STAGE,onRemove);
			nativeVIew.addEventListener(Event.ADDED_TO_STAGE,onAdded);
			
			enemyLayerMediator = new EnemyLayerMediator(); 
			towerLayerMediator = new TowerLayerMediator();
			ammosLayerMediator = new AmmunitionLayerMediator();
			UIMediator = new UserInterfaceMediator();
			
			gameModel = GameModel.instance;
			mapModel = MapModel.instance;
		}
		
		override public function dispose():void
		{
			gameModel = null;
			mapModel = null;
			
			towerLayerMediator.dispose();
			towerLayerMediator = null;
			
			enemyLayerMediator.dispose();
			enemyLayerMediator = null;
			
			ammosLayerMediator.dispose();
			ammosLayerMediator = null;
			
			UIMediator.dispose();
			UIMediator = null;
			
			nativeVIew.removeEventListener(Event.REMOVED_FROM_STAGE,onRemove);
			nativeVIew.removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			
			super.dispose();
		}
		
		override protected function setNativeVIew():AbstractView
		{
			return new GameScene();
		}
		
		override protected function onKeyboardBACK():void
		{
			NavigationController.instance.changeScene(Constants.SELECT_MAP_SCENE);
		}
		
		private function onRemove():void
		{
			MapController.instance.onExitFromGameScene();
		}
		
		private function onAdded():void
		{
			UIMediator.addToParent(nativeVIew);
			towerLayerMediator.addToParent(nativeVIew);
			enemyLayerMediator.addToParent(nativeVIew);
			ammosLayerMediator.addToParent(nativeVIew);
		}
	}
}