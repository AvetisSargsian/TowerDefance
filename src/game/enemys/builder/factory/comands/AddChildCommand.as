package game.enemys.builder.factory.comands
{
	import mvc.command.interfaces.ICommand;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;

	public class AddChildCommand implements ICommand
	{
		private var canvas:DisplayObjectContainer;
		private var child:DisplayObject;
		
		public function AddChildCommand(canvas:DisplayObjectContainer, child:DisplayObject)
		{
			this.canvas = canvas;
			this.child = child;
		}
		
		public function execute():void
		{
			canvas.addChild(child);
			canvas = null;
			child = null;
		}
	}
}