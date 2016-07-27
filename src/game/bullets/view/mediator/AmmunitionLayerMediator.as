package game.bullets.view.mediator
{
	import game.bullets.controllers.AmmunitionController;
	import game.bullets.factory.BulletFactory;
	import game.bullets.models.AmmunitionModel;
	
	import mvc.factory.IFactory;
	import mvc.mediator.AbstractMediator;
	import mvc.model.IModel;
	import mvc.view.AbstractView;
	
	import starling.events.Event;
	
	public class AmmunitionLayerMediator extends AbstractMediator
	{
		private var ammoM:AmmunitionModel;
		private var ammoC:AmmunitionController;
		private var bulletFactory:IFactory;
		
		public function AmmunitionLayerMediator()
		{
			super();
			nativeVIew.onAddedToStage = onAdded; 
			
			ammoM = AmmunitionModel.instance;
			ammoM.addEventListener(AmmunitionModel.NEW_BULLET,onNewBulletShooted);
			ammoC = AmmunitionController.instance;
			
			bulletFactory = new BulletFactory();
		}
		
		override public function dispose():void
		{
			ammoM.removeEventListener(AmmunitionModel.NEW_BULLET,onNewBulletShooted);
			ammoM.dispose();
			ammoM = null;
			ammoC.stopJuggling();
			ammoC.dispose();
			ammoC = null;
			bulletFactory = null;
			
			super.dispose();
		}
		
		private function onNewBulletShooted(event:Event):void
		{
			bulletFactory.produce(nativeVIew,event.data as IModel)
		}
		
		private function onAdded():void
		{
			nativeVIew.onAddedToStage = null;
			ammoC.startJuggling();
		}
	}
}