package game.gui
{
	import game.enemys.controllers.EnemyController;
	import game.gui.panels.ButtonsPanelMediator;
	import game.gui.panels.TowersPanelMediator;
	
	import mvc.mediator.AbstractMediator;
	import mvc.view.AbstractView;
	
	import starling.display.Button;
	import starling.events.Event;
	
	public class UserInterfaceMediator extends AbstractMediator
	{
		private var buttonsPanelMediator:AbstractMediator;
		private var towerPanelMediator:AbstractMediator;
		
		public function UserInterfaceMediator(thisView:AbstractView=null)
		{
			super(thisView);
			
			nativeVIew.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		private function onAddedToStage():void
		{
			nativeVIew.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			
			var btnPan:AbstractView = nativeVIew.getChildByName(UserInterface.BUTTONS_PANEL) as AbstractView; 
			buttonsPanelMediator = new ButtonsPanelMediator(btnPan);
			
			var towerP:AbstractView = nativeVIew.getChildByName(UserInterface.TOWERS_PANEL) as AbstractView;
			towerPanelMediator = new TowersPanelMediator(towerP);
			
			///temp code, refactor after in separate panel and Mediator
			var lunchBtn:Button = nativeVIew.getChildByName(UserInterface.ENEMYS_LUNCH_BTN) as Button;
			lunchBtn.addEventListener(Event.TRIGGERED,startEnemysWaves);
		}
		
		override public function dispose():void
		{
			buttonsPanelMediator.dispose();
			buttonsPanelMediator = null;
			
			towerPanelMediator.dispose();
			towerPanelMediator = null;
			
			super.dispose();
		}
		
		override protected function setNativeVIew():AbstractView
		{
			return new UserInterface();
		}
		
		
		private function startEnemysWaves(event:Event):void
		{
			var lunchBtn:Button = event.target as Button;
			lunchBtn.removeEventListener(Event.TRIGGERED,startEnemysWaves);
			lunchBtn.visible = false;
			EnemyController.instance.lunchEnemys();
		}
		
	}
}