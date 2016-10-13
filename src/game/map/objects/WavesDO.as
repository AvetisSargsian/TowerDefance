package game.map.objects
{
	public class WavesDO implements IDataObject
	{
		private var _waves:Vector.<Wave>;
		
		public function WavesDO() 
		{
			_waves = new Vector.<Wave>();
		}

		public function getWaves():Vector.<Wave>
		{
			return _waves;
		}

		public function set waves(value:Array):void
		{
			if (_waves.length == 0)
			{
				for each (var obj:Object in value) 
				{
					_waves[_waves.length] = new Wave(obj.total_count, obj.scheme, obj.enemys_types);
				}
				_waves.fixed = true;
			}
		}
	}
}