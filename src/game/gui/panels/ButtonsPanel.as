package game.gui.panels
{
	import loading.model.AssetsModel;
	
	import mvc.view.BaseView;
	
	import starling.display.Button;
	import starling.utils.Color;
	
	public class ButtonsPanel extends BaseView
	{
		public static const POUSE_BUTTON:String = "pouseBtn";
		public static const NEW_WAVE_BUTTON:String = "newWaveBtn";
		
		public function ButtonsPanel()
		{
			super();
			this.onAddedToStage = onAdded; 
		}
		
		private function onAdded():void
		{
			var newWaveBtn:Button = new Button(AssetsModel.drawRoundRectTexture(100,50,Color.BLUE),"NEW WAVE");
			newWaveBtn.name = NEW_WAVE_BUTTON;
			addChild(newWaveBtn);
			
			var pouseGameBtn:Button = new Button(AssetsModel.drawRoundRectTexture(100,50,Color.BLUE),"POUSE");
			pouseGameBtn.name = POUSE_BUTTON;
			pouseGameBtn.x = newWaveBtn.x + 100 + 15;
			addChild(pouseGameBtn);
		}
	}
}