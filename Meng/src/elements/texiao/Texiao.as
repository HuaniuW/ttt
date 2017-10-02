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
		protected var _numChangeCeng:int;
		protected var _parent:DisplayObjectContainer;
		protected var _isGensui:Boolean =false;
		protected var _txMCName:String;
		
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
		public function show(txMCName:String,role:Ibiont=null,_x:Number=0,_y:Number=0,numChangeCeng:int=100):void{
			this._txMCName = txMCName;
			this._numChangeCeng = numChangeCeng;
			this._texiaoMc = TXMcPool.getInstance().getTexiaoMc(_txMCName);
			_texiaoMc.gotoAndPlay(0);
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
			
			
		}
		
		
		protected function action():void{
			if(!this._isGensui){
				this.x = this._role.getX()-this.scaleX*this.__x;
				this.y = this._role.getY()+this._role.getHeight()*0.5+this.__y;
			}
			if(this._texiaoMc&&this._texiaoMc.currentFrame == this._numChangeCeng){
				this._parent.addChildAt(this,_role.getThisChildIndex()-1);
			}
			if(this._texiaoMc&&this._texiaoMc.currentFrame == this._texiaoMc.totalFrames-1){
				this.removeSelf();
			}
		}
		
		
		protected function removeSelf():void{
			if(this.parent){
				this.removeFromParent();
				TexiaoPool.getInstance().getInPool(this._txMCName,this);
				TXMcPool.getInstance().getInPool(this._txMCName,this._texiaoMc);
				Engine.createEngine().pop(this.action);
				this._texiaoMc = null;
			}
		}
		
		
	}
}