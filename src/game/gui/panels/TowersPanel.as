 package game.gui.panels
{
	import game.towers.models.TowersHolderModel;
	
	import loading.model.AssetsModel;
	
	import mvc.view.AbstractView;
	
	import starling.display.Image;
	import starling.utils.Color;
	
	public class TowersPanel extends AbstractView
	{
		private var _bg:Image;
		
		public function TowersPanel()
		{
			super();
			
			_bg = new Image(AssetsModel.drawRoundRectTexture(200,140,Color.GRAY));
			_bg.touchable = false;
			
			this.onAddedToStage = onAdded; 
		}
		
		private function onAdded():void
		{
			addChild(_bg);

			var _towerIcon:Image,
				types:Vector.<String> = TowersHolderModel.instance.allowedTowerTypes; 
			for (var i:int = 0,len:int = types.length; i < len; ++i) 
			{
				_towerIcon = new Image(AssetsModel.drawRoundRectTexture(30,30,Color.WHITE * Math.random()));
				_towerIcon.name = types[i];
				addChild(_towerIcon);
				_towerIcon.x = _bg.width/2 - _towerIcon.width/2;
				_towerIcon.y = _bg.y + _towerIcon.height * i + 5;
			}
			_bg = null;
		}
	}
}