package game.bullets.factory
{
	import game.bullets.models.BulletModel;
	import game.bullets.view.BulletBaseView;
	import mvc.factory.IProdactionLine;
	
	import starling.display.DisplayObjectContainer;
	
	public class BulletProdactionLine implements IProdactionLine
	{
		public function BulletProdactionLine(canvas:DisplayObjectContainer,model:BulletModel)
		{
			canvas.addChild(new BulletBaseView(model));
		}
		
		public function start():void
		{
			
		}
	}
}