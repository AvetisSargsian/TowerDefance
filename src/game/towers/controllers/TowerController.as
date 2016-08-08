package game.towers.controllers
{
	import flash.geom.Point;
	
	import game.enemys.models.EnemysModel;
	import game.map.models.MapModel;
	import game.map.objects.Road;
	import game.map.objects.WayPoint;
	import game.towers.models.TowerModel;
	import game.towers.models.TowersHolderModel;
	
	import mvc.controller.AbstractController;
	
	import starling.events.Touch;
	import starling.events.TouchPhase;
	
	public class TowerController extends AbstractController
	{
		private static var _instance:TowerController;
		public static function get instance( ):TowerController
		{
			if (_instance == null)
			{
				_instance = new TowerController (new PrivateClass());		
			}
			return _instance;
		}
		
		private var towerHolderModel:TowersHolderModel;
		
		private var tempPoint:Point;
		private var tempPoint1:Point;
		private var pointA:Point;
		private var	pointB:Point;
		private var	pointC:Point;
		
		public function TowerController(pvt:PrivateClass)
		{
			super();
			towerHolderModel = TowersHolderModel.instance;
			
			tempPoint = new Point();
			tempPoint1 = new Point();			
			pointA = new Point();
			pointB = new Point();
			pointC = new Point();
		}
		
		public override function advanceTime(time:Number):void
		{
			updateTowers();
		}
		
		public function handlePanelTouch(touch:Touch):void
		{
			if (touch.phase == TouchPhase.MOVED)
			{
				var x:Number = touch.globalX,
					y:Number = touch.globalY;
				towerHolderModel.towerProjection.setNewPos(x, y, calculateDistance(x, y), distanseFromNeibors(x,y));
			}
			else if (touch.phase == TouchPhase.BEGAN)
			{
				towerHolderModel.createTowerProjection(touch.target.name);
			}
			else if (touch.phase == TouchPhase.ENDED)
			{
				towerHolderModel.buildTowerProjection();
			}
		}
		
		private function updateTowers():void
		{
			var eModel:EnemysModel = EnemysModel.instance;
			setTargets(towerHolderModel,eModel);
			update(towerHolderModel);
		}
		
		private function distanseFromNeibors(x:Number, y:Number):Number
		{
			var dist:Number = Number.MAX_VALUE;
			tempPoint.setTo(x,y);
			for (var i:int = 0, len:int = towerHolderModel.towersCount(); i < len; ++i) 
			{
				var tower:TowerModel = towerHolderModel.getTowerByIndex(i),
					dx:Number = (tempPoint.x - tower.positionPoint.x),
					dy:Number = (tempPoint.y - tower.positionPoint.y),
					temp:Number = Math.sqrt((dx*dx)+(dy*dy));
				if (temp < dist)
					dist = temp;
			}
			return dist;
		}
		
		private function calculateDistance(x:Number,y:Number):Number
		{
			pointC.setTo(x,y);
				
			var road:Road,
				distance:Number = Number.MAX_VALUE,
				mapModel:MapModel = MapModel.instance;
				
			for (var i:int = 0,l:int = mapModel.roads.length; i < l; ++i) 
			{
				road = mapModel.roads[i];
				for (var j:int = 0, len:int = road.getRoadLength(); j < len; ++j) 
				{
					var wayPoint:WayPoint = road.getPointByIndex(j),
						wayPoint1:WayPoint = road.getPointByIndex(j+1);
					
					if (wayPoint && wayPoint1)
					{
						pointA.setTo(wayPoint.x, wayPoint.y);
						pointB.setTo(wayPoint1.x, wayPoint1.y);
						
						var tempDist:Number = Point.distance(pointC,findeProectionPoint(pointA,pointB,pointC));
						if(tempDist < distance)
						{
							distance = tempDist;
						}
					}	
				}
			}
			return distance;
		}
		
		private function findeProectionPoint(pointA:Point, pointB:Point, pointC:Point):Point
		{	
			tempPoint.setTo(pointB.x - pointA.x, pointB.y - pointA.y);
			tempPoint1.setTo(pointC.x - pointA.x, pointC.y - pointA.y);
				
			var squaredLengthAB:Number = tempPoint.x * tempPoint.x + tempPoint.y * tempPoint.y,
				scale_AC_AB:Number = (tempPoint1.x * tempPoint.x + tempPoint1.y * tempPoint.y) / squaredLengthAB;
			
			if (scale_AC_AB > 1)
				scale_AC_AB = 1;
			else if (scale_AC_AB < 0)
				scale_AC_AB = 0;
			
			var x:Number = pointA.x + scale_AC_AB * tempPoint.x,
				y:Number = pointA.y + scale_AC_AB * tempPoint.y;
			tempPoint.setTo(x,y);
			return tempPoint;
		}
		
		private function update(model:TowersHolderModel):void
		{
			for (var i:int = 0, len:int = model.towersCount(); i < len; ++i) 
			{
				model.getTowerByIndex(i).updateForShoot();
			}
		}
		
		private function setTargets(tModel:TowersHolderModel,eModel:EnemysModel):void
		{
			for (var i:int = 0, len:int = tModel.towersCount(); i < len; ++i) 
			{
				var tower:TowerModel = tModel.getTowerByIndex(i);
				
				for (var j:int = 0, l:int = eModel.enemyCount(); j < l && tower.needTargets(); ++j) 
				{
					tower.addTarget(eModel.getEnemyByIndex(j));
				}
			}
		}		
		
		override public function dispose():void
		{
			towerHolderModel = null;
			tempPoint = null;
			tempPoint1 = null;			
			pointA = null;
			pointB = null;
			pointC = null;
		}
	}
}
class PrivateClass
{
	public function PrivateClass( )	{}
}