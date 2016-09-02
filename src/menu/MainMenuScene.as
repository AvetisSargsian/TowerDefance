package menu
{
	import loading.model.AssetsModel;
	
	import mvc.view.Scene;
	
	import starling.display.Button;
	import starling.display.Quad;
	import starling.utils.Color;
	
	public class MainMenuScene extends Scene
	{
		public function MainMenuScene()
		{
			super();
			this.onAddedToStage = onAdded;
		}
		
		private function onAdded():void
		{
//			stage.color = 0xf0af88;
			var bg_q:Quad = new Quad(Constants.STAGE_WIDTH,Constants.STAGE_HEIGHT,0xf0af88);
			bg_q.touchable = false;
			addChild(bg_q);
			
			
			var btn:Button;
			btn = new Button(AssetsModel.drawRoundRectTexture(200,100,Color.YELLOW),"PLAY GAME");
			btn.name = "playBtn";
			btn.alignPivot();
			btn.x = Constants.STAGE_WIDTH/2;
			btn.y = Constants.STAGE_HEIGHT/2;
			addChild(btn);
		}
	}
}