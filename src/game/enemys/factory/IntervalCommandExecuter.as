package game.enemys.factory
{
	import mvc.command.interfaces.ICommand;
	import mvc.command.interfaces.ICommandExecutor;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	
	public class IntervalCommandExecuter implements ICommandExecutor
	{
		private var comands:Vector.<ICommand>;
		private var delayCall:DelayedCall;
		private var interval:Number = 1;
		
		public function IntervalCommandExecuter(interval:Number)
		{
			this.interval = interval;
		}
		
		public function executeCommand():void
		{
			if (comands && comands.length > 0) 
				run(interval);
		}
		
		public function loadCommands(vec:Vector.<ICommand>):void
		{
			comands = vec;
		}
		
		private function run(frequency:Number):void
		{
			delayCall = new DelayedCall(releaseUnit,frequency);
			delayCall.repeatCount = comands.length;
			Starling.juggler.add(delayCall);
			releaseUnit();
		}
		
		private function releaseUnit():void
		{
			if (comands.length > 0)
			{
				comands.shift().execute();
			}else
			{
				dispose();
			}
		}
		
		private function dispose():void
		{
			comands = null;
			Starling.juggler.remove(delayCall);
			delayCall = null;
		}
	}
}