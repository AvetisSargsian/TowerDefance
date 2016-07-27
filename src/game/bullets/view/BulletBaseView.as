package game.bullets.view
{
	import game.bullets.models.BulletModel;
	
	import mvc.view.AbstractView;
	
	import starling.display.Shape;
	import starling.events.Event;
	import starling.utils.Color;
	
	public class BulletBaseView extends AbstractView
	{
		private var _model:BulletModel;
		
		public function BulletBaseView(model:BulletModel = null)
		{
			super();
			
			this.onAddedToStage = onAdded;
			this.onRemoveFromStage = onRemove;
			
			_model = model;
			_model.registerCallBack(BulletModel.BULET_UPDATE,onModelUpdate);
			_model.registerCallBack(BulletModel.DISPOSED,onModelDispose);
		}
		
		private function onAdded():void
		{
			drawBullet();
			_model.isOnStage = true;
			_model.bounds = this.bounds;
		}
		
		private function onRemove():void
		{
			_model.removeCallBack(BulletModel.DISPOSED,onModelDispose);
			_model.removeCallBack(BulletModel.BULET_UPDATE,onModelUpdate);
			_model.isOnStage = false;
			_model = null;
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
			this.x = _model.x;
			this.y = _model.y;
//			if (this.bounds.intersects(_model.target.bounds))
//			{
//				trace("BOOM!!!");
//			}
		}
		
		private function onModelDispose():void
		{
			removeFromParent(true);
		}
	}
}