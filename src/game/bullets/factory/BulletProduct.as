package game.bullets.factory
{
	import game.bullets.models.BulletModel;
	import game.bullets.view.BulletBaseView;
	import mvc.factory.IStartProduct;
	
	import starling.display.DisplayObjectContainer;
	
	public class BulletProduct implements IStartProduct
	{
		public function BulletProduct(canvas:DisplayObjectContainer,model:BulletModel)
		{
			canvas.addChild(new BulletBaseView(model));
		}
		
		public function start():void
		{
			
		}
	}
}