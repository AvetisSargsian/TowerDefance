package game.enemys.factory
{
	import game.enemys.models.UnitModel;
	import game.enemys.view.UnitBaseView;
	import game.map.objects.Wave;
	
	import mvc.disposeble.IDisposeble;
	import mvc.factory.IContentProduct;
	
	public class EnemysProduct implements IContentProduct, IDisposeble
	{
		private var _wave:Wave;
		private var _content:Array;
		
		public function EnemysProduct(data:Object)
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
				_content.push(new UnitBaseView(enemysModels[i]));
			}
		}
	}
}