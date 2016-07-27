package game.map.objects
{
	import flash.utils.Dictionary;
	
	import game.enemys.models.UnitModel;
	
	public class Wave
	{
		public static const _SCHEME:String = "line";
		
		private var _countTotal:int;
		private var _scheme:String;
		private var _enemyTypes:Dictionary;
		private var _road:Road;
		private var _vectorTypes:Vector.<String>;
		private var _enemys:Vector.<UnitModel>;
		
		public function Wave(count:int, scheme:String, eTypes:Object)
		{
			_countTotal = count;
			_scheme = scheme;
			_enemyTypes = setUpDictionary(eTypes);
			_enemys = new Vector.<UnitModel>();
		}
		
		public function get road():Road { return _road; }
		public function get scheme():String	{ return _scheme; }
		public function get countTotal():int { return _countTotal;}
		public function get enemys():Vector.<UnitModel> { return _enemys; }
		public function getEnemyTyps():Vector.<String> { return _vectorTypes; }
		public function getTypeCount(type:String):int { return _enemyTypes[type]; }
		
		public function set road(value:Road):void
		{
			if (_road != null)	return;
			
			_road = value;
			for (var type:String in _enemyTypes) 
			{
				for (var i:int = 0, len:int = _enemyTypes[type]; i < len; ++i) 
				{
					_enemys.push(new UnitModel(_road));	
				}	
			}			
		}
		
		private function setUpDictionary(eTypes:Object):Dictionary
		{
			_vectorTypes = new Vector.<String>();
			var dict:Dictionary = new Dictionary();
			for (var str:String in eTypes) 
			{
				dict[str] = eTypes[str];
				_vectorTypes.push(str);
			}
			_vectorTypes.fixed = true;
			return dict;
		}
	}
}