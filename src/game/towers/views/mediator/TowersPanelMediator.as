package game.towers.views.mediator
{
	import game.towers.controllers.TowerController;
	import game.towers.views.TowersPanel;
	
	import mvc.mediator.AbstractMediator;
	import mvc.view.AbstractView;
	
	import starling.events.Touch;
	import starling.events.TouchEvent;
	
	public class TowersPanelMediator extends AbstractMediator
	{
		public function TowersPanelMediator(thisView:AbstractView = null)
		{
			super(thisView);
			nativeVIew.addEventListener(TouchEvent.TOUCH,onTouch);
		}
		
		override public function dispose():void
		{
			nativeVIew.removeEventListener(TouchEvent.TOUCH,onTouch);
			super.dispose();
		}
		
		override protected function setNativeVIew():AbstractView
		{
			return new TowersPanel();
		}
		
		private function onTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(nativeVIew);
			if (touch)
			{
				TowerController.instance.handlePanelTouch(touch);
			}
		}
	}
}