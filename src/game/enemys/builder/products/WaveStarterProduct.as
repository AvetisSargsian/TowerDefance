package game.enemys.builder.products
{
	import mvc.command.interfaces.ICommandExecutor;
	import mvc.factory.IStartProduct;
	
	public class WaveStarterProduct implements IStartProduct
	{
		private var launcher:ICommandExecutor;
		public function WaveStarterProduct(launcher:ICommandExecutor)
		{
			this.launcher = launcher;
		}
		
		public function start():void
		{
			launcher.startExecuting();
			launcher = null;
		}
	}
}