package game.scene
{
	import game.debugview.WayPointDebugLayer;
	import game.map.models.MapModel;
	
	import mvc.view.Scene;
	
	import starling.display.Image;
	
	public class GameScene extends Scene
	{
		private var mapModel:MapModel;
		
		public function GameScene()
		{
			super();
			
			mapModel = MapModel.instance;
				
			this.onAddedToStage = onAdded;
		}	
		
		private function onAdded():void
		{
			var bg:Image = new Image(assetManager.getTexture(mapModel.mapName));
			addChild(bg);
			mapModel = null;
			
			CONFIG::map_dev
			{
//				var roadDebugLayer:WayPointDebugLayer = new WayPointDebugLayer();
//				addChild(roadDebugLayer);
			}
		}
	}
}