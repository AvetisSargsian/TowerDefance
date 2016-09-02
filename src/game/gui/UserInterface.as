package game.gui
{
	import game.gui.panels.ButtonsPanel;
	import game.gui.panels.TowersPanel;
	
	import mvc.view.AbstractView;
	
	import starling.display.Button;
	
	public class UserInterface extends AbstractView
	{
		public static const BUTTONS_PANEL:String = "buttonsPanel";
		public static const TOWERS_PANEL:String = "towersPanel";
		public static const ENEMYS_LUNCH_BTN:String = "lunchBtn";
		
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
			
			var lunchBtn:Button = new Button(assetManager.getTexture("nextWaveBtn_l"));
			lunchBtn.name = ENEMYS_LUNCH_BTN;
			lunchBtn.x = 32;
			lunchBtn.y = 350;
			lunchBtn.alignPivot();
			addChild(lunchBtn);
		}
	}
}