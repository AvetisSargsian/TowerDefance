package game.towers.factory
{
	import mvc.factory.AbstractFactory;
	import mvc.factory.IProdactionLine;
	
	import mvc.model.IModel;
	
	import starling.display.DisplayObjectContainer;

	public class TowerFactory extends AbstractFactory
	{
		public function TowerFactory() 
		{
		}
		
		override protected function createProdactionLine(canvas:DisplayObjectContainer,model:IModel = null):IProdactionLine
		{
			return new TowerProductionLine(canvas);	
		}
	}
}