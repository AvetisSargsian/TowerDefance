package game.bullets.models
{
	import mvc.model.AbstractModel;
	
	public class AmmunitionModel extends AbstractModel
	{
		public static const NEW_BULLET:String = "newBullet";
		private static var _instance:AmmunitionModel;
		
		private var _bulletsStor:Vector.<BulletModel>;
		
		public static function get instance():AmmunitionModel
		{
			if (_instance == null)
			{
				_instance = new AmmunitionModel (new PrivateClass());		
			}
			return _instance;
		}
		
		public function AmmunitionModel(pvt:PrivateClass)
		{
			super();
			
			_bulletsStor = new Vector.<BulletModel>();
		}
		
		public function addBullet(bullet:BulletModel):void
		{
			if (bullet)
			{
				dispatchEventWith(NEW_BULLET,false,bullet);
				_bulletsStor.push(bullet);
			}
		}
		
		public function bulletCount():int
		{
			return _bulletsStor.length;
		}
		
		public function getBulletByIndex(index:uint):BulletModel
		{
			return (index < _bulletsStor.length) ? _bulletsStor[index] : null;
		}
		
		public function removeBullet(bullet:BulletModel):void
		{
			var index:int = _bulletsStor.indexOf(bullet);
			if (index > -1)
				_bulletsStor.removeAt(index);
		}
		
		public function removeBulletByIndex(index:uint):void
		{
			if (index < _bulletsStor.length)
				_bulletsStor.removeAt(index);
		}
		
		override public function dispose():void
		{
			_bulletsStor = null;
			_instance = null;
			super.dispose();
		}
		
	}
}
class PrivateClass
{
	public function PrivateClass( ) 
	{
		
	}
}