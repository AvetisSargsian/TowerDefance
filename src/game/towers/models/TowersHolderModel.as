package game.towers.models
{
	import mvc.model.AbstractModel;
	
	public class TowersHolderModel extends AbstractModel
	{
		public static const PROJECTION_CREATED:String = "projectionCreated"; 
		private static var _instance:TowersHolderModel;

		public static function get instance():TowersHolderModel
		{
			if (_instance == null)
				_instance = new TowersHolderModel (new PrivateClass());		
			return _instance;
		}
		
		private const _allowedTowerTypes:Vector.<String> = new <String>["Type1","Type2","Type3"];
		
		private var _allTowers:Vector.<TowerModel> = new Vector.<TowerModel>();
		private var _hungryTowers:Vector.<TowerModel> = new Vector.<TowerModel>();
		private var _towerProjection:TowerModel;
		
		public function TowersHolderModel(pvt:PrivateClass)
		{
			super();
			
			_allowedTowerTypes.fixed = true;
		}
		
		public function get allowedTowerTypes():Vector.<String>
		{
			return _allowedTowerTypes;
		}
		
		public function get towerProjection():TowerModel
		{
			return _towerProjection;
		}
		
		public function towersCount():int
		{
			return _allTowers.length;
		}
		
		public function getTowerByIndex(index:uint):TowerModel
		{
			return (index < _allTowers.length) ? _allTowers[index] : null;
		}
		
		public function createTowerProjection(towerType:String):void
		{
			_towerProjection = new TowerModel();
			dispatchEventWith(PROJECTION_CREATED);
		}
		
		public function buildTowerProjection():void
		{
			if (_towerProjection && _towerProjection.canBeBuilded)
			{
				_allTowers[_allTowers.length] = _towerProjection;
				_towerProjection.build();
			}
			else if(_towerProjection)
			{
				_towerProjection.dispose();
			}
			_towerProjection = null;
		}
	}
}
class PrivateClass
{
	public function PrivateClass( ) 
	{
		
	}
}