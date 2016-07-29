package game.towers.factory
{
	import mvc.factory.AbstractMethodFactory;
	import mvc.factory.IStartProduct;
	
	import starling.display.DisplayObjectContainer;

	public class TowerFactory extends AbstractMethodFactory
	{
		public function TowerFactory() 
		{
		}
		
		override protected function createProduct(canvas:DisplayObjectContainer,obj:Object = null):IStartProduct
		{
			return new TowerProductionLine(canvas);	
		}
	}
}