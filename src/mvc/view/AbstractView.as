package mvc.view
{
	import loading.model.AssetsModel;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class AbstractView extends Sprite
	{
		private var _assetManager:AssetsModel;
		private var _onAddedToStage:Function;
		private var _onRemoveFromStage:Function;
		
		public function AbstractView() 
		{
			super();
			
			_assetManager = AssetsModel.instance;
			addEventListener(Event.REMOVED_FROM_STAGE,onRemove);
		}
		
		public function set onRemoveFromStage(value:Function):void
		{
			_onRemoveFromStage = value;
		}
		
		public function set onAddedToStage(value:Function):void
		{
			_onAddedToStage = value;
			if (_onAddedToStage!= null)
				addEventListener(Event.ADDED_TO_STAGE,onAdded);
			else
				removeEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		protected final function get assetManager():AssetsModel
		{
			return _assetManager;
		}
		
		private function onRemove():void
		{
			if (_onRemoveFromStage != null)
				_onRemoveFromStage();
			_assetManager = null;
			_onRemoveFromStage = null;
			onAddedToStage = null;
			removeChildren(0,-1, true);
			dispose();
		}
		
		private function onAdded():void
		{
			if(_onAddedToStage != null)
				_onAddedToStage();
		}
	}
}