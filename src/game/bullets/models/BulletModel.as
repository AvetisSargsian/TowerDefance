package game.bullets.models
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import game.enemys.models.UnitModel;
	
	import mvc.model.AbstractModel;
	
	public class BulletModel extends AbstractModel
	{
		public static const BULET_UPDATE:String = "buletUpdae";
		public static const DISPOSED:String = "disposed";
		
		private var _bounds:Rectangle;
		private var _position:Point;
		private var _target:UnitModel;
		private var _demage:Number;
		private var _speed:Number = 7;
		private var _isOnStage:Boolean = false;
		
		private var _destination:Point;
		private var _destVector:Point;
		private var	_rotataionAngle:Number;
		private var _isDisposed:Boolean = false;
		
		
		public function BulletModel(startPoint:Point,target:UnitModel,demage:Number)
		{
			super();
			
			_position = startPoint;
			_target = target;
			_demage = demage;
			
			_destination = new Point();
			_destVector = new Point();
		}
		
		public function get isDisposed():Boolean
		{
			return _isDisposed;
		}

		public function get isOnStage():Boolean
		{
			return _isOnStage;
		}

		public function set isOnStage(value:Boolean):void
		{
			_isOnStage = value;
		}

		public function get bounds():Rectangle
		{
			return _bounds;
		}

		public function set bounds(value:Rectangle):void
		{
			_bounds = value;
		}

		public function get speed():Number
		{
			return _speed;
		}

		public function get demage():Number
		{
			return _demage;
		}

		public function get target():UnitModel
		{
			return _target;
		}

		public function get x():Number
		{
			return _position.x;
		}
		
		public function get y():Number
		{
			return _position.y;
		}
		
		public function update():void
		{
			if (_isOnStage)
			{
				bulletFlight();
			}
		}
		
		override public function dispose():void
		{
			_isDisposed =  true;
			_bounds = null;
			_position = null;
			_target = null;
			invokeCallBacks(DISPOSED);
			super.dispose();
		}
		
		protected function bulletFlight():void
		{
			if (!_target.isDead && !_target.isEscaped)
			{
				_destination.setTo(_target.x,_target.y);
				_destVector = _destination.subtract(_position);
				_rotataionAngle = Math.atan2(_destVector.y,_destVector.x);
				
				var	curentDist:Number = Point.distance(_destination,_position),
					dX:Number =  _speed * Math.cos(_rotataionAngle),
					dY:Number =  _speed * Math.sin(_rotataionAngle);
				
				if ( curentDist <= _speed )
				{
					_position.setTo(_destination.x, _destination.y);
					_target.takeDamadge(_demage);
					dispose();
				}
				else
				{
					_position.offset(dX, dY);
					invokeCallBacks(BULET_UPDATE);
				}
			}else
			{
				dispose();
			}
		}
	}
}