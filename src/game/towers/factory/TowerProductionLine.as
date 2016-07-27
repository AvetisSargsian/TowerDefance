package game.towers.factory
{
	import mvc.factory.IProdactionLine;
	import game.towers.models.TowerModel;
	import game.towers.models.TowersHolderModel;
	import game.towers.views.TowerBaseView;
	
	import starling.display.DisplayObjectContainer;
	
	public class TowerProductionLine implements IProdactionLine
	{
		private var _canvas:DisplayObjectContainer;
		private var _towerM:TowerModel;
		private var _towerBaseView:TowerBaseView;
		
		public function TowerProductionLine(canvas:DisplayObjectContainer)
		{
			_canvas = canvas;
			_towerM = TowersHolderModel.instance.towerProjection;
			_towerBaseView = new TowerBaseView(_towerM);
		}
		
		public function start():void
		{
			_canvas.addChild(_towerBaseView);
			dispose();
		}
		
		private function dispose():void
		{
			_canvas = null;
			_towerM = null;
			_towerBaseView = null;
		}
	}
}