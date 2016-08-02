package game.gui.panels
{
	import game.controller.GameController;
	import game.enemys.controllers.EnemyController;
	
	import mvc.mediator.AbstractMediator;
	import mvc.view.AbstractView;
	
	import starling.display.Button;
	import starling.events.Event;
	
	public class ButtonsPanelMediator extends AbstractMediator
	{
		private var unitsCont:EnemyController;
		private var gameController:GameController;
		
		public function ButtonsPanelMediator(thisVeiw:AbstractView = null)
		{
			super(thisVeiw);
			
			nativeVIew.addEventListener(Event.TRIGGERED,onButtonPushed);
			unitsCont = EnemyController.instance;
			gameController = GameController.instance;
		}
		
		override public function dispose():void
		{
			nativeVIew.removeEventListener(Event.TRIGGERED,onButtonPushed);
			unitsCont = null;
			gameController = null;
			super.dispose();
		}
		
		override protected function setNativeVIew():AbstractView
		{
			return new ButtonsPanel();
		}
		
		private function onButtonPushed(event:Event):void
		{
			var name:String = (event.target as Button).name;
			switch(name)
			{
				case ButtonsPanel.NEW_WAVE_BUTTON:
				{
					unitsCont.startNewWave(0);
					break;
				}
				case ButtonsPanel.POUSE_BUTTON:
				{	
					gameController.handleGamePouse();
					break;
				}
			}
			event.stopImmediatePropagation();
		}	
	}
}