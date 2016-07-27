package game.map.objects
{
	import starling.events.EventDispatcher;
	
	public class MapDataParser extends EventDispatcher
	{
		private static var _instance:MapDataParser;
		
		public static function get instance( ):MapDataParser
		{
			if (_instance == null)
			{
				_instance = new MapDataParser (new PrivateClass());		
			}
			return _instance;
		}
		
		public function MapDataParser(pvt:PrivateClass)
		{
			super();
		}
		
		public function parseMapJSON(data:Object):void
		{
			
		}
	}
}

class PrivateClass
{
	public function PrivateClass( ) 
	{
		
	}
}