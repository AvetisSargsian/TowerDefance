package game.enemys.view.mediator
{
	import game.enemys.builder.WaveBuilderDirector;
	import game.enemys.controllers.EnemyController;
	import game.enemys.models.EnemysModel;
	import game.enemys.view.EnemyLayer;
	
	import mvc.mediator.AbstractMediator;
	import mvc.view.AbstractView;
	
	import starling.events.Event;
	
	public class EnemyLayerMediator extends AbstractMediator
	{
		private var waveBuilderDirector:WaveBuilderDirector;
		private var _enemyM:EnemysModel;
		private var _unitsCont:EnemyController;
		
		public function EnemyLayerMediator()
		{
			super();
			
			nativeVIew.addEventListener(Event.ADDED_TO_STAGE,onAddedTostege);
			nativeVIew.addEventListener(Event.TRIGGERED,startNewWave);
			waveBuilderDirector = new WaveBuilderDirector(nativeVIew);
			_unitsCont = EnemyController.instance;
			_enemyM = EnemysModel.instance;
			_enemyM.addEventListener(EnemysModel.NO_ENEMY_LEFT,onWavesEnd);
			_enemyM.addEventListener(EnemysModel.NEW_WAVE_ADDED,onNewWaveAdded);
		}
		
		override public function dispose():void
		{
			_enemyM.removeEventListener(EnemysModel.NO_ENEMY_LEFT,onWavesEnd);
			_enemyM.removeEventListener(EnemysModel.NEW_WAVE_ADDED,onNewWaveAdded);
			_enemyM.dispose();
			_enemyM = null;
			
			_unitsCont.stopJuggling();
			_unitsCont.resetEnemyModel();
			_unitsCont.dispose();
			_unitsCont = null;
			
			waveBuilderDirector.dispose();
			waveBuilderDirector = null;
			
			nativeVIew.removeEventListener(Event.TRIGGERED,startNewWave);
			
			super.dispose();
		}
		
		override protected function setNativeVIew():AbstractView
		{
			return new EnemyLayer();
		}
		
		private function startNewWave(event:Event):void
		{
			_unitsCont.startNewWave(0);
			event.stopImmediatePropagation();
		}
		
		private function onAddedTostege(event:Event):void
		{
			nativeVIew.removeEventListener(Event.ADDED_TO_STAGE,onAddedTostege);
			_unitsCont.lunchEnemys();
		}
		
		private function onNewWaveAdded(event:Event):void
		{
			waveBuilderDirector.buildLineWave(_enemyM.newWave);
		}
		
		private function onWavesEnd(event:Event):void
		{
			_unitsCont.stopJuggling();
		}
	}
}