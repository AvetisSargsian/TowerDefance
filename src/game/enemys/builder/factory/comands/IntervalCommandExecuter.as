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
		private var _interval:Number = 1;
		
		public function IntervalCommandExecuter(interval:Number)
		{
			this._interval = interval;
			this.comands = new Vector.<ICommand>();
		}
		
		public function get interval():Number
		{
			return _interval;
		}

		public function set interval(value:Number):void
		{
			_interval = value;
			if(GameModel.instance.jugler.contains(delayCall))
			{
				GameModel.instance.jugler.remove(delayCall);
				executingCommand(_interval);	
			}
		}

		public function startExecuting():void
		{
			if(GameModel.instance.jugler.contains(delayCall))
				return;
			if (comands && comands.length > 0) 
				executingCommand(_interval);
		}
		
		public function loadCommands(vec:Vector.<ICommand>):void
		{
			comands.concat(vec);
		}
		
		private function executingCommand(frequency:Number):void
		{
			delayCall = new DelayedCall(executeOne,frequency);
			delayCall.repeatCount = comands.length;
			GameModel.instance.jugler.add(delayCall);
			executeOne();
		}
		
		private function executeOne():void
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