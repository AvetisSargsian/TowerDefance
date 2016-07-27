package mvc.model
{
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import starling.events.EventDispatcher;
	
	public class AbstractModel extends EventDispatcher implements IModel
	{
		private var _callBacks:Dictionary = new Dictionary();
		
		public function AbstractModel()
		{
			super();
		}
		
		public function advanceTime(time:Number):void {}
		
		public function dispose():void
		{
			_callBacks = null;
		}
		
		public function reset():void
		{
			_callBacks = new Dictionary();
		}
		
		public final function registerCallBack(key:String,callBack:Function):void
		{
			if (!(key in _callBacks))
			{
				_callBacks[key] = new Vector.<Function>();
			}
			_callBacks[key].push(callBack);
		}
		
		public final function removeCallBack(key:String,callBack:Function):void
		{
			if (key in _callBacks)
			{
				var vec:Vector.<Function> = _callBacks[key];
				
				for (var i:int = 0,len:int = vec.length; i < len; ++i) 
				{
					if (vec[i] == callBack)
					{
						vec.removeAt(i);
					}
				}
			}
		}
		
		public final function invokeCallBacks(key:String):void
		{
			if (key in _callBacks)
			{
				var vec:Vector.<Function> = _callBacks[key];
				
				for (var i:int = 0,len:int = vec.length; i < len; ++i) 
				{
					vec[i]();
				}
			}
		}
	}
}