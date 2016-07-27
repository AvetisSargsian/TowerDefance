package game.towers.views
{
	import game.bullets.controllers.AmmunitionController;
	import game.towers.models.TowerModel;
	
	import loading.model.AssetsModel;
	
	import mvc.view.AbstractView;
	
	import starling.display.Image;
	import starling.display.Shape;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.Color;
	
	public class TowerBaseView extends AbstractView
	{	
		private var _model:TowerModel;
		private var distanceCircule:Shape;
		
		public function TowerBaseView(model:TowerModel)
		{
			super();
			
			this.onAddedToStage = onAdded;
			this.onRemoveFromStage = onRemove;
			
			_model = model;
			_model.registerCallBack(TowerModel.CHANGE_POSITIONS,onChangePos);
			_model.registerCallBack(TowerModel.DISPOSED,onModelDisposed);
			_model.registerCallBack(TowerModel.BUILDED,onTowerBuild);
			_model.registerCallBack(TowerModel.SHOOTING,towerShoot);
			distanceCircule = new Shape();
		}
		
		public function toString():String
		{
			return this.name;
		}
		
		private function onAdded():void
		{
			addChild(distanceCircule);
			createGraphic();
		}
		
		private function onRemove():void
		{
			_model.removeCallBack(TowerModel.CHANGE_POSITIONS,onChangePos);
			_model.removeCallBack(TowerModel.DISPOSED,onModelDisposed);
			_model.removeCallBack(TowerModel.BUILDED,onTowerBuild);
			_model.removeCallBack(TowerModel.SHOOTING,towerShoot);
			_model = null;
			removeEventListener(TouchEvent.TOUCH,onTouch);
		}
		
		protected function towerShoot():void
		{
			AmmunitionController.instance.createBullet(_model);
		}
		
		protected function createGraphic():void
		{
			var _towerIcon:Image = new Image(AssetsModel.drawRoundRectTexture(30,30,Color.BLUE));
			_towerIcon.alignPivot();
			addChild(_towerIcon);
		}
		
		private function drawCircule(radius:Number, color:uint):void
		{
			distanceCircule.graphics.clear();
			distanceCircule.graphics.lineStyle(0);
			distanceCircule.graphics.beginFill(color,.5);
			distanceCircule.graphics.drawCircle(0, 0, radius);
			distanceCircule.graphics.endFill();
		}
		
		
		private function onTowerBuild():void
		{
			distanceCircule.visible = false;
			drawCircule(_model.shootRange, Color.GREEN)

			addEventListener(TouchEvent.TOUCH,onTouch);
		}
		
		private function onTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(this);
			if (touch && touch.phase == TouchPhase.BEGAN)
			{
				drawShootRange();
			}
		}
		
		private function drawShootRange():void
		{
			distanceCircule.visible = ! distanceCircule.visible
		}
		
		private function onChangePos():void
		{
			this.x = _model.x;
			this.y = _model.y;
			
			var color:uint = _model.canBeBuilded ? Color.GREEN : Color.RED; 
			drawCircule(_model.buildDistance,color);
		}
		
		private function onModelDisposed():void
		{
			removeFromParent(true);
		}
	}
}