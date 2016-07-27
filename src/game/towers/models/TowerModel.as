package game.towers.models
{
	import flash.geom.Point;
	
	import game.enemys.models.UnitModel;
	
	import mvc.model.AbstractModel;
	
	public class TowerModel extends AbstractModel
	{
		
		public static const CHANGE_POSITIONS:String = "changePosition";
		public static const DISPOSED        :String = "disposed";
		public static const BUILDED			:String = "builded";
		public static const SHOOTING		:String = "SHOOT";
		
		protected var _position:Point = new Point(-1,-1);
		protected var _enemysInRange:Vector.<UnitModel>;
		protected var _curentEnemy:UnitModel;
		protected var _maxEnemysInProces:int;
		
		protected var _reloadTime:int;
		protected var _readyToShoot:Boolean = false;
		private var _curentReloadTime:int = 0;
		
		protected var _damage:Number;
		protected var _shootRange:int;
		
		protected var _towerFightStrategy:IFightStrategy;
			
		protected var _buildDistance:int;
		protected var _canBeBuilded:Boolean = false;
		protected var _isBuilded:Boolean = false;
		
		public function TowerModel()
		{
			super();
			_enemysInRange = new Vector.<UnitModel>();
			
			setUpTowerProp();
		}

		public function get damage():Number
		{
			return _damage;
		}

		public function get curentEnemy():UnitModel
		{
			return _curentEnemy;
		}

		public function get shootRange():int
		{
			return _shootRange;
		}

		public function get buildDistance():int
		{
			return _buildDistance;
		}

		public function get canBeBuilded():Boolean
		{
			return _canBeBuilded;
		}

		public function get x():Number
		{
			return _position.x;
		}
		
		public function get y():Number
		{
			return _position.y;
		}
		
		public function get positionPoint():Point
		{
			return _position;
		}
		
		public function needTargets():Boolean
		{
			return _enemysInRange.length < _maxEnemysInProces;
		}
		
		public function addTarget(enemy:UnitModel):void
		{
			if (enemy && isInRange(enemy))
			{
				_enemysInRange.push(enemy);
			}
		}
		
		public function isInRange(enemy:UnitModel):Boolean
		{
			var dist:Number = Point.distance(_position, new Point(enemy.x,enemy.y));
			return dist <= _shootRange;
		}
		
		public function updateForShoot():void
		{
			if(++_curentReloadTime >= _reloadTime)
			{ 
				_curentReloadTime = 0;
				_curentEnemy = _towerFightStrategy.findEnemy(this,_enemysInRange);
				if (_curentEnemy)
					shoot(_curentEnemy);
			}
		}
		
		public function setNewPos(new_x:Number,new_y:Number,roadDist:Number = 0,neiborTowerDist:Number = 0):void
		{
			if (_isBuilded ) return;
			_position.setTo(new_x,new_y);
			_canBeBuilded = checkBuildDistance(roadDist) && checkBuildDistance(neiborTowerDist);
			invokeCallBacks(CHANGE_POSITIONS);
		}
		
		public function build():void
		{
			_isBuilded = true;
			_curentReloadTime = _reloadTime;
			invokeCallBacks(BUILDED);
		}
		
		public override function dispose():void
		{
			invokeCallBacks(DISPOSED);
			super.dispose()
		}
		
		protected function setUpTowerProp():void
		{
			_towerFightStrategy = new TowerFightStrategy();
			_buildDistance = 50;
			_maxEnemysInProces = 3;
			_reloadTime = 30;//count in frames;with 60 frame per second 15 = to 0.25 of second
			_damage = 50;
			_shootRange = 110;
		}
		
		private function shoot(enemy:UnitModel):void
		{
			invokeCallBacks(SHOOTING);
		}
		
		private function checkBuildDistance(dist:Number):Boolean
		{
			return !(dist < _buildDistance); 
		}
	}
}