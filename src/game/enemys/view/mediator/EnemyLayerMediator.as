package game.enemys.view.mediator
{
	import game.enemys.builder.WaveBuilderDirector;
	import game.enemys.controllers.EnemyController;
	import game.enemys.models.EnemysModel;
	
	import mvc.mediator.AbstractMediator;
	
	import starling.events.Event;
	
	public class EnemyLayerMediator extends AbstractMediator
	{
		private var waveBuilderDirector:WaveBuilderDirector;
		private var enemyM:EnemysModel;
		private var unitsCont:EnemyController;
		
		public function EnemyLayerMediator()
		{
			super();
			
			nativeVIew.addEventListener(Event.ADDED_TO_STAGE,onAddedTostege);
			
			waveBuilderDirector = new WaveBuilderDirector(nativeVIew);
			unitsCont = EnemyController.instance;
			enemyM = EnemysModel.instance;
			enemyM.addEventListener(EnemysModel.NO_ENEMY_LEFT,onWavesEnd);
			enemyM.addEventListener(EnemysModel.NEW_WAVE_ADDED,onNewWaveAdded);
		}
		
		override public function dispose():void
		{
			enemyM.removeEventListener(EnemysModel.NO_ENEMY_LEFT,onWavesEnd);
			enemyM.removeEventListener(EnemysModel.NEW_WAVE_ADDED,onNewWaveAdded);
			enemyM.dispose();
			enemyM = null;
			
			unitsCont.stopJuggling();
			unitsCont.resetEnemyModel();
			unitsCont.dispose();
			unitsCont = null;
			
			waveBuilderDirector.dispose();
			waveBuilderDirector = null;
				
			super.dispose();
		}
		
		private function onAddedTostege(event:Event):void
		{
			nativeVIew.removeEventListener(Event.ADDED_TO_STAGE,onAddedTostege);
			unitsCont.lunchEnemys();
		}
		
		private function onNewWaveAdded(event:Event):void
		{
			waveBuilderDirector.buildLineWave(enemyM.newWave);
		}
		
		private function onWavesEnd(event:Event):void
		{
			unitsCont.stopJuggling();
		}
	}
}