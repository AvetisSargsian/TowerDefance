package game.towers.views
{
	import mvc.view.BaseView;
	
	import starling.display.Image;
	import starling.utils.Color;
	
	public class TowerBaseView extends BaseView
	{	
		public static const RANGE_CIRCUL:String = "rangeCircul";
		public function TowerBaseView()
		{
			super();
			
			this.onAddedToStage = onAdded;
		}
		
		public function toString():String
		{
			return this.name;
		}
		
		protected function createGraphics():void
		{	
			var circuleImg:Image = new Image(assetManager.getTexture("200x200"));
			circuleImg.name = RANGE_CIRCUL;
			circuleImg.alignPivot();
			circuleImg.color = Color.GREEN;
			circuleImg.scale = 0.5;
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
	}
}