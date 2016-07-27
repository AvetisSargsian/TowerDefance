package game.map.objects
{
	public class Road
	{
		private var wayPointsVec:Vector.<WayPoint>;
		
		public function Road(pointsVec:Vector.<WayPoint> = null)
		{
			resetRoad(pointsVec);
		}
//		========================================================================
		public function addPoint(wayPoint:WayPoint):void
		{
			wayPointsVec.push(wayPoint);
		}
//		========================================================================
		public function removePoint(wayPoint:WayPoint):void
		{
			var p:int = wayPointsVec.indexOf(wayPoint);
			if(p > -1) 
				wayPointsVec.removeAt(p);
		}
//		========================================================================
		public function getPointByIndex(i:uint):WayPoint
		{
			return (i < wayPointsVec.length) ? wayPointsVec[i] : null;
		}
//		========================================================================
		public function getPointIndex(wayPoint:WayPoint):int
		{
			return wayPointsVec.indexOf(wayPoint);
		}
//		========================================================================
		public function getRoadLength():int
		{
			return wayPointsVec.length;
		}
//		========================================================================
		public function resetRoad(pointsVec:Vector.<WayPoint> = null):void
		{
			wayPointsVec = pointsVec ? pointsVec :  new Vector.<WayPoint>();
		}
//		========================================================================
		public function dispose():void
		{
			wayPointsVec = null;
		}
	}
}