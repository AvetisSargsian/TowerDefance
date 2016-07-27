package game.gui
{
	import loading.model.AssetsModel;
	
	import mvc.view.AbstractView;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.utils.Color;
	
	public class UserInterface extends AbstractView
	{
		private var _pouseButton:Button;
		
		public function UserInterface()
		{
			super();
			
			_pouseButton = new Button(AssetsModel.drawRoundRectTexture(100,50,Color.BLUE),"POUSE");
		}
		
		override protected function onAddedToStage(event:Event):void
		{
			super.onAddedToStage(event);
			
			addChild(_pouseButton);
		}
		
		override protected function onRemoveFromStage(event:Event):void
		{
			super.onRemoveFromStage(event);
		}
		
	}
}