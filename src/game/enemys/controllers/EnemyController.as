package game.enemys.controllers
{
	import game.enemys.models.EnemysModel;
	import game.enemys.models.UnitModel;
	import game.models.GameModel;
	
	import mvc.controller.AbstractController;
	
	public class EnemyController extends AbstractController
	{
		private static var _instance:EnemyController;
		private var enemysM:EnemysModel;
		
		public static function get instance( ):EnemyController
		{
			if (_instance == null)
			{
				_instance = new EnemyController (new PrivateClass());		
			}
			return _instance;
		}
		
		public function EnemyController(pvt:PrivateClass)
		{
			super();
			
			enemysM = EnemysModel.instance;
		}
		
		public function lunchEnemys():void
		{
			if (!enemysM.isWavesLunched)
			{				
				enemysM.isWavesLunched = true;
				startNewWave(0);
				startJuggling();
			}
		}
		
		public function startNewWave(delay:Number = 2):void
		{
			if (enemysM.isWavesLunched)
				enemysM.addNewWave(delay);
		}
		
		public function resetEnemyModel():void
		{
			enemysM.reset();
		}
		
		public override function advanceTime(time:Number):void
		{
			updateUnits();
		}
		
		public override function dispose():void
		{
			enemysM = null;
			_instance = null;
		}
		
		private function updateUnits():void
		{ 
			for (var i:int = 0,len:int = enemysM.enemyCount(); i < len; ++i) 
			{
				var unit:UnitModel = enemysM.getEnemyByIndex(i);
				if (unit && unit.isOnStage)
				{
					if(unit.isDead)
					{
						unit.dispose();
						enemysM.removEnemyByIndex(i);
					}
					else if(unit.isEscaped)
					{
						GameModel.instance.takeDamage(unit.damage);	
						unit.dispose();
						enemysM.removEnemyByIndex(i);
						
					}else
					{
						unit.move();
					}
				}
			}
			if (len == 0)
			{
				startNewWave();
			}
		}
	}
}
class PrivateClass
{
	public function PrivateClass( ) {}
}