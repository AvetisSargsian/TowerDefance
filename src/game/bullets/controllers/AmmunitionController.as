package game.bullets.controllers
{
	import flash.geom.Point;
	
	import game.bullets.models.AmmunitionModel;
	import game.bullets.models.BulletModel;
	import game.enemys.models.UnitModel;
	import game.towers.models.TowerModel;
	
	import mvc.controller.AbstractController;
	
	public class AmmunitionController extends AbstractController
	{
		private var ammoM:AmmunitionModel;
		private static var _instance:AmmunitionController;
		
		public static function get instance( ):AmmunitionController
		{
			if (_instance == null)
			{
				_instance = new AmmunitionController (new PrivateClass());		
			}
			return _instance;
		}
		
		public function AmmunitionController(pvt:PrivateClass)
		{
			super();
			
			ammoM = AmmunitionModel.instance;
		}
		
		public function createBullet(shooter:TowerModel):void
		{
			var shootPos:Point = new Point(shooter.x,shooter.y);
			ammoM.addBullet(new BulletModel(shootPos, shooter.curentEnemy, shooter.damage));
		}
		
		public override function advanceTime(time:Number):void
		{
			updateBullets();
		}
		
		public override function dispose():void
		{
			stopJuggling();
			ammoM = null;
		}
		
		private function updateBullets():void
		{
			for (var i:int = 0,len:int = ammoM.bulletCount(); i < len; ++i) 
			{
				var bullet:BulletModel = ammoM.getBulletByIndex(i);
				if (bullet)
				{
					if (bullet.isDisposed)
					{
						ammoM.removeBulletByIndex(i);
					}else
					{
						bullet.update();
					}
				}
			}
		}		
	}
}
class PrivateClass
{
	public function PrivateClass( ) {}
}