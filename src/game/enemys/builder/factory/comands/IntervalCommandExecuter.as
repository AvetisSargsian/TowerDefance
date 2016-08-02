package game.enemys.builder.factory.comands
{
	import game.models.GameModel;
	
	import mvc.command.interfaces.ICommand;
	import mvc.command.interfaces.ICommandExecutor;
	
	import starling.animation.DelayedCall;
	
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
			GameModel.instance.jugler.add(delayCall);
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
			GameModel.instance.jugler.remove(delayCall);
			delayCall = null;
		}
	}
}