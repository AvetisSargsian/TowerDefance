package
{
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	import navigation.StarlingRootDisplayObject;
	
	import starling.core.Starling;
	import starling.events.Event;
	
	[SWF(backgroundColor="#000")]
	public class TowerDefance extends Sprite
	{
		private var myStarling:Starling;
		
		public function TowerDefance()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.frameRate = 60;
			
			var iOS:Boolean = Capabilities.manufacturer.indexOf("iOS") != -1;
			Starling.multitouchEnabled = true;
			Starling.handleLostContext = !iOS;
			
			if(this.stage) this.init();
			else this.addEventListener(flash.events.Event.ADDED_TO_STAGE, this.init);
			
			NativeApplication.nativeApplication.addEventListener(
				flash.events.Event.ACTIVATE, function (e:*):void {	myStarling.start() });
			
			NativeApplication.nativeApplication.addEventListener(
				flash.events.Event.DEACTIVATE, function (e:*):void { myStarling.stop() });
			
//			NativeApplication.nativeApplication.addEventListener(flash.events.Event.EXITING, function (e:*):void{});
		}
		
		private function init(event:flash.events.Event = null):void
		{
			removeEventListener(flash.events.Event.ADDED_TO_STAGE, this.init);
//			var viewPort:Rectangle = RectangleUtil.fit( new Rectangle(0, 0, Constants.STAGE_WIDTH, Constants.STAGE_HEIGHT), 
//				new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight),	ScaleMode.SHOW_ALL);
			
			var viewPort:Rectangle = new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight);
			
			myStarling = new Starling(StarlingRootDisplayObject, stage, viewPort);
			viewPort = null;
			myStarling.showStats = true;
			myStarling.stage.stageWidth  = Constants.STAGE_WIDTH;
			myStarling.stage.stageHeight = Constants.STAGE_HEIGHT;
			myStarling.simulateMultitouch = true;
			myStarling.antiAliasing = 1;
			
			myStarling.addEventListener(starling.events.Event.ROOT_CREATED, 
				function(event:Object, app:StarlingRootDisplayObject):void
				{	
					myStarling.removeEventListener(starling.events.Event.ROOT_CREATED, arguments.callee);
					stage.color = 0x000000;
					myStarling.start();
					
					trace("Starling stage size",myStarling.stage.stageWidth,myStarling.stage.stageHeight)
					trace("Stage full screen",stage.fullScreenWidth,stage.fullScreenHeight)
					
				});
		}
	}
}