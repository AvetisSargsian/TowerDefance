package game.enemys.builder
{
	import game.map.objects.Wave;
	
	import mvc.builder.IDirector;
	import mvc.disposeble.IDisposeble;
	
	import starling.display.DisplayObjectContainer;
	
	public class WaveBuilderDirector implements IDirector, IDisposeble
	{
		private var canvas:DisplayObjectContainer;
		
		public function WaveBuilderDirector(canvas:DisplayObjectContainer)
		{
			this.canvas = canvas;
		}
		
		public function buildLineWave(wave:Wave):void
		{
			var builder:WaveBuilder = new WaveBuilder();
			builder.buildWaveView(wave);
			builder.buildLauncherComands(canvas);
			builder.buildLauncher();
			builder.getProduct().start();
			builder.dispose();
		}
		
		public function dispose():void
		{
			canvas = null;
		}
	}
}