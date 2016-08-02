package game.models
{
	import game.map.objects.GeneralInfoDO;
	import game.map.objects.PersedGameData;
	
	import mvc.model.AbstractModel;
	
	import starling.animation.Juggler;
	import starling.core.Starling;
	
	public class GameModel extends AbstractModel
	{
		private static var _instance:GameModel;

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
		private var _jugler:Juggler;
		
		public function GameModel(pvt:PrivateClass)
		{
			super();
			_gameService = GameDataService.instance;
			_jugler = new Juggler();
			anpouse();
		}
		
		public function get jugler():Juggler
		{
			return _jugler;
		}
		
		public function get gameData():PersedGameData
		{
			return _gameData;
		}
		
		public function get gameSpeed():Number
		{
			return _gameSpeed;
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
		
		public function reciveGameData(data:Object):void
		{
			_gameData = _gameService.processLevelXML(data);
			processGenInfo(_gameData.generalInfo)
		}
		
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
			Starling.juggler.remove(_jugler);	
		}
		
		private function anpouse():void
		{
			Starling.juggler.add(_jugler);
		}
	}
}
class PrivateClass
{
	public function PrivateClass( )	{}
}