package menu
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import loading.model.AssetsModel;
	
	import navigation.controller.NavigationController;
	
	import starling.display.Button;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.utils.Color;
	import mvc.view.Scene;
	
	public class MainMenuScene extends Scene
	{
		public function MainMenuScene()
		{
			super();
			this.onAddedToStage = onAdded;
		}
		
		private function onAdded():void
		{
			var q:Quad = new Quad(Constants.STAGE_WIDTH,Constants.STAGE_HEIGHT,0xf0af88);
			addChild(q);
			
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