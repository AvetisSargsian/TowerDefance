package game.controller
{
	import game.enemys.models.EnemysModel;
	import game.map.models.MapModel;
	import game.models.GameModel;
	
	import mvc.controller.AbstractController;
	
	public class GameController extends AbstractController
	{
		private static var _instance:GameController;
		private var _gameModel:GameModel;
		
		
		public static function get instance( ):GameController
		{
			if (_instance == null)
			{
				_instance = new GameController (new PrivateClass());		
			}
			return _instance;
		}
		
		public function GameController(pvt:PrivateClass)
		{
			super();
			_gameModel = GameModel.instance;
		}
		
		public function initGameModels(data:Object):void
		{
			_gameModel.reciveGameData(data);
			MapModel.instance.setUpRoads(_gameModel.gameData.wayPointDo);
			EnemysModel.instance.provideWaveData(_gameModel.gameData.wavesDo);
			EnemysModel.instance.initialize(MapModel.instance.roads[0]);			
		}
		
		public function handleGamePouse():void
		{
			if (_gameModel.isPoused())
				_gameModel.continueGame();
			else
				_gameModel.pouseGame();
		}
		
		override public function dispose():void
		{
			
			super.dispose();
		}
		
	}
}
class PrivateClass
{
	public function PrivateClass( )	{}
}