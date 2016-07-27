package game.enemys.factory
{
	import game.enemys.models.EnemysModel;
	import game.enemys.models.UnitModel;
	import game.enemys.view.UnitBaseView;
	
	import mvc.view.AbstractView;
	
	import starling.animation.DelayedCall;
	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	import mvc.factory.IProdactionLine;

	public class UnitsProductionLine implements IProdactionLine
	{
		private var _delayCall:DelayedCall;
		private var _canvas:DisplayObjectContainer;
		private var _enemysM:EnemysModel;
		private var _units:Vector.<UnitModel>;
		
		public function UnitsProductionLine(canvas:DisplayObjectContainer) 
		{
			_enemysM = EnemysModel.instance;
			_canvas = canvas;
			_delayCall = new DelayedCall(releaseUnit,1);						
		}
		
		public function start():void
		{
			addUnits(1);
		}
		
		private function addUnits(frequency:Number):void
		{
			_units = _enemysM.newWave.enemys;
			
			_delayCall.reset(releaseUnit,frequency);
			_delayCall.repeatCount = _units.length;
			Starling.juggler.add(_delayCall);
			releaseUnit();
		}
		
		private function releaseUnit():void
		{
			var unit:AbstractView = new UnitBaseView(_units[_units.length - _delayCall.repeatCount]);
			_canvas.addChild(unit);
			
			if (_delayCall.repeatCount == 1)
				dispose();
			else if(_units.length == _delayCall.repeatCount)
				_delayCall.repeatCount -= 1;
		}
		
		private function dispose():void
		{
			_canvas = null;
			_units = null;
			_enemysM = null;
			
			Starling.juggler.remove(_delayCall);
			_delayCall = null;
		}
	}
}