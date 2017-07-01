package controls
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	import elements.I.IHit;
	
	import screens.GameMapScreen;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class GetHit
	{
		public function GetHit()
		{
		}
		
		private static var bd1:Rectangle;
		private static var bd2:Rectangle;
		
		
		
		private static var testSpr:Sprite = new Sprite();
		public static function getBDHit(obj1:IHit,obj2:IHit):Boolean{
			if(obj1 == null || obj2 == null){
				return false;
			}
			var _x1:int;
			if(obj1.getBeHitMc()){
				_x1 = obj1.getBeHitMc().x;
			}else{
				_x1 = obj1.getX();
			}
			if(!obj2.getBeHitMc())return false;
			var _x2:int = obj2.getBeHitMc().x;
			var _x2w:int = obj2.getBeHitMc().width;
			
			bd1 = obj1.getHitMc().bounds.clone();
			bd2 = obj2.getBeHitMc().bounds.clone();
			//bounds的X 不精确
			var pianyi:int = obj1.getGJSZ()["gjkpy"];
			if(obj1.getBeHitMc()){
//				trace("py   "+pianyi);
				bd1.x =  obj1.getScaleX() > 0?obj1.getX()-bd1.width-pianyi:obj1.getX()+pianyi;
				bd1.y = obj1.getY()-obj1.getBeHitMc().height*0.3;
			}else{
				bd1.x =  obj1.getScaleX() > 0?obj1.getX()-bd1.width+pianyi:obj1.getX()-pianyi;
				bd1.y = obj1.getY();
			}
			
			
			
			
			bd2.x =  obj2.getScaleX() > 0?obj2.getX()-_x2w*0.5:obj2.getX()-_x2w*0.5;
			bd2.y = obj2.getY()-obj2.getBeHitMc().height*0.35;
			
			
			if(Globals.isDebug){
				var rectHit:Image = getFKImage(bd1.width,bd1.height,0xff0000);
				var rectbeHit:Image = getFKImage(bd2.width,bd2.height,0x00ff00);
				
				
				rectHit.alpha= rectbeHit.alpha= 0.3;
				
				GameMapScreen.getInstance().addChild(testSpr);
				if(testSpr.numChildren){
					testSpr.removeChildren();
				}
				testSpr.addChild(rectHit);
				testSpr.addChild(rectbeHit);
				rectHit.x = bd1.x;
				rectHit.y = bd1.y;
				
				rectbeHit.x = bd2.x;
				rectbeHit.y = bd2.y;
			}
			
			
			
			
			
			
			if(bd1.intersects(bd2)){
//				trace("true.......  "+bd1+"     "+bd2);
				return true;
			}
			
			return false;
		}
		
		
		public static  function getFKImage(_w:Number,_h:Number,color:Number):Image{
			var bitmapData:BitmapData = new BitmapData(_w,_h,false,color);
			var bitmap:Bitmap = new Bitmap(bitmapData);
			return new Image(Texture.fromBitmap(bitmap));
		}
		
	}
}