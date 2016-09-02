package game.controller
{
	import game.enemys.models.EnemysModel;
	import game.map.models.MapModel;
	import game.models.GameModel;
	
	import mvc.controller.AbstractController;
	import mvc.pool.BulletBaseViewPool;
	
	public class GameController extends AbstractController
	{
		private static var _instance:GameController;
		public static function get instance( ):GameController
		{
			if (_instance == null)
			{
				_instance = new GameController (new PrivateClass());		
			}
			return _instance;
		}
		
		private var gameModel:GameModel;
		
		public function GameController(pvt:PrivateClass)
		{
			super();
			gameModel = GameModel.instance;
		}
		
		public function initGameModels(data:Object):void
		{
			gameModel.reciveGameData(data);
			MapModel.instance.setUpRoads(gameModel.gameData.wayPointDo);
			EnemysModel.instance.provideWaveData(gameModel.gameData.wavesDo);
			EnemysModel.instance.initialize(MapModel.instance.roads[0]);	
			BulletBaseViewPool.instance.fillUp([]);
		}
		
		public function handleGamePouse():void
		{
			if (gameModel.isPoused())
				gameModel.continueGame();
			else
				gameModel.pouseGame();
		}
		
		override public function dispose():void
		{
			gameModel = null;
		}
	}
}
class PrivateClass
{
	public function PrivateClass( )	{}
}