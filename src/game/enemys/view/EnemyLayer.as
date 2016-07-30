package game.enemys.view
{
	import game.enemys.controllers.EnemyController;
	
	import loading.model.AssetsModel;
	
	import mvc.view.AbstractView;
	
	import starling.display.Button;
	import starling.utils.Color;
	
	public class EnemyLayer extends AbstractView
	{
		private var _btn:Button;
		private var _unitsCont:EnemyController;
		
		public function EnemyLayer()
		{
			super();
			
			this.onAddedToStage = onAdded;
			this.onRemoveFromStage = onRemove;
			
			_unitsCont = EnemyController.instance;
			
			_btn = new Button(AssetsModel.drawRoundRectTexture(100,50,Color.BLUE),"NEW WAVE");
			_btn.x = 10;
			_btn.y = 10;
		}
		
		private function onAdded():void
		{
			addChild(_btn);
		}
		
		private function onRemove():void
		{
			_btn.dispose();
			_btn = null;
		}
	}
}