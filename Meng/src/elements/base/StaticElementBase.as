/**
 *静态物体基类 
 */
package elements.base
{
	
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	import nape.space.Space;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import elements.I.IElementBase;

	public class StaticElementBase extends Sprite implements IElementBase
	{
		protected var space:Space;
		public function StaticElementBase(_x:Number,_y:Number,_w:Number,_h:Number,img:Image,space:Space,type:String = "STATIC")
		{
			super();
			this.space = space;
			this.img = img;
			getStaticBox(_x,_y,_w,_h,type);
		}
		
		
		protected var body:Body;
		protected var img:Image;
		protected var shape:Polygon;
		protected function getStaticBox(_x:Number,_y:Number,_w:Number,_h:Number,type:String = "STATIC"):void{
			body = new Body(BodyType[type], new Vec2(_x, _y));
			shape = new Polygon(Polygon.box(_w, _h));
			//			shape.material = Material.glass();
			body.shapes.add(shape);
			body.space = space;
			body.graphic = img;
			img.x = _x;
			img.y = _y;
//			body.position.x = _x;
//			body.position.y = _y;
			addChild(body.graphic);
		}
		
		public function removeSelf():void
		{
			if(this.body)this.space.bodies.remove(this.body);
			if(this.parent)this.removeFromParent(true);
		}
	}
}