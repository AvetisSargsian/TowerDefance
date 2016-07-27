package mvc.controller
{
	import starling.core.Starling;
	import starling.events.EventDispatcher;
	
	public class AbstractController extends EventDispatcher implements IController
	{
		public function AbstractController()
		{
			super();
		}
		
		public function dispose():void{}
		
		public function advanceTime(time:Number):void{}
		
		public final function startJuggling():void
		{
			Starling.juggler.add(this);
		}
		
		public final function stopJuggling():void
		{
			Starling.juggler.remove(this);
		}
	}
}