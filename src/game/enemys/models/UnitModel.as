package game.enemys.models
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import game.map.objects.Road;
	import game.map.objects.WayPoint;
	
	import mvc.model.AbstractModel;
	
	public class UnitModel extends AbstractModel
	{
		public static const UPDATE:String = "update";
		public static const DISPOSED:String = "disposed";
		
		protected const MEDIUM:Number = 1;
		protected const SLOW:Number = MEDIUM * 0.5;
		protected const FAST:Number = MEDIUM / 0.5;;
			
		protected var _helth:Number;
		protected var _speed:Number;
		protected var _animState:int;
		protected var _road:Road;
		protected var _damage:int;
		protected var _isEscaped:Boolean = false;
		protected var _position:Point;
		protected var _rotataionAngle:Number = 0;
		
		private var _viewWidth:Number;
		private var _viewHeight:Number;
		private var _destination:Point;
		private var _curentWayPointIndex:int = 0;
		private var _destVector:Point;
		private var _isOnStage:Boolean = false;
		
		public function UnitModel(road:Road)
		{
			super();
			
			setHelthSpeedDamage();
			init(road);
		}

		public function get damage():int
		{
			return _damage;
		}

		public function get bounds():Rectangle
		{
			return new Rectangle(_position.length, _position.y, _viewWidth, _viewHeight);
		}

		public function set bounds(value:Rectangle):void
		{
			_viewWidth  = value.width;
			_viewHeight = value.height;
		}

		public function get rotataionAngle():Number
		{
			return _rotataionAngle;
		}

		public function get isOnStage():Boolean
		{
			return _isOnStage;
		}

		public function set isOnStage(value:Boolean):void
		{
			_isOnStage = value;
		}

		public function get animState():int
		{
			return _animState;
		}

		public function get y():Number
		{
			return _position.y;
		}

		public function get x():Number
		{
			return _position.x;
		}

		public function get speed():Number
		{
			return _speed;
		}

		public function get helth():Number
		{
			return _helth;
		}
		
		public function get isDead():Boolean
		{
			return _helth <= 0;
		}
		
		public function takeDamadge(value:Number):void
		{
			_helth -= value;
		}
		
		public function get isEscaped():Boolean
		{
			return _isEscaped;
		}
		
		public override function dispose():void
		{
			_road = null;
			_destination = null;
			_position = null;
			_destVector = null;
			invokeCallBacks(UnitModel.DISPOSED);
		} 
		
		public function move():void
		{
			makeStep();
		}	
		
		protected function makeStep():void
		{
			if (_destination) 
			{
				var	curentDist:Number = Point.distance(_destination,_position),
					dX:Number =  _speed * Math.cos(_rotataionAngle),
					dY:Number =  _speed * Math.sin(_rotataionAngle);
				
				if ( curentDist <= _speed )
				{
					_position.setTo(_destination.x, _destination.y);
					findeNewDestination();
				}
				else
				{
					_position.offset(dX, dY);
					invokeCallBacks(UnitModel.UPDATE);
				} 
			}
		}
		
		protected function update():void
		{
			dispatchEventWith(UnitModel.UPDATE);
		}
		
		protected function setHelthSpeedDamage():void
		{
			_speed = MEDIUM;
			_helth = 100;
			_damage = 2; 
		}
		
		protected function findeNewDestination():void
		{
			var wPoint:WayPoint = _road.getPointByIndex(++_curentWayPointIndex);	
			if (wPoint)
			{
				_destination.setTo(wPoint.x, wPoint.y);
				_destVector = _destination.subtract(_position);
				_rotataionAngle = Math.atan2(_destVector.y,_destVector.x);
				
			}else
			{
				_destination = null;
				_isEscaped = true;
			}
		}
		
		private function init(road:Road):void
		{
			_road = road;
			_destination = new Point();
			_position = new Point(_road.getPointByIndex(_curentWayPointIndex).x,
								  _road.getPointByIndex(_curentWayPointIndex).y );
			
			findeNewDestination();
		}
	}
}