package game.enemys.view
{
	import game.enemys.models.UnitModel;
	
	import mvc.view.AbstractView;
	
	import starling.display.Image;
	
	public class UnitBaseView extends AbstractView
	{
		protected var _unitModel:UnitModel
		
		public function UnitBaseView(model:UnitModel)
		{
			super();
			
			this.onAddedToStage = onAdded;
			this.onRemoveFromStage = onRemove;
			
			_unitModel = model;
			_unitModel.registerCallBack(UnitModel.UPDATE,onModelUpdate);
			_unitModel.registerCallBack(UnitModel.DISPOSED,onDispose);
		}
		
		private function onAdded():void
		{
			drawUnit();
			onModelUpdate();
			_unitModel.isOnStage = true;
			_unitModel.bounds = this.bounds;
		}
		
		private function onRemove():void
		{
			_unitModel.removeCallBack(UnitModel.UPDATE,onModelUpdate);
			_unitModel.removeCallBack(UnitModel.DISPOSED,onDispose);
			_unitModel.isOnStage = false;
			_unitModel = null;
		}
		
		protected function drawUnit():void
		{
			var img:Image = new Image(assetManager.getTexture("enemies/enemyA_b_03"));
			addChild(img);
			
			alignPivot();
		}
		
		protected function onDispose():void
		{
//			dispose();
			removeFromParent(true);
		}
		
		protected function onModelUpdate():void
		{
			this.x = _unitModel.x;
			this.y = _unitModel.y;
			this.rotation = _unitModel.rotataionAngle;
		}
	}
}