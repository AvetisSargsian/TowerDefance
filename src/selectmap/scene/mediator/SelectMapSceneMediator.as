package selectmap.scene.mediator
{
	import game.map.controllers.MapController;
	
	import mvc.view.AbstractView;
	import mvc.view.mediator.SceneMediator;
	
	import navigation.controller.NavigationController;
	
	import selectmap.scene.SelectMapScene;
	
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class SelectMapSceneMediator extends SceneMediator
	{
		public function SelectMapSceneMediator()
		{
			super();
			nativeVIew.addEventListener(TouchEvent.TOUCH,onTouch);
		}
		
		override public function dispose():void
		{
			nativeVIew.removeEventListener(TouchEvent.TOUCH,onTouch);
			super.dispose();
		}
		
		override protected function setNativeVIew():AbstractView
		{
			return new SelectMapScene();
		}
		
		override protected function onKeyboardBACK():void
		{
			NavigationController.instance.changeScene(Constants.MAIN_MENU_SCENE_BACK);
		}
		
		private function onTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(nativeVIew);
			if (touch && touch.phase == TouchPhase.BEGAN )
			{
				var name:String = touch.target.name; 
				if (name)
				{
					MapController.instance.selectedMapName = name.slice(0,name.indexOf("_icon"));
				}
			}
		}
	}
}