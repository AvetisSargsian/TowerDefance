package flexUnitTests
{
	import flash.utils.getTimer;
	
	import game.enemys.models.UnitModel;
	import game.map.objects.Road;
	import game.map.objects.WayPoint;
	
	import loading.model.AssetsModel;
	
	import mvc.model.AbstractModel;
	
	import org.flexunit.Assert;
	import org.flexunit.assertThat;
	import org.flexunit.async.Async;
	import org.hamcrest.number.lessThan;
	
	import starling.events.Event;

	public class AbstractModelTest
	{	
		private static var abstractModel:AbstractModel;
		private static var unit:UnitModel;

		private var obj:Object;
		
		[Before]
		public function setUp():void
		{
			abstractModel = new AbstractModel();
			var vec:Vector.<WayPoint> = new <WayPoint>[ new WayPoint(10,10,1),
				new WayPoint(102,101,1),
				new WayPoint(110,330,1)];
			var road:Road = new Road(vec);
			unit = new UnitModel(road);
			
//			Async.proceedOnEvent(this,
		}
		
		[After]
		public function tearDown():void
		{
			abstractModel.dispose();
			abstractModel = null;
			unit.dispose();
			unit = null;
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
			
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
			
		}
		
		[Test(async, description="Async Example")]
		public function assetManagerAsyncTest():void 
		{
			obj = new Object();
			obj.repeatCount = 3;
			
			var assyncHandeler:Function = Async.asyncHandler(this,loadingCompleteHandler,1000,obj,testFails);
			var assetsModel:AssetsModel = AssetsModel.instance;
			assetsModel.addEventListener(AssetsModel.LOADING_COMPLETE,assyncHandeler);
			assetsModel.enqueueAsset("GUI","mapIcons");
			assetsModel.loadAssets();
			
		}
		
		private function testFails(passThrouData:Object):void
		{
			Assert.fail( "Timeout reached before event");
		}
		
		private function loadingCompleteHandler(event:Event, passThrouData:Object):void
		{
			Assert.assertEquals(3,passThrouData.repeatCount);
		}
		
		[Test]
		public function testCallbackInvocation():void
		{
			for (var i:int = 0; i < 500; ++i) 
			{
				abstractModel.registerCallBack("message",callBackFunc);
			}
			
			var startTime:Number = getTimer();
			abstractModel.invokeCallBacks("message");
			var took:Number = getTimer() - startTime
			trace("Time measure", took,"milliseconds");
			assertThat(took,lessThan(5));
		}
		
		private function callBackFunc():void
		{
			unit.move();
		}
	}
}