package game.bullets.factory
{
	import game.bullets.models.BulletModel;
	import mvc.factory.AbstractFactory;
	import mvc.factory.IProdactionLine;
	
	import mvc.model.IModel;
	
	import starling.display.DisplayObjectContainer;
	
	public class BulletFactory extends AbstractFactory
	{
		public function BulletFactory()
		{
		}
		
		override protected function createProdactionLine(canvas:DisplayObjectContainer,model:IModel = null):IProdactionLine
		{
			return new BulletProdactionLine(canvas, model as BulletModel);
		}
	}
}