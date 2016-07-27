package game.models
{
	import game.map.objects.GeneralInfoDO;
	
	import mvc.model.AbstractModel;
	
	import starling.events.Event;
	import game.map.objects.PersedGameData;
	
	public class GameModel extends AbstractModel
	{
		private static var _instance:GameModel;
		
		public function get gameData():PersedGameData
		{
			return _gameData;
		}

		public function get mapName():String
		{
			return _mapName;
		}

		public function get gameSpeed():Number
		{
			return _gameSpeed;
		}

		public static function get instance( ):GameModel
		{
			if (_instance == null)
			{
				_instance = new GameModel (new PrivateClass());		
			}
			return _instance;
		}
		
		private var _gameService:GameDataService;
		private var _poused:Boolean = false;
		private var _lifeCount:int;
		private var _gameSpeed:Number;
		private var _mapName:String;
		private var _gameData:PersedGameData;
		
		public function GameModel(pvt:PrivateClass)
		{
			super();
			_gameService = GameDataService.instance;
		}
		
		public function pouseGame():void
		{
			_poused = true;
			pouse();
		}
		
		public function continueGame():void
		{
			_poused = false;
			anpouse();
		}
		
		public function isPoused():Boolean
		{
			return _poused;
		}
		
		public function get lifeCount():int
		{
			return _lifeCount;
		}
		
		public function takeDamage(value:int):void
		{
			_lifeCount -= value;
			if (_lifeCount <= 0)
			{
				gameOver();
			}
		}
		
//		private function onParsingCoplete(event:Event):void
//		{
//			_gameService.removeEventListener(GameDataService.SERVICE_DATA_PARSING_COMPLETE,onParsingCoplete);
//			processGenInfo(event.data[GameDataService.SERVICE_GENERAL_INFO]);
// 		}
		
		private function processGenInfo(genInfo:GeneralInfoDO):void
		{
			_mapName = genInfo.mapName;
			_gameSpeed = genInfo.gameSpeed;
			_lifeCount = genInfo.playerLifeCount;
		}
		
		private function gameOver():void
		{
			
		}
		
		private function pouse():void
		{
			
		}
		
		private function anpouse():void
		{
			
		}
		
		public function reciveGameData(data:Object):void
		{
			_gameData = _gameService.processLevelXML(data);
			processGenInfo(_gameData.generalInfo)
		}
	}
}
class PrivateClass
{
	public function PrivateClass( )	{}
}