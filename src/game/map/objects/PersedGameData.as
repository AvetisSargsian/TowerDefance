package game.map.objects
{
	public class PersedGameData implements IDataObject
	{
		private var _generalInfo:GeneralInfoDO;
		private var _wayPointDo:WayPoinsDO;
		private var _wavesDo:WavesDO;
		
		public function PersedGameData(obj:Object = null)
		{
			
		}
		
		public function get wavesDo():WavesDO { return _wavesDo; }
		public function get wayPointDo():WayPoinsDO { return _wayPointDo; }
		public function get generalInfo():GeneralInfoDO { return _generalInfo; }
		
		public function set wavesDo(value:WavesDO):void
		{
			_wavesDo = value;
		}

		public function set generalInfo(value:GeneralInfoDO):void
		{
			_generalInfo = value;
		}
		
		public function set wayPointDo(value:WayPoinsDO):void
		{
			_wayPointDo = value;
		}
	}
}