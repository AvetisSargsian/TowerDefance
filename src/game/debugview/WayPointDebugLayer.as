package game.debugview
{
	import flash.geom.Point;
	
	import game.map.models.MapModel;
	import game.map.objects.Road;
	import game.map.objects.WayPoint;
	
	import starling.display.DisplayObject;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.Color;
	
	public class WayPointDebugLayer extends Sprite
	{
		private var _mapModel:MapModel;
		private var _lineShape:Shape;
		private var _pointShape:Shape;
		
		private var proectionPoint:Point = new Point();
		private var pointC		  :Point = new Point();
		private var pointA		  :Point = new Point();
		private var pointB		  :Point = new Point();
		
		public function WayPointDebugLayer()	
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE,onAddedToSTage);
			addEventListener(Event.REMOVED_FROM_STAGE,onRemovedFromStage);
			
			_mapModel = MapModel.instance;
			
			_pointShape = new Shape();
			addChild(_pointShape);
			
			_lineShape = new Shape();
			addChild(_lineShape);
		}
		
		private function onTouch(event:TouchEvent):void
		{ 
			var touch:Touch = event.getTouch((event.target as DisplayObject).parent,TouchPhase.HOVER);
			if (touch)
			{
				pointC.setTo(touch.globalX,	touch.globalY);
				var road:Road,
					distance:Number = Number.MAX_VALUE;
				for (var i:int = 0,l:int = _mapModel.roads.length; i < l; ++i) 
				{
					road = _mapModel.roads[i];
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
								proectionPoint = tempProectionPoint;
							}
						}	
					}
				}
				
				drawProection(pointC,proectionPoint);
			}
		}
		
		private function onRemovedFromStage(event:Event):void
		{
			_mapModel = null;
			removeEventListener(Event.REMOVED_FROM_STAGE,onRemovedFromStage);
			this.parent.removeEventListener(TouchEvent.TOUCH,onTouch);
		}
		
		private function onAddedToSTage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onAddedToSTage); 
			this.parent.addEventListener(TouchEvent.TOUCH,onTouch);//
			drawRoad();
		}
		
		private function drawRoad():void
		{
			var road:Road;
			for (var i:int = 0,l:int = _mapModel.roads.length; i < l; ++i) 
			{
				road = _mapModel.roads[i];
				for (var j:int = 0, len:int = road.getRoadLength(); j < len; ++j) 
				{
					var wayPoint:WayPoint = road.getPointByIndex(j),
						wayPoint1:WayPoint = road.getPointByIndex(j+1);
					
					if (wayPoint)
					{
						drawWayPoint(wayPoint);
					
						if (wayPoint1)
						{
							drawLine(wayPoint,wayPoint1);
							
							drawLine(new WayPoint(wayPoint.x,wayPoint.y-50,wayPoint.direction), 
								new WayPoint(wayPoint1.x,wayPoint1.y-50,wayPoint1.direction));
							
							drawLine(new WayPoint(wayPoint.x,wayPoint.y+50,wayPoint.direction),
								new WayPoint(wayPoint1.x,wayPoint1.y+50,wayPoint1.direction));
						}
					}
				}
			}
		}
		
		private function drawWayPoint(wayPoint:WayPoint):void
		{
			_pointShape.graphics.lineStyle(1.5,Color.RED,1);
			_pointShape.graphics.drawCircle(wayPoint.x, wayPoint.y,30);
			_pointShape.graphics.endFill();
			
			_pointShape.graphics.lineStyle(1.5,Color.BLUE,1);
			_pointShape.graphics.drawCircle(wayPoint.x, wayPoint.y,3);
			_pointShape.graphics.endFill();
		}
		
		private function drawLine(pointA:WayPoint, pointB:WayPoint):void
		{
			_pointShape.graphics.lineStyle(1.5,Color.RED,1);
			_pointShape.graphics.moveTo(pointA.x,pointA.y);
			_pointShape.graphics.lineTo(pointB.x,pointB.y);
			_pointShape.graphics.endFill();
		}
		
		private function drawProection(start:Point, end:Point):void
		{
			_lineShape.graphics.clear();
			_lineShape.graphics.lineStyle(1.5,Color.BLUE);
			_lineShape.graphics.drawCircle(start.x, start.y ,3);
			_lineShape.graphics.moveTo(start.x,start.y);
			_lineShape.graphics.lineTo(end.x, end.y);
			_lineShape.graphics.drawCircle(end.x, end.y ,3);
			_lineShape.graphics.endFill();
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
			
//			var dx:Number = x - pointC.x;
//			var dy:Number = y - pointC.y;
//			var distance_pointOnVector_C:Number = Math.sqrt(dx*dx + dy*dy);
			
//			http://stackoverflow.com/questions/1073336/circle-line-segment-collision-detection-algorithm
//			R - radius of circul;
//			C - center of circul
//			intersecPoint
//			if (distance_pointOnVector_C == R)
//			{
				// line segment touches circle; one intersection point
//				intersecPoint = pointOnVector
//				if (scale_AC_AB < 0 || scale_AC_AB > 1)
//				{
					// intersection point is not actually within line segment
//				}
//			}
//			else if (distance_pointOnVector_C < R)
//			{
				// two possible intersection points
				
//				var dt:Number = Math.sqrt(R * R - distance_pointOnVector_C * distance_pointOnVector_C) / Math.sqrt(squaredLengthAB);
//				dX = pointB.x - pointA.x;
//				dy = pointB.y - pointA.y;
				
				// intersection point nearest to A
				
//				t1 = scale_AC_AB - dt;
//				i1X = pointA.x + t1 * dX;
//				i1Y = pointA.y + t1 * dY;
//				if (t1 < 0 || t1 > 1)
//				{
					// intersection point is not actually within line segment
//				}
				
				// intersection point farthest from A

//				t2 = scale_AC_AB + dt;
//				i2X = pointA.x + t2 * dX;
//				i2Y = pointA.y + t2 * dY;
//				if (t2 < 0 || t2 > 1)
//				{
					// intersection point is not actually within line segment
//				}
//			}
//			else
//			{
				// no intersection
//			}
			
			return pointOnVector;  
		}
	}
}