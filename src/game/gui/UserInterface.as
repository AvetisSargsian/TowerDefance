package game.gui
{
	import game.gui.panels.ButtonsPanel;
	import game.towers.views.TowersPanel;
	
	import mvc.view.AbstractView;
	
	public class UserInterface extends AbstractView
	{
		public static const BUTTONS_PANEL:String = "buttonsPanel";
		public static const TOWERS_PANEL:String = "towersPanel";
		
		public function UserInterface()
		{
			super();
			this.onAddedToStage = onAdded;
		}
		
		private function onAdded():void
		{
			var btnPanel:ButtonsPanel = new ButtonsPanel();
			btnPanel.name = BUTTONS_PANEL;
			btnPanel.x = 10;
			btnPanel.y = 20;
			addChild(btnPanel);
			
			var towersPanel:TowersPanel = new TowersPanel();
			towersPanel.name = TOWERS_PANEL;
			addChild(towersPanel);
			towersPanel.x = Constants.STAGE_WIDTH - towersPanel.width - 10;
		}
	}
}