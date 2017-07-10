package game.bullets.factory
{
	import game.bullets.models.BulletModel;
	
	import mvc.factory.AbstractMethodFactory;
	import mvc.factory.IStartProduct;
	
	import starling.display.DisplayObjectContainer;
	
	public class BulletFactory extends AbstractMethodFactory
	{
		public function BulletFactory(){}
		
		override protected function createProduct(canvas:DisplayObjectContainer,obj:Object = null):IStartProduct
		{
			return new BulletProduct(canvas, obj as BulletModel);
		}
	}
}