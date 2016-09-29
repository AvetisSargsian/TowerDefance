package game.gui.panels
{
	import game.towers.controllers.TowerController;
	
	import mvc.mediator.AbstractMediator;
	import mvc.view.BaseView;
	
	import starling.events.Touch;
	import starling.events.TouchEvent;
	
	public class TowersPanelMediator extends AbstractMediator
	{
		public function TowersPanelMediator(thisView:BaseView = null)
		{
			super(thisView);
			nativeVIew.addEventListener(TouchEvent.TOUCH,onTouch);
		}
		
		override public function dispose():void
		{
			nativeVIew.removeEventListener(TouchEvent.TOUCH,onTouch);
			super.dispose();
		}
		
		override protected function setNativeVIew():BaseView
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