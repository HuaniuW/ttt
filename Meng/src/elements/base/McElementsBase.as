package elements.base
{
	import controls.GameManager;
	
	import gameEvent.GameEvent;
	
	import lzm.starling.swf.display.SwfMovieClip;
	
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	import nape.space.Space;
	
	import starling.display.Sprite;
	import elements.I.IElementBase;
	
	public class McElementsBase extends Sprite implements IElementBase
	{
		protected var space:Space;
		public function McElementsBase(_x:Number,_y:Number,_w:Number,_h:Number,mc:SwfMovieClip,space:Space,type:String = "KINEMATIC")
		{
			super();
			this.space = space;
			this.mc = mc;
			getStaticBox(_x,_y,_w,_h,type);
		}
		
		protected var body:Body;
		protected var mc:SwfMovieClip;
		protected var shape:Polygon;
		protected function getStaticBox(_x:Number,_y:Number,_w:Number,_h:Number,type:String = "KINEMATIC"):void{
			body = new Body(BodyType[type], new Vec2(_x, _y));
			shape = new Polygon(Polygon.box(_w, _h));
			body.shapes.add(shape);
			body.space = space;
			body.graphic = mc;
			mc.x = _x;
			mc.y = _y;
			addChild(body.graphic);
		}
		
		public function removeSelf():void
		{
			if(this.body)this.space.bodies.remove(this.body);
			if(this.parent)this.removeFromParent(true);
		}
		
	}
}