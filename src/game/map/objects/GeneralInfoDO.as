package game.map.objects
{

	public class GeneralInfoDO implements IDataObject
	{
		private var _playerLifeCount:int;
		private var _gameSpeed:Number;
		private var _mapName:String;
		
		public function GeneralInfoDO()
		{

		}

		public function get mapName():String
		{
			return _mapName;
		}

		public function set mapName(value:String):void
		{
			_mapName = value;
		}

		public function get gameSpeed():Number
		{
			return _gameSpeed;
		}

		public function set gameSpeed(value:Number):void
		{
			_gameSpeed = value;
		}

		public function get playerLifeCount():int
		{
			return _playerLifeCount;
		}

		public function set playerLifeCount(value:int):void
		{
			_playerLifeCount = value;
		}

	}
}