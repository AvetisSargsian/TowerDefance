package game.enemys.builder.factory.products
{
	import mvc.factory.IContentProduct;
	
	import starling.display.DisplayObjectContainer;
	import game.enemys.builder.factory.comands.AddChildCommand;
	
	public class CommandsProduct implements IContentProduct
	{
		private var _content:Array;
		
		public function CommandsProduct(canvas:DisplayObjectContainer, prod:IContentProduct)
		{
			createContent(canvas, prod.content as Array);
		}
		
		public function get content():Object
		{
			return _content;
		}
		
		public function dispose():void
		{
			_content = null;
		}
		
		private function createContent(canvas:DisplayObjectContainer, array:Array):void
		{
			_content = new Array();
			for (var i:int = 0, len:int = array.length; i < len; ++i) 
			{
				_content[_content.length] = new AddChildCommand(canvas,array[i]); 
			}
		}	
	}
}