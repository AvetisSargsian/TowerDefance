package game.bullets.factory
{
	import game.bullets.models.BulletModel;
	import game.bullets.view.BulletBaseView;
	
	import mvc.factory.IStartProduct;
	import mvc.pool.BulletBaseViewPool;
	
	import starling.display.DisplayObjectContainer;
	
	public class BulletProduct implements IStartProduct
	{
		public function BulletProduct(canvas:DisplayObjectContainer,model:BulletModel)
		{
			var bullet:BulletBaseView = BulletBaseViewPool.instance.take();
			bullet.assignModel(model);
			canvas.addChild(bullet);
		}
		
		public function start():void
		{
			
		}
	}
}