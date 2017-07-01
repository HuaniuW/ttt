package controls
{
	import com.greensock.TweenLite;
	
	import lzm.starling.swf.display.SwfMovieClip;
	
	import starling.filters.ColorMatrixFilter;

	public class BeHitColor
	{
		public function BeHitColor()
		{
		}
		
		private var colorfilter:ColorMatrixFilter;
		private var _obj:SwfMovieClip;
		public function getBeHitColor(obj:SwfMovieClip):void{
			if(!colorfilter){
				colorfilter = new ColorMatrixFilter();
				colorfilter.matrix = Vector.<Number>([
					1,0,0,0,150,
					0,1,0,0,0,
					0,0,1,0,0,
					0,0,0,1,0
				]);
			}
			
			this._obj = obj;
			this._obj.filter = colorfilter;
			
//			TweenLite.to((_obj as SwfMovieClip),0.1,{"onComplete":onComplete});
		}
		
//		private function onComplete():void{
//			_obj.filter = null;
//		}
	}
	
	
}