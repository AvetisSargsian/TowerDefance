package game.bullets.view
{
	import game.bullets.models.BulletModel;
	
	import mvc.view.AbstractView;
	
	import starling.display.Shape;
	import starling.utils.Color;
	
	public class BulletBaseView extends AbstractView
	{
		private var model:BulletModel;
		
		public function BulletBaseView(model:BulletModel = null)
		{
			super();
			
			this.onAddedToStage = onAdded;
			
			assignModel(model);
		}
		
		public function assignModel(model:BulletModel):void
		{
			if (model)
			{
				this.model = model;
				this.model.registerCallBack(BulletModel.BULET_UPDATE,onModelUpdate);
				this.model.registerCallBack(BulletModel.REACHED_TARGET,onReachedTarget);
				onModelUpdate();
			}
		}
		
		override public function dispose():void
		{
			removeModel();
			removeFromParent();
			super.dispose();
		}
		
		private function onAdded():void
		{
			drawBullet();
			model.isOnStage = true;
//			_model.bounds = this.bounds;
		}
		
		protected  function drawBullet():void
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill(Color.SILVER);
			shape.graphics.drawCircle(0,0,2);
			shape.graphics.endFill();
			addChild(shape);
		}
		
		protected function onModelUpdate():void
		{
			this.x = model.x;
			this.y = model.y;
			
//			if (this.bounds.intersects(_model.target.bounds))
//			{
//				trace("BOOM!!!");
//			}
		}
		
		private function onReachedTarget():void
		{
			model.isOnStage = false;
			removeModel();
			removeFromParent();
		}
		
		private function removeModel():void
		{
			if (model)
			{
				model.removeCallBack(BulletModel.REACHED_TARGET,onReachedTarget);
				model.removeCallBack(BulletModel.BULET_UPDATE,onModelUpdate);
				model = null;
			}
		}
	}
}