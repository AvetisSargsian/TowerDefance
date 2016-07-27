package game.map.objects
{

	public class WayPoinsDO implements IDataObject
	{
		private var _wayPoints:Vector.<WayPoint>;
		
		public function WayPoinsDO()
		{
			_wayPoints = new Vector.<WayPoint>();
		}

		public function getWayPoints():Vector.<WayPoint>
		{
			return _wayPoints;
		}

		public function set wayPoints(value:Array):void
		{
			if (!_wayPoints.fixed)
			{
				for each (var obj:Object in value) 
				{
					_wayPoints.push(new WayPoint(obj.x,obj.y,obj.direction));
				}
				_wayPoints.fixed = true;
			}
		}
	}
}