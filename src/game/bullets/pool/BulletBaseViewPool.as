package game.bullets.pool
{
	import game.bullets.view.BulletBaseView;
	
	import mvc.view.AbstractView;
	import mvc.pool.AbstractViewPool;

	public class BulletBaseViewPool extends AbstractViewPool
	{
		private static var _instance:BulletBaseViewPool;
		public static function get instance():BulletBaseViewPool
		{
			if (_instance == null)
				_instance = new BulletBaseViewPool (new PrivateClass());		
			return _instance;
		}
		
		public function BulletBaseViewPool(pvt:PrivateClass) 
		{
			super();
		}
		
		override protected function createView():AbstractView
		{
			return new BulletBaseView();
		}
	}
}
class PrivateClass
{
	public function PrivateClass( ){}
}