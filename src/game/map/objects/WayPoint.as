package game.map.objects
{
	public class WayPoint
	{
		public static const DIRECTION_UP:int         = 0;
		public static const DIRECTION_DOWN:int       = 1;
		public static const DIRECTION_LEFT:int       = 2;
		public static const DIRECTION_RIGHT:int      = 3;
		public static const DIRECTION_UP_LEFT:int    = 4;
		public static const DIRECTION_UP_RIGHT:int   = 5;
		public static const DIRECTION_DOWN_LEFT:int  = 6;
		public static const DIRECTION_DOWN_RIGHT:int = 7;
		
		private var _x:int;
		private var _y:int;
		private var _direction:int;
		
		public function WayPoint(x:int, y:int, direction:int)
		{
			_x = x;
			_y = y;
			_direction = direction;
		}

		public function get direction():int
		{
			return _direction;
		}

		public function get y():int
		{
			return _y;
		}

		public function get x():int
		{
			return _x;
		}
	}
}