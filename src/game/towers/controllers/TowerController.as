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
		
		public function TowerController(pvt:PrivateClass)
		{
			super();
			towerHolderModel = TowersHolderModel.instance;
		}
		
		public override function advanceTime(time:Number):void
		{
			updateTowers();
		}
		
		public function updateTowers():void
		{
			var eModel:EnemysModel = EnemysModel.instance;
			setTargets(towerHolderModel,eModel);
			update(towerHolderModel);
		}
		
		public function handlePanelTouch(touch:Touch):void
		{
			if (touch.phase == TouchPhase.MOVED)
			{
				var x:Number = touch.globalX,
					y:Number = touch.globalY;
				var bottom:Number = touch.target.bounds.bottom;
				var top:Number = touch.target.bounds.top;
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
		
		private function distanseFromNeibors(x:Number, y:Number):Number
		{
			var dist:Number = Number.MAX_VALUE,
				p:Point = new Point(x,y);
			for (var i:int = 0, len:int = towerHolderModel.towersCount(); i < len; ++i) 
			{
				var tower:TowerModel = towerHolderModel.getTowerByIndex(i),
					temp:Number = Point.distance(p,tower.positionPoint);
				if (temp < dist)
					dist = temp;
			}
			return dist;
		}
		
		private function calculateDistance(x:Number,y:Number):Number
		{
			var pointA:Point = new Point(),
				pointB:Point = new Point(),
				pointC:Point = new Point(x,y),
				road:Road,
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
						
						var tempProectionPoint:Point = findeProectionPoint(pointA,pointB,pointC),
							tempDist:Number = Point.distance(pointC,tempProectionPoint);
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
			var abVec:Point = new Point(pointB.x - pointA.x, pointB.y - pointA.y),
				acVec:Point = new Point(pointC.x - pointA.x, pointC.y - pointA.y),
				squaredLengthAB:Number = abVec.x * abVec.x + abVec.y * abVec.y,
				scale_AC_AB:Number = (acVec.x * abVec.x + acVec.y * abVec.y) / squaredLengthAB;
			
			if (scale_AC_AB > 1)
				scale_AC_AB = 1;
			else if (scale_AC_AB < 0)
				scale_AC_AB = 0;
			
			var x:Number = pointA.x + scale_AC_AB * abVec.x,
				y:Number = pointA.y + scale_AC_AB * abVec.y,
				pointOnVector:Point = new Point(x,y);
			
			return pointOnVector;  
		}
		
		private function update(model:TowersHolderModel):void
		{
			for (var i:int = 0, len:int = model.towersCount(); i < len; ++i) 
			{
				var tower:TowerModel = model.getTowerByIndex(i);
				tower.updateForShoot();
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
		}
	}
}
class PrivateClass
{
	public function PrivateClass( )	{}
}