package game.towers.views.mediator
{
	import game.towers.controllers.TowerController;
	import game.towers.factory.TowerFactory;
	import game.towers.models.TowersHolderModel;
	
	import mvc.factory.IFactory;
	import mvc.mediator.AbstractMediator;
	
	import starling.events.Event;
	
	public class TowerLayerMediator extends AbstractMediator
	{
		private var factory:IFactory;
		private var towersModel:TowersHolderModel;
		private var towerController:TowerController;
		
		public function TowerLayerMediator()
		{
			super();
			nativeVIew.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			
			factory = new TowerFactory();
			towersModel = TowersHolderModel.instance;
			towersModel.addEventListener(TowersHolderModel.PROJECTION_CREATED,onProjectionCreate);
			towerController = TowerController.instance;
		}
		
		public override function dispose():void
		{
			factory = null;
			
			towersModel = null;
			towerController.stopJuggling();
			towerController = null;
			
			super.dispose();
		}
		
		private function onAddedToStage(event:Event):void
		{
			nativeVIew.removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			towerController.startJuggling();	
		}
		
		private function onProjectionCreate():void
		{
			factory.produce(nativeVIew);
		}
	}
}