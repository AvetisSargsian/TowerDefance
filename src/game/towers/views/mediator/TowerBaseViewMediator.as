package game.towers.views.mediator
{
	import game.bullets.controllers.AmmunitionController;
	import game.towers.models.TowerModel;
	import game.towers.views.TowerBaseView;
	
	import mvc.mediator.AbstractMediator;
	import mvc.view.AbstractView;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.Color;
	
	public class TowerBaseViewMediator extends AbstractMediator
	{
		private var model:TowerModel;
		private var circuleImg:Image;
		
		public function TowerBaseViewMediator(model:TowerModel)
		{
			super();
			nativeVIew.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			
			this.model = model;
			model.registerCallBack(TowerModel.CHANGE_POSITIONS,onChangePos);
			model.registerCallBack(TowerModel.DISPOSED,onModelDisposed);
			model.registerCallBack(TowerModel.BUILDED,onTowerBuild);
			model.registerCallBack(TowerModel.SHOOTING,towerShoot);
		}
		
		private function onAddedToStage():void
		{
			nativeVIew.removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			circuleImg = nativeVIew.getChildByName(TowerBaseView.RANGE_CIRCUL)as Image;
		}
		
		override public function dispose():void
		{
			model.removeCallBack(TowerModel.CHANGE_POSITIONS,onChangePos);
			model.removeCallBack(TowerModel.DISPOSED,onModelDisposed);
			model.removeCallBack(TowerModel.BUILDED,onTowerBuild);
			model.removeCallBack(TowerModel.SHOOTING,towerShoot);
			model = null;
			
			circuleImg = null;
			
			nativeVIew.removeEventListener(TouchEvent.TOUCH,onTouch);
			
			super.dispose();
		}
		
		override protected function setNativeVIew():AbstractView
		{
			return new TowerBaseView();
		}
		
		private function towerShoot():void
		{
			AmmunitionController.instance.createBullet(model);
		}
		
		private function onTowerBuild():void
		{	
			circuleImg.color = Color.GREEN;
			circuleImg.scale = 1;
			circuleImg.alpha = 0.3;
			circuleImg.visible = false;
			
			nativeVIew.addEventListener(TouchEvent.TOUCH,onTouch);
		}
		
		private function onTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(nativeVIew);
			if (touch && touch.phase == TouchPhase.BEGAN)
			{
				circuleImg.visible = ! circuleImg.visible;
			}
		}
		
		private function onChangePos():void
		{
			nativeVIew.x = model.x;
			nativeVIew.y = model.y;
			
			circuleImg.color = model.canBeBuilded ? Color.GREEN : Color.RED; 
		}
		
		private function onModelDisposed():void
		{
			nativeVIew.removeFromParent(true);
			dispose();
		}
	}
}