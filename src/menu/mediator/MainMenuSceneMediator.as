package menu.mediator
{
	import menu.MainMenuScene;
	
	import mvc.view.AbstractView;
	import mvc.view.mediator.SceneMediator;
	
	import navigation.controller.NavigationController;
	
	import starling.display.Button;
	import starling.events.Event;
	
	public class MainMenuSceneMediator extends SceneMediator
	{
		public function MainMenuSceneMediator()
		{
			super();
			nativeVIew.addEventListener(Event.TRIGGERED, mainMenuClickEvent);
		}
		
		override public function dispose():void
		{
			nativeVIew.removeEventListener(Event.TRIGGERED, mainMenuClickEvent);
			super.dispose();
		}
		
		override protected function setNativeVIew():AbstractView
		{
			return new MainMenuScene();
		}
		
		override protected function onKeyboardBACK():void
		{
			
		}
		
		private function mainMenuClickEvent(event:Event):void
		{
			var name:String = (event.target as Button).name;
			switch(name)
			{
				case "playBtn":
					NavigationController.instance.changeScene(Constants.SELECT_MAP_SCENE);
					break;
			}
		}
	}
}