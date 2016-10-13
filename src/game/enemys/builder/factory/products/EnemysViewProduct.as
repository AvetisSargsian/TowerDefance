package game.enemys.builder.factory.products
{
	import game.enemys.models.UnitModel;
	import game.enemys.view.UnitBaseView;
	import game.map.objects.Wave;
	
	import mvc.factory.IContentProduct;
	import game.enemys.pool.UnitBaseViewPool;
	
	public class EnemysViewProduct implements IContentProduct
	{
		private var _wave:Wave;
		private var _content:Array;
		
		public function EnemysViewProduct(data:Object)
		{
			_wave = data as Wave;
			_content = new Array();	
			createContent();
		}
		
		public function get content():Object
		{
			return _content ;
		}

		public function dispose():void
		{	
			_wave = null;
			_content = null;
		}
		
		private function createContent():void
		{
			var enemysModels:Vector.<UnitModel> = _wave.enemys;
			for (var i:int = 0, len:int = enemysModels.length; i < len ; ++i) 
			{
				var unit:UnitBaseView = UnitBaseViewPool.instance.take() as UnitBaseView;
				unit.assignModel(enemysModels[i]);
				_content[_content.length] = unit;
			}
		}
	}
}