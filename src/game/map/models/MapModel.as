package game.map.models
{
	import game.map.objects.Road;
	import game.map.objects.WayPoinsDO;
	import game.map.objects.WayPoint;
	import game.models.GameDataService;
	
	import mvc.model.AbstractModel;
	
	import starling.events.Event;

	public class MapModel extends AbstractModel
	{
		private static var _instance:MapModel;

		public static function get instance( ):MapModel
		{
			if (_instance == null)
			{
				_instance = new MapModel (new PrivateClass());		
			}
			return _instance;
		}
		
		private var _mapName:String;
		private var _loadingPath:String = "maps/";
		private var _roads:Vector.<Road>;
//		private var _towerPlaces
//		private var gameService:GameDataService;
		
		public function MapModel(pvt:PrivateClass)
		{
			super();	
		}
		
		override public function dispose():void
		{
			super.dispose();
		}
		
		public function get roads():Vector.<Road>
		{
			return _roads;
		}
		
		public function get mapName():String
		{
			return _mapName;
		}
		
		public function set mapName(value:String):void
		{ 
			_mapName = value
		}
		
		public function get mapLoadingName():String
		{
			 return _loadingPath + _mapName;
		}
		
		public function setUpRoads(wayPoins:WayPoinsDO):void
		{
			var vec:Vector.<WayPoint> = wayPoins.getWayPoints();			
			_roads = new <Road>[new Road(vec)];
		}
	}
}
class PrivateClass
{
	public function PrivateClass( ) 
	{
		
	}
}