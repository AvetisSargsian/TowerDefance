package game.enemys.models
{
	import game.map.objects.Road;
	import game.map.objects.Wave;
	import game.map.objects.WavesDO;
	
	import mvc.model.AbstractModel;
	
	import starling.core.Starling;
	
	public class EnemysModel extends AbstractModel
	{
		private static var _instance:EnemysModel;
		public static function get instance():EnemysModel
		{
			if (_instance == null)
				_instance = new EnemysModel (new PrivateClass());		
			return _instance;
		}
		
		public static const NEW_WAVE_ADDED:String = "startNewWave";
		public static const NO_ENEMY_LEFT:String = "noEnemyLeft";
		
		private var _isWavesLunched:Boolean = false;
		private var _newWave:Wave;
		private var _enemysInProgress:Vector.<UnitModel>;
		
		private var _waves:Vector.<Wave>;
		
		 
		public function EnemysModel(pvt:PrivateClass)
		{
			super();
			_waves = new Vector.<Wave>();
			_enemysInProgress = new Vector.<UnitModel>();
		}	
		
		public function get isWavesLunched():Boolean
		{
			return _isWavesLunched;
		}
		
		public function set isWavesLunched(value:Boolean):void
		{
			_isWavesLunched = value;
		}
		
		public function get newWave():Wave
		{
			return _newWave;
		}
		
		public function enemyCount():int
		{
			return _enemysInProgress.length;
		}
		
		public function removEnemyByLinc(enemy:UnitModel):void
		{
			var index:int = _enemysInProgress.indexOf(enemy);
			if(index > -1) 
				_enemysInProgress.removeAt(index);
		}
		
		public function removEnemyByIndex(index:uint):void
		{
			if (index < _enemysInProgress.length)
				_enemysInProgress.splice(index, 1);
		}
		
		public function getEnemyByIndex(index:uint):UnitModel
		{
			return (index < _enemysInProgress.length) ? _enemysInProgress[index] : null;
		}
		
		public function addNewWave(delay:int = 2):void
		{
			if (_waves.length > 0)
			{
				_newWave = _waves.shift();
				_enemysInProgress = _enemysInProgress.concat(_newWave.enemys);
				Starling.juggler.delayCall(newWaveMessage,delay);
			}
			else if (_enemysInProgress.length == 0)
			{
				dispatchEventWith(EnemysModel.NO_ENEMY_LEFT);
			}
		}
		
		public function initialize(road:Road):void
		{
			for (var i:int = 0,len:int = _waves.length; i < len; ++i) 
			{
				_waves[i].road = road;
			}
		}
		
		public function provideWaveData(wavesDO:WavesDO):void
		{
			_waves = wavesDO.getWaves();
			_waves.fixed = false;
		}
		
		private function newWaveMessage():void
		{
			dispatchEventWith(EnemysModel.NEW_WAVE_ADDED);
		}
	}
}
class PrivateClass
{
	public function PrivateClass( )	{}
}