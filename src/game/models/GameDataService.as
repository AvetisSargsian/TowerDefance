package game.models
{
	import flash.net.SharedObject;
	import flash.utils.getTimer;
	
	import game.map.objects.GeneralInfoDO;
	import game.map.objects.PersedGameData;
	import game.map.objects.SaveDO;
	import game.map.objects.WavesDO;
	import game.map.objects.WayPoinsDO;
	
	import mvc.model.AbstractModel;
	
	public class GameDataService extends AbstractModel
	{		
		public static const SERVICE_DATA_PARSING_COMPLETE:String = "parsingComplete";
		public static const SERVICE_GENERAL_INFO:String = "generalInfo";
		public static const SERVICE_WAY_POINTS:String = "wayPoints";
		public static const SERVICE_WAVES:String = "waves";
		private static var _instance:GameDataService;
		
		public static function get instance( ):GameDataService
		{
			if (_instance == null)
			{
				_instance = new GameDataService (new PrivateClass());		
			}
			return _instance;
		}
		
		private var so:SharedObject;
		
		public function GameDataService(pvt:PrivateClass)
		{
			super();
			so = SharedObject.getLocal("TowerDeance");	
		}
//		============================================================
		public function processLevelXML(parsedObj:Object):PersedGameData
		{	
			var parsedData:PersedGameData = new PersedGameData(),
				generalInfo:GeneralInfoDO = new GeneralInfoDO(),
				wayPoints:WayPoinsDO = new WayPoinsDO(),
				waves:WavesDO = new WavesDO();
			parseData([generalInfo, wayPoints, waves],parsedObj);
			parsedData.generalInfo = generalInfo;
			parsedData.wayPointDo = wayPoints; 
			parsedData.wavesDo = waves;
			
//			var startTime:Number = getTimer();
//			var took:Number = getTimer() - startTime
//			trace("Time measure", took,"milliseconds");
			
			return parsedData; 
		}
//		==========================================================
		private function parseData(array:Array, data:Object):void
		{
			for (var str:String in data)
			{
				for (var i:int = 0,len:int = array.length; i < len ; i++) 
				{
					if (str in array[i])
					{
						array[i][str] = data[str];
						break;
					}
				}
			}	
		}
//		============================================================
		public function loadLcalData():void
		{
//			var saveDO:SaveDO = new SaveDO();
//			so.data.lvlNum == undefined ? saveDO.lvlNum = 0 : saveDO.lvlNum = int(so.data.lvlNum);
//			so.data.soundStatus == undefined ? saveDO.soundStatus = true : saveDO.soundStatus = so.data.soundStatus;
//			dispatchEvent(new ModelEvent(ModelEvent.SERVICE_LOCAL_DATA_LOADED,false,false,saveDO));
		}
//		============================================================
		public function saveLoaclData(saveDO:SaveDO):void
		{
//			so.data.lvlNum = saveDO.lvlNum;
//			so.data.soundStatus = saveDO.soundStatus;
//			so.flush(10000);
		}
	}
}
class PrivateClass
{
	public function PrivateClass( ) 
	{
		
	}
}