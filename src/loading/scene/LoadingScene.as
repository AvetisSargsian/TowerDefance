package loading.scene
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	
	import mvc.view.Scene;
	
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class LoadingScene extends Scene
	{
		[Embed(source="/logo.png")]
		public const LogoTexture:Class;
		
		public static const PROGRESS_BAR_NAME:String = "progressBar";
		
		public function LoadingScene()
		{
			super();
			this.onAddedToStage = onAdded;
		}
		
		private function onAdded():void
		{	
//			assetsModel.removeAtlas(MapModel.instance.mapName);
//			assetsModel.removeXml("sprites");			
			
			var sceneBg:Quad = new Quad(Constants.STAGE_WIDTH,Constants.STAGE_HEIGHT,0x003f88);
			addChild(sceneBg);
			
			var texture:Texture = Texture.fromBitmap(new LogoTexture() as Bitmap);
			var logo_img:Image = new Image(texture);
			logo_img.alignPivot();
			logo_img.blendMode = BlendMode.NORMAL;
			logo_img.x = Constants.STAGE_WIDTH/2;
			logo_img.y = Constants.STAGE_HEIGHT/3;
			addChild(logo_img);
			
			var text:TextField = new TextField(150,75,"Loading...");
			text.color = 0xffffff;
			text.fontSize = 23;
			text.y = Constants.STAGE_HEIGHT/2;
			text.x = Constants.STAGE_WIDTH/2 - text.width/2;
			addChild(text);
			
			var width:Number = 550;
			var height:Number = 35;
			var scale:Number = Starling.contentScaleFactor;
			var padding:Number = height * 0.175;
			var cornerRadius:Number = padding * scale * 2;
			
			var bgShape:Shape = new Shape();
			bgShape.graphics.beginFill(0x0, 0.6);
			bgShape.graphics.drawRoundRect(0, 0, width*scale, height*scale, cornerRadius, cornerRadius);
			bgShape.graphics.endFill();
			
			var bgBitmapData:BitmapData = new BitmapData(width*scale, height*scale, true, 0x0);
			bgBitmapData.draw(bgShape);
			var bgTexture:Texture = Texture.fromBitmapData(bgBitmapData, false, false, scale);
			
			var mBackground:Image = new Image(bgTexture);
			mBackground.x = Constants.STAGE_WIDTH/2 - mBackground.width/2;
			mBackground.y = Constants.STAGE_HEIGHT/1.5
			addChild(mBackground);
			
			// create progress bar quad			
			var mBar:Quad = new Quad(width - 2*padding, height - 2 * padding, 0xffffff);
			mBar.setVertexColor(2, 0xffbe00);
			mBar.setVertexColor(3, 0xffbe00);
			mBar.x = mBackground.x + padding;
			mBar.y = mBackground.y + padding;
			mBar.scaleX = 0;
			mBar.name = PROGRESS_BAR_NAME;
			addChild(mBar);
		}
	}
}