package elements.base
{
	import controls.HitManager;
	
	import game.engine.Engine;
	
	import lzm.starling.swf.display.SwfSprite;
	
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Interactor;
	import nape.phys.Material;
	import nape.shape.Polygon;
	import nape.space.Space;
	
	import starling.display.Image;
	import elements.I.IHitObj;
	import elements.I.IElementBase;
	
	public class HitBoxBase extends SwfSprite implements IHitObj,IElementBase
	{
		protected var img:Image;
		protected var space:Space;
		protected var body:Body;
		protected var __x:Number;
		protected var __y:Number;
		
		public function HitBoxBase(_x:Number,_y:Number,_w:Number,_h:Number,img:Image,space:Space)
		{
			super();
			this.space = space;
			this.img = img;
			this.__x = _x;
			this.__y = _y;
			getStaticBox(_x,_y,_w,_h);
			Engine.createEngine().push(upDate);
		}
		
		protected var shape:Polygon;
		protected function getStaticBox(_x:Number,_y:Number,_w:Number,_h:Number):void{
			body = new Body(BodyType.KINEMATIC);
			body.cbTypes.add(HitManager.hitBox);
			shape = new Polygon(Polygon.box(_w, _h));
			shape.material = Material.wood();
			body.shapes.add(shape);
			body.space = space;
			body.graphic = img;
			this.body.position.x = _x;
			this.body.position.y = _y;
			addChild(body.graphic);
		}
		
		protected var isCanBeHit:Boolean = true;
		public var isBeHit:Boolean = false;
		private var v:Number =-7;
		protected function upDate():void{
			if(isCanBeHit)hitJump();
			baseUpDate();
		}
		
		protected function hitJump():void
		{
			// TODO Auto Generated method stub
			if(isBeHit){
				v+=0.5;
				this.body.position.y+=v;
			}
			
			if(this.body.position.y>=this.__y){
				this.body.position.y = this.__y;
				v = -7;
				if(isBeHit)hitThing();
				isBeHit = false;
			}
		}
		
		protected function hitThing():void{
			
		}
		
		protected function baseUpDate():void
		{
			this.img.x = this.body.position.x;
			this.img.y = this.body.position.y;
		}
		
		public function hitCbk(int:Interactor = null):void{
			var roleVY:Number =int.castBody.velocity.y;
			var roleY:Number =int.castBody.position.y;
			var roleH:Number = int.castBody.bounds.height;
			var _y:Number = this.body.position.y;
			var _h:Number = this.body.bounds.height;
			if(roleVY>38&& roleY-_y>=(roleH+_h)*0.5-14){
				isBeHit = true;
			}
		}
		
		
		public function removeSelf():void
		{
			this.space.bodies.remove(this.body);
			this.img.removeFromParent(true);
			Engine.createEngine().pop(this.upDate);
		}
		
	}
}