package game.towers.factory
{
	import game.towers.models.TowerModel;
	import game.towers.models.TowersHolderModel;
	import game.towers.views.mediator.TowerBaseViewMediator;
	
	import mvc.factory.IStartProduct;
	import mvc.mediator.IMediator;
	import mvc.view.BaseView;
	
	import starling.display.DisplayObjectContainer;
	
	public class TowerProductionLine implements IStartProduct
	{
		private var canvas:DisplayObjectContainer;
		private var towerM:TowerModel;
		private var towerBaseViewMediator:IMediator;
		
		public function TowerProductionLine(canvas:DisplayObjectContainer)
		{
			this.canvas = canvas;
			towerM = TowersHolderModel.instance.towerProjection;
			towerBaseViewMediator = new TowerBaseViewMediator(towerM);
		}
		
		public function start():void
		{ 
			towerBaseViewMediator.addToParent(canvas as BaseView);
			dispose();
		}
		
		private function dispose():void
		{
			canvas = null;
			towerM = null;
			towerBaseViewMediator = null;
		}
	}
}