package game.enemys.view
{
	import game.enemys.models.UnitModel;
	
	import mvc.view.BaseView;
	
	import starling.display.Image;
	
	public class UnitBaseView extends BaseView
	{
		protected var unitModel:UnitModel
		
		public function UnitBaseView(model:UnitModel = null)
		{
			super();
			
			this.onAddedToStage = onAdded;
			this.onRemoveFromStage = onRemove;
			
			assignModel(model);
		}
		
		public function assignModel(model:UnitModel):void
		{
			if (model)
			{
				unitModel = model;
				unitModel.registerCallBack(UnitModel.UPDATE,onModelUpdate);
				unitModel.registerCallBack(UnitModel.DISPOSED,onDispose);
			}
		}
		
		protected function drawUnit():void
		{
			var img:Image = new Image(assetManager.getTexture("enemies/enemyA_b_03"));
			addChild(img);
			
			alignPivot();
		}
		
		protected function onDispose():void
		{
			removeFromParent();
		}
		
		protected function onModelUpdate():void
		{
			this.x = unitModel.x;
			this.y = unitModel.y;
			this.rotation = unitModel.rotataionAngle;
		}
		
		private function removeModel():void
		{
			if(unitModel)
			{
				unitModel.removeCallBack(UnitModel.UPDATE,onModelUpdate);
				unitModel.removeCallBack(UnitModel.DISPOSED,onDispose);
				unitModel = null;
			}
		}
		
		private function onAdded():void
		{
			drawUnit();
			onModelUpdate();
			unitModel.isOnStage = true;
//			unitModel.bounds = this.bounds;
		}
		
		private function onRemove():void
		{
			unitModel.isOnStage = false;
			removeModel();
		}
	}
}