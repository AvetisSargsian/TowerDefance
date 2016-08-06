package game.towers.views
{
	import game.bullets.controllers.AmmunitionController;
	import game.towers.models.TowerModel;
	
	import mvc.view.AbstractView;
	
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.Color;
	
	public class TowerBaseView extends AbstractView
	{	
		private var model:TowerModel;
		private var circuleImg:Image;
		
		public function TowerBaseView(model:TowerModel)
		{
			super();
			
			this.onAddedToStage = onAdded;
			this.onRemoveFromStage = onRemove;
			
			this.model = model;
			model.registerCallBack(TowerModel.CHANGE_POSITIONS,onChangePos);
			model.registerCallBack(TowerModel.DISPOSED,onModelDisposed);
			model.registerCallBack(TowerModel.BUILDED,onTowerBuild);
			model.registerCallBack(TowerModel.SHOOTING,towerShoot);
		}
		
		public function toString():String
		{
			return this.name;
		}
		
		protected function towerShoot():void
		{
			AmmunitionController.instance.createBullet(model);
		}
		
		protected function createGraphics():void
		{
			circuleImg = new Image(assetManager.getTexture("100x100"));
			circuleImg.alignPivot();
			circuleImg.color = Color.GREEN;
			addChild(circuleImg);
			
			var towerIcon:Image = new Image(assetManager.getTexture("Archer_Tower"));
			towerIcon.alignPivot();
			towerIcon.y = -30;
			addChild(towerIcon);
		}
		
		private function onAdded():void
		{
			createGraphics();
		}
		
		private function onRemove():void
		{
			model.removeCallBack(TowerModel.CHANGE_POSITIONS,onChangePos);
			model.removeCallBack(TowerModel.DISPOSED,onModelDisposed);
			model.removeCallBack(TowerModel.BUILDED,onTowerBuild);
			model.removeCallBack(TowerModel.SHOOTING,towerShoot);
			model = null;
			circuleImg = null;
			
			removeEventListener(TouchEvent.TOUCH,onTouch);
		}
		
		private function onTowerBuild():void
		{	
			removeChild(circuleImg);
			circuleImg = new Image(assetManager.getTexture("200x200"));
			circuleImg.alignPivot();
			circuleImg.alpha = 0.3;
			circuleImg.color = Color.GREEN;
			addChildAt(circuleImg,0);
			circuleImg.visible = false;

			addEventListener(TouchEvent.TOUCH,onTouch);
		}
		
		private function onTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(this);
			if (touch && touch.phase == TouchPhase.BEGAN)
			{
				circuleImg.visible = ! circuleImg.visible;
			}
		}
		
		private function onChangePos():void
		{
			this.x = model.x;
			this.y = model.y;
			
			circuleImg.color = model.canBeBuilded ? Color.GREEN : Color.RED; 
		}
		
		private function onModelDisposed():void
		{
			removeFromParent(true);
		}
	}
}