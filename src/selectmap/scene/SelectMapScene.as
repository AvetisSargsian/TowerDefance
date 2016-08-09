package selectmap.scene
{
	import mvc.view.Scene;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.textures.TextureSmoothing;
	import starling.utils.Color;
	
	public class SelectMapScene extends Scene
	{
		public function SelectMapScene()
		{
			super();
			this.onAddedToStage = onAdded;
		}
				
		private function onAdded():void
		{	
			var bgQuad:Quad = new Quad(Constants.STAGE_WIDTH,Constants.STAGE_HEIGHT,Color.OLIVE);
			addChild(bgQuad);
			
			//TODO:move icons name to json file,and build scene from that document
			var iconsVec:Vector.<String> = new <String>["map1_icon","map2_icon","map3_icon","map4_icon"];
			
			var img:Image,
			count:int = 0,
			x_pos:int = 150,
			y_pos:int = 20,	
			roundRect:starling.display.Shape = new starling.display.Shape();
			roundRect.graphics.beginFill(0x0);
			roundRect.graphics.drawRoundRect(0,0,190,110,25)
			roundRect.graphics.endFill();
			
			for (var i:int = 0,l:int = iconsVec.length; i < l; ++i)
			{
				img = new Image(assetManager.getTexture(iconsVec[i]));
				img.smoothing = TextureSmoothing.BILINEAR;				
				img.mask = roundRect;				
				
				if (count/4 == 1)
				{
					x_pos += roundRect.width + 20;
					y_pos = 20;
					count = 0;
				}
				img.x = x_pos;
				img.y = y_pos;
				img.name = iconsVec[i];
				addChild(img);
				y_pos += roundRect.height + 15;
				++count;
			}
		}
	}
}