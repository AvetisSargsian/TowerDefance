package game.enemys.pool
{
	import game.enemys.view.UnitBaseView;
	
	import mvc.view.AbstractView;
	import mvc.pool.AbstractViewAbstractPool;

	public class UnitBaseViewPool extends AbstractViewAbstractPool
	{
		private static var _instance:UnitBaseViewPool;
		public static function get instance():UnitBaseViewPool
		{
			if (_instance == null)
				_instance = new UnitBaseViewPool (new PrivateClass());		
			return _instance;
		}
		
		public function UnitBaseViewPool(pvt:PrivateClass)
		{
			super();
		}
		
		override protected function createView():AbstractView
		{
			return new UnitBaseView();
		}
	}
}
class PrivateClass
{
	public function PrivateClass( ){}
}