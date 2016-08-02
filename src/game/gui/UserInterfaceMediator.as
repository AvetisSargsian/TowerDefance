package game.gui
{
	import game.gui.panels.ButtonsPanelMediator;
	import game.towers.views.mediator.TowersPanelMediator;
	
	import mvc.mediator.AbstractMediator;
	import mvc.view.AbstractView;
	
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
			buttonsPanelMediator.contextView = nativeVIew;
			
			var towerP:AbstractView = nativeVIew.getChildByName(UserInterface.TOWERS_PANEL) as AbstractView;
			towerPanelMediator = new TowersPanelMediator(towerP);
			towerPanelMediator.contextView = nativeVIew;
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
	}
}