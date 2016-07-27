package game.enemys.factory
{
	import mvc.factory.AbstractFactory;
	import mvc.factory.IProdactionLine;
	
	import mvc.model.IModel;
	
	import starling.display.DisplayObjectContainer;

	public class UnitFactory extends AbstractFactory
	{
		public function UnitFactory()
		{
			super();
		}
		
		override protected function createProdactionLine(canvas:DisplayObjectContainer,model:IModel = null):IProdactionLine
		{
			return new UnitsProductionLine(canvas);
		}
		
	}
}