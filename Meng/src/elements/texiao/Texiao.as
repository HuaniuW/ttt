package elements.texiao
{
	import controls.GameManager;
	
	import elements.I.Ibiont;
	
	import game.engine.Engine;
	
	import lzm.starling.swf.display.SwfMovieClip;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	
	public class Texiao extends Sprite
	{
		public function Texiao()
		{
			super();
			
		}
		
		protected var _texiaoMc:SwfMovieClip;
		
		
		protected var _role:Ibiont;
		protected var _num:int;
		protected var _parent:DisplayObjectContainer;
		protected var _isGensui:Boolean =false;
		protected var _txname:String;
		
		protected var __x:Number = 0;
		protected var __y:Number = 0;
		/**
		 *显示 
		 * @param role  哪个角色的特效
		 * @param _x	
		 * @param _y	
		 * @param num	第几帧显示到角色的下一层
		 * 
		 */		
		public function show(_name:String,role:Ibiont,_x:Number=0,_y:Number=0,num:int=100):void{
			this._txname = _name;
			this._num = num;
			this._texiaoMc = GameManager.getInstance().assetMgr.createMovieClip(_name);
			this.addChild(_texiaoMc);
			
			this.__x = _x;
			this.__y = _y;
			
			this._role = role;
			this._parent = this._role.getParent();
			this._parent.addChild(this);
			
			this.scaleX =  this._role["getScaleX"]();
			if(__x == 1000){
				_isGensui = true;
				__x = 0;
			}
			this.x = this._role.getX()-this.scaleX*this.__x;
			this.y = this._role.getY()+this._role.getHeight()*0.5+this.__y;
			
			Engine.createEngine().push(this.action);
			
			
//			this._parent.addChildAt(this,this._parent.numChildren-1);
//			trace("--------------> "+this.parent.getChildIndex(this._role));
		}
		
		
		protected function action():void{
			if(!this._isGensui){
				this.x = this._role.getX()-this.scaleX*this.__x;
				this.y = this._role.getY()+this._role.getHeight()*0.5+this.__y;
			}
			if(this._texiaoMc&&this._texiaoMc.currentFrame == this._num){
				this._parent.addChildAt(this,_role.getThisChildIndex()-1);
			}
			if(this._texiaoMc&&this._texiaoMc.currentFrame == this._texiaoMc.totalFrames-1){
				this.removeSelf();
			}
		}
		
		
		protected function removeSelf():void{
			if(this.parent){
				this.removeFromParent();
				TexiaoPool.getInstance().getInPool(this._txname,this);
			}
		}
		
		
	}
}