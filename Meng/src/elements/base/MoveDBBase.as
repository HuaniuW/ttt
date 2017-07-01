/**
 *移动地板 
 */
package elements.base
{
	import game.engine.Engine;
	
	import nape.space.Space;
	
	import starling.display.Image;
	
	public class MoveDBBase extends StaticElementBase
	{
		protected var __x:Number;
		protected var __y:Number;
		public function MoveDBBase(_x:Number,_y:Number,_w:Number,_h:Number,img:Image,space:Space,type:String = "KINEMATIC")
		{
			super(_x, _y, _w, _h, img, space,type);
			setV();
			Engine.createEngine().push(upDate);
		}
		
		public function upDate():void{
			baseUpDate();
			moves();
		}
		
		protected var bei:int = 3;
		protected var v:int = 40;
		protected function setV():void
		{
			this.body.velocity.y = v*bei;
			this.body.velocity.x = v*bei;
		}
		
		protected var distance:int = 0;
		protected var moveD:int = 4000;
		protected function moves():void
		{
			distance+=v;
			if(distance<=0||distance>=moveD){
				v*=-1;
				setV();
			}
		}
		
		private function baseUpDate():void
		{
			this.img.x = this.body.position.x;
			this.img.y = this.body.position.y;
		}	
		
		public override function removeSelf():void{
			Engine.createEngine().pop(upDate);
			space.bodies.remove(this.body);
			this.removeFromParent(true);
		}
		
	}
}