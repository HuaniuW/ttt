package elements.role
{
	import com.greensock.TweenLite;
	
	import flash.filters.DisplacementMapFilter;
	
	import controls.BeHitColor;
	import controls.GetHit;
	import controls.Globals;
	
	import elements.I.Ibiont;
	import elements.texiao.TexiaoPool;
	
	import game.engine.Engine;
	import game.mySound.MySoundPool;
	
	import lzm.starling.swf.display.SwfImage;
	import lzm.starling.swf.display.SwfMovieClip;
	
	import nape.space.Space;
	
	import starling.display.DisplayObjectContainer;
	
	
	public class RoleO extends RoleBase
	{
		public function RoleO(mc:SwfMovieClip, dataObj:Object, _x:Number, _y:Number, w:Number, h:Number, space:Space)
		{
			super(mc, dataObj, _x, _y, w, h, space);
			Engine.createEngine().push(upDate);
			getInit();
		}
		
		
		private var _beHitCorlor:BeHitColor;
		protected function getInit():void
		{
			if(!this._beHitCorlor)this._beHitCorlor  = new BeHitColor();
		}
		
		
		public function upDate():void{
			baseUpDate();
			this.x = this.body.position.x;
			this.y = this.body.position.y;
			
		}
		
		
		public var isBeHit:Boolean = false;
		public var isBeHiting:Boolean = false;
		public var isRunLeft:Boolean = false;
		public var isRunRight:Boolean = false;
		public var isJump:Boolean = false;
		public var isStand:Boolean = false;
		protected function baseUpDate():void
		{
//			trace(this._bodyMc.currentLabel+" this._bodyMc.currentFrame   "+this._bodyMc.currentFrame +"    this._bodyMc.endFrame     "+this._bodyMc.endFrame);
//			trace(this._bodyMc.getImage("hitMc")+"    "+this._bodyMc.currentFrame+"    "+this.isJumpAtking);
			
			if(this.gjNum == this.cgjNum){
				gjnqnum++;
				if(gjnqnum>=60){
					gjnqnum = 0;
					this.gjNum = 0;
				}
			}
			
			
			
//			if(isDie){
//				return;
//			}
			
			if(_isResting){
				this.getRest();
				return;
			}
			
			if(this._roleTili&&this._roleTili.isTiliOver){
				this.getRest();
				return;
			}
			
			
			if(isAvoiding){
				this.avoid();
				return;
			}
			
			if(this._isGedanging){
				this._gedang();
				return;
			}
			
			if(this.isStandUping){
				this.theStandUp();
				return;
			}
			
			
			if(isBeHitOuting){
				this.beHitOut();
				return;
			}
			
			
			if(isBeHiting){
				this.theBeHiting();
				return;
			}
			
			
			
			if(_isJumping){
				jump();
			}
			
			
			
			
			if(!this.isAtking||this.isCanAtkedMove){
				if(isRunLeft){
					this.runLeft();
				}
				
				if(isRunRight){
					this.runRight();
				}
			}
			
			
			
			if(this.isAtking){
				atking();
				return;
			}
			
			if(_isDongzuoing){
				Dongzuoing();
				return;
			}
			
			
			if(this.isJumpAtking){
				atking();
				return;
			}
			
			
			if(!this.isCanAtk&&!isRunLeft &&!isRunRight&&!isAtking&&!isBeHit&&!isStand&&!_isJumping&&!_isDie){
				stand();
				return;
			}
			
			
		}
		
		
		protected var _isDongzuo:Boolean = false;
		public var _isDongzuoing:Boolean = false;
		protected var _isCbk:Boolean = false;
		protected var _DZcbkFNum:int = 0;
		protected var _DZcbk:Function;
		protected function getDongzuo(label:String,DZcbkFNum:int,DZcbk:Function):void{
			if(this.zuduan()||isAtking||isAvoiding)return;
			if(!_isDongzuo){
				this.ztreSet();
				_isDongzuo = true;
				_DZcbkFNum = DZcbkFNum;
				_DZcbk = DZcbk;
				this._bodyMc.gotoAndPlay(label);
				_isDongzuoing = true;
			}
		}
		
		protected function Dongzuoing():void{
			if(!_isCbk&&this._bodyMc.currentFrame==this._bodyMc.endFrame - _DZcbkFNum){
				_isCbk = true;
				_DZcbk();
			}
			if(this._bodyMc.currentFrame == this._bodyMc.endFrame){
				_isCbk = false;
				this._isDongzuoing = false;
				_isDongzuo = false;
			}
		}
		
		
		
		private var _isRest:Boolean = false;
		private var _isResting:Boolean = false;
		private function getRest():void{
			if(zuduan2())return;
			if(!this._isRest){
				this.ztreSet();
				this._isRest = true;
				this._isResting = true;
				this._bodyMc.gotoAndPlay("rest");
			}
			
			if(this._bodyMc.currentFrame == this._bodyMc.endFrame){
				this._isResting = false;
				_isRest = false;
			}
		}
		
		
		private function theBeHiting():void{
			if(this.isBeHiting){
				if(this._bodyMc.currentFrame == this._bodyMc.endFrame){
					this.isBeHiting = false;
				}
			}
		}
		
		private function onComplete():void{
			if(!this._isJumping)this._bodyMc.play();
			this._bodyMc.filter = null;
			
			
		}
		
		private var isBeHitOut:Boolean = false;
		private var isBeHitOuting:Boolean = false;
		private function beHitOut():void{
			if(this.isBeHitOut){
				this.ztreSet();
				this.isBeHitOuting = true;
				this._bodyMc.gotoAndPlay("beHitOut");
			}
			
			if(this.isBeHitOuting){
				if(this._bodyMc.currentFrame == this._bodyMc.endFrame){
					this._bodyMc.stop();
					if(this.body.velocity.y >= 0&&this.body.velocity.y <= 1){
						this.isBeHitOuting = false;
						if(this.isDie()){
							this._bodyMc.stop();
							return;
						}
						theStandUp();
					}
				}
			}
		}
		
		
		private var isStandUp:Boolean = false;
		private var isStandUping:Boolean = false;
		private function theStandUp():void{
			if(!this.isStandUp){
				this.ztreSet();
				isStandUp = true;
				isStandUping = true;
				this._bodyMc.gotoAndPlay("standUp");
			}
			
			if(this.isStandUping){
				if(this._bodyMc.currentFrame == this._bodyMc.endFrame-1){
					this.isStandUping = false;
					isStandUp = false;
				}
			}
		}
		
		private function zuduan2():Boolean{
			if(this.isBeHitOuting||this.isBeHiting||this.isStandUping)return true;
			return false;
		}
		
		
		private function zuduan():Boolean{
			if(this.isBeHitOuting||this.isBeHiting||this.isStandUping||_isResting||this.isDie()||this._isDongzuoing)return true;
			return false;
		}
		
		
		//当前帧 防止同一帧多跑
		private var theCF:int = -1;
		
		public var isJumpAtking:Boolean = false;
		public var isAtk:Boolean = false;
		public var isAtking:Boolean = false;
		public var isCanAtk:Boolean = false;
		//攻击后没有收招完就可以移动
		protected var isCanAtkedMove:Boolean = false;
		public override function atk(nums:int = 0):void
		{
			if(this._isGedanging)return;
			if(this.isAvoiding)return;
			if(zuduan())return;
			if(!isAtking||this.isCanAtk){
				if(this._isJumping){
					if(!isJumpAtking){
						isJumpAtking = true;
						if(!xiaohaotili(10))return;
						this._bodyMc.gotoAndPlay("jumpAtk1");	
						this.cgjNum = 1;
					}
				}else{
					ztreSet();
					isAtking = true;
					if(!xiaohaotili(10))return;
					if(nums == 0){
						this.gjNum++;
						this.cgjNum = this.gjNum;
					}else{
						gjNum = cgjNum = nums;
					}
					this._bodyMc.gotoAndPlay(this.gongjizhaoshiArr[this.cgjNum-1]["zs"]);
					/**由于开始人物制作资源X方向弄反 视野是 -=*/
					this.body.velocity.x = 0;
					this.body.velocity.x-= this.scaleX*this.gongjizhaoshiArr[this.cgjNum-1]["vx"];
					this.body.velocity.y-= this.gongjizhaoshiArr[this.cgjNum-1]["vy"];
					gjnqnum = 0;
					if(this.gjNum == this.gongjizhaoshiArr.length)this.gjNum = 0;
					
				}
				
			}
		}
		
		
		public function xiaohaotili(num:Number):Boolean{
			this._roleTili.getXRest();
			if(_roleTili.curTili==1){
				_roleTili.curTili = 0;
				return false;
			}
			if(_roleTili.curTili-num>=1){
				this._roleTili.curTili-=num;
			}else{
				this._roleTili.curTili = 1;
			} 
			return true;
			
			
			/**方案2*/
//			this._roleTili.curTili-=num;
//			if(_roleTili.curTili>0){
//				return true;
//			}else{
//				return false;
//			}
		}
		
		
		protected var isAvoid:Boolean = false;
		protected var isAvoiding:Boolean = false;
		
		override public function avoid():void
		{
			if(this.zuduan())return;
			if(!this.isAvoid){
				this.ztreSet();
				this.isAvoid = true;
				isAvoiding = true;
				if(!xiaohaotili(10))return;
				this._bodyMc.gotoAndPlay("avoid");
				this.body.velocity.x = 0;
				this.body.velocity.x+=this.scaleX*690;
				this.body.velocity.y-=400;
			}
			
			if(this._bodyMc.currentFrame == this._bodyMc.endFrame){
				isAvoiding  =false;
//				this._bodyMc.gotoAndPlay("stand");
			}
			
			
		}
		
		private var gjendNum:int = 1;
		
		protected function atking():void{
			if(this._bodyMc.currentFrame == this.theCF)return;
			this.theCF = this._bodyMc.currentFrame;
			
			
			//			trace(this._bodyMc.currentLabel+"  this._bodyMc.currentFrame   "+this._bodyMc.currentFrame +"    this._bodyMc.endFrame     "+this._bodyMc.endFrame);
			
			if(this.isBeHitOuting)return;
			
			if(this.isJumpAtking){
				getAtked();
				if(this._bodyMc.currentFrame == this._bodyMc.endFrame){
					this.isJumpAtking = false;
				}
				return;
			}
			
			
			if(isAtking){
				getAtked();
				this.atkAc();
				return;
			}
		}
		
		
		protected function atkAc():void{
			if(this._bodyMc.currentFrame == this._bodyMc.endFrame-gjendNum){
				this.isAtking = false;
				this.isCanAtkedMove = false;
				this.isCanAtk = false;
				
			}
		}
		
		/**
		 *是否击中 
		 * 
		 */		
		protected function getAtked():void{
			if(this._bodyMc.getImage("hitMc")){
				
				this._bodyMc.getImage("hitMc").width = this.gongjizhaoshiArr[this.cgjNum-1]["atkjuli"]
				
				TexiaoPool.getInstance().getOnTexiao(this.gongjizhaoshiArr[this.cgjNum-1]["texiao"],this,this.gongjizhaoshiArr[this.cgjNum-1]["txpy"]);
				
				MySoundPool.instance.getSound("atk",Globals.soundNums);
				for(var i:int in this.enemyArr){
//					trace(((Globals.enemyArr[i]) as IHit).getBeHitMc().x);
//					trace("是否碰撞      "+GetHit.getBDHit(this,Globals.enemyArr[i]));
					
					if(GetHit.getBDHit(this,this.enemyArr[i])){
						if(isJumpAtking){
							this.body.velocity.y = 0;
							this.body.velocity.y-=800;
						}
						
						/**1.招式的移动  2.招式的攻击力  3.被攻击者的硬直  4.技能攻击破盾   5.击退 击飞 高硬直  6.击中光效   判断*/
						var vx:Number = this.gongjizhaoshiArr[this.cgjNum-1]["vx"];
						var cy:Number = this.gongjizhaoshiArr[this.cgjNum-1]["cy"];
						var gjl:Number = this.gongjili+this.gongjizhaoshiArr[this.cgjNum-1]["gjl"];
						
						if(this.getScaleX()>0)vx*=-1;
						
						(this.enemyArr[i] as Ibiont).beHit(vx,cy,gjl);
					}
				}
			}
		}
		
		
		private function theBeHit(vx:Number,cy:Number,gjl:Number):void
		{
			if(this.isDie())return;
			if(this._isGedanging){
				/**格挡计算*/
				if(this._roleTili)this._roleTili.curTili-=gjl;
				theVelocityX(vx*1.3);
				TexiaoPool.getInstance().getOnTexiao("mc_ba1_gjtx",this,0,-60);
				return;
			}
			
			if(_roleTili)_roleTili.getBeHitTili();
			
			this.ztreSet();
			
			
			this._roleLive.curLive-=(gjl - this.fangyuli);
			if(this._roleLive.curLive<=0)this._isDie = true;
			this.body.velocity.x =0;
			this.body.velocity.y = 0;
			
			this._beHitCorlor.getBeHitColor(this._bodyMc);
			MySoundPool.instance.getSound("beHit",Globals.soundNums);
			
			if(!this._isJumping)this._bodyMc.stop();
			TweenLite.to(this._bodyMc,0.1,{"onComplete":onComplete});
			
			theVelocityX(vx*1.3);
			/**特效*/
			TexiaoPool.getInstance().getOnTexiao("mc_ba1_gjtx",this,0,-60);
			
			
			
			
			if(this.isDie()){
				this.isBeHitOut = true;
				this.beHitOut();
				return;
			}
			
			
			if(gjl/this.yingzhi>=3){
				this.isBeHitOut = true;
				this.beHitOut();
				theVelocityY(-cy);
				return;
			}
			
			
			if(gjl/this.yingzhi>=2){
				this.isBeHitOut = true;
				this.beHitOut();
				return;
			}
			
			if(this.isBeHitOuting){
				this.isBeHitOut = true;
				this.beHitOut();
				return;
			}
			
			//			this.body.velocity.y-=300;
			
			//被攻击不一定被击退  看硬直属性
			//加if(瞬间总伤害和>硬直)
			
			if(this._isJumping){
				this.isBeHitOut = true;
				this.beHitOut();
				return;
			}
			
			
			if(gjl/this.yingzhi>=1){
				if(this._bodyMc.currentLabel=="beHitOut"){
					this.isBeHitOut = true;
					this.beHitOut();
					
					return;
				}
				this.isBeHiting = true;
				this._bodyMc.gotoAndPlay(this.beHitAcArr[0]);
				return;
			}
			
			
//			this._bodyMc.gotoAndPlay(this.beHitAcArr[0]);
		}
		
		public override function getIsAtking():Boolean{
			return this.isAtking;
		}
		
		
		override public function getBeHitMc():SwfImage
		{
			return this._bodyMc.getImage("beHitMc");			
		}
		
		
		private function ztreSet():void{
			_isWalkLefting = false;
			_isWalkRighting = false;
			isStand = false;
			
			
			isJumpDown = false;
			_isJumping = false;
			isRunBegin = false;
			isJumpUp = false;
			jumpUpBegin = false;
			
			isRunStop = false;
			isRunStoping = false;
			isAtking = false;
			isJumpAtking = false;
			this.isCanAtkedMove = false;
			
			isCanAtk = false;
			
			
			
			this.isBeHitOut = false;
			this.isBeHitOuting = false;
			this.isBeHit = false;
			this.isBeHiting = false;
			isBeHit = false;
			
			this.isStandUp = false;
			this.isStandUping = false;
			
			this.isAvoid = false;
			this.isAvoiding = false;
			
			this._isGedang = false;
			this._isGedanging = false;
			
			this._isRest = false;
			this._isResting = false;
			
			_isDongzuo = false;
			_isDongzuoing = false;
			
		}
		
		
		private function stand():void
		{
			if(this.isRunStop){
				ztreSet();
				this.isRunStop = false;
				this._bodyMc.gotoAndPlay("runStop");
				this.isRunStoping = true;
				return;
			}
			if(isRunStoping){
				if(this._bodyMc.currentFrame == this._bodyMc.endFrame){
					isRunStoping = false;
				}
				return;
			}
			this.ztreSet();
			isStand = true;
			this._bodyMc.gotoAndPlay("stand");
		}
		
		
		
		
		private var _isWalkLefting:Boolean = false;
		private var _isWalkRighting:Boolean = false;
		private var _isJumping:Boolean = false;
		
		private var isRunStop:Boolean = false;
		private var isRunStoping:Boolean = false;
		
		
		private var isRunBegin:Boolean = false;
		public function runLeft():void{
			if(zuduan())return;
			if(!_isJumping&&!_isWalkLefting&&!isRunRight){
				ztreSet();
				_isWalkLefting = true;
				this.body.position.y-=3;
				
				this._bodyMc.gotoAndPlay("runBegin");
				this.isRunBegin = true;
			}
			
			if(this.isRunBegin&&this._bodyMc.currentFrame == this._bodyMc.endFrame){
				this.isRunBegin = false;
				this._bodyMc.gotoAndPlay("run");
				this.isRunStop = true;
			}
			
			
			this.scaleX = 1;
			if(this.isAvoiding)return;
			this.body.velocity.x = this.body.velocity.x>-maxSpeed?this.body.velocity.x -= minSpeed:-maxSpeed;
			
		}
		
		public function runRight():void{
			if(zuduan())return;
			if(!_isJumping&&!_isWalkRighting&&!isRunLeft){
				ztreSet();
				_isWalkRighting = true;
				this.body.position.y-=3;
				this._bodyMc.gotoAndPlay("runBegin");
				this.isRunBegin = true;
			}
			
			if(this.isRunBegin&&this._bodyMc.currentFrame == this._bodyMc.endFrame){
				this.isRunBegin = false;
				this._bodyMc.gotoAndPlay("run");
				this.isRunStop = true;
			}
			
			this.scaleX = -1;
			if(this.isAvoiding)return;
			this.body.velocity.x = this.body.velocity.x<maxSpeed?this.body.velocity.x += minSpeed:maxSpeed;
		}
		
		
		
		
		
		
		private var isJumpUp:Boolean = false;
		private var jumpUpBegin:Boolean = false;
		private var isJumpDown:Boolean = false;
		
		public override function jump():void{
//			if(找到判断起跳时的速度)return;
			if(zuduan())return;
			if(!_isJumping){
				ztreSet();
				_isJumping = true;
				if(!xiaohaotili(10))return;
				this.isJump = false;
				this._bodyMc.gotoAndPlay("jumpUp");
				jumpUpBegin = true;
			}
			
			
			
			if(this._bodyMc.currentFrame == this._bodyMc.endFrame){
				if(!this.isJumpUp){
					this.isJumpUp = true;
					this.body.velocity.y-=jumpPow;
					jumpUpBegin = false;
				}
				this._bodyMc.gotoAndStop(this._bodyMc.endFrame);
			}
			
			
			if(!isJumpDown&&!jumpUpBegin&&this.body.velocity.y >= 0&&this.body.velocity.y <= 1){
				isJumpDown = true;
				this._bodyMc.gotoAndPlay("jumpDown");
			}
			
			
			if(isJumpDown){
				if(this._bodyMc.currentFrame == this._bodyMc.endFrame-1){
					isJumpDown = false;
					_isJumping = false;
					this.isJumpUp = false;
					/**starling 的帧从0开始的*/
					this._bodyMc.gotoAndStop(this._bodyMc.endFrame);
					this.isAtking = false;
					this.isJumpAtking = false;
				}
			}
			
		}
		
		
		private var _isGedang:Boolean = false;
		private var _isGedanging:Boolean = false;
		private function _gedang():void{
			if(this._isJumping||this.isAtking)return;
			if(zuduan())return;
			if(!_isGedang){
				ztreSet();
				_isGedang = true;
				_isGedanging = true;
				this._bodyMc.gotoAndPlay("gedang");
			}
			
			if(_isGedanging){
				
			}
		}
		
		override public function moveL():void
		{
			this.isRunRight = false;
			this.isRunLeft = true;
		}
		
		override public function getX():int
		{
			return this.x;
		}
		
		override public function getY():int
		{
			return this.y;
		}
		
		
		override public function moveR():void
		{
			this.isRunRight = true;
			this.isRunLeft = false;
		}
		
		override public function removeSelf():void
		{
			super.removeSelf();
		}
		
		override public function getPlayFrameOver(num:int = 0,isCZ:Boolean = false):Boolean
		{
//			trace(this._bodyMc.currentLabel+"  > "+this._bodyMc.currentFrame+" : "+(this._bodyMc.endFrame-num)+"   end  "+this._bodyMc.endFrame);
			if(isCZ){
				gjendNum = num;
			}else{
				gjendNum = getGJSZ()["bcf"];
			}
			
			if(this._bodyMc.currentLabel == "stand"){
				return true;
			}
			if(this._bodyMc.currentFrame == this._bodyMc.endFrame-gjendNum){
				this.isAtking = false;
				return true;
			}
			return false;
		}
		
		override public function moveStop():void
		{
			this.isRunRight = false;
			this.isRunLeft = false;
			super.moveStop();
		}
		
		override public function beHit(vx:Number,cy:Number,gjl:Number):void
		{
			this.theBeHit(vx,cy,gjl);
		}
		
		override public function getScaleX():int
		{
			/**不知道为什么不能是 this.scaleX*/
			return this.scaleX;
		}
		
		override public function getHitMc():SwfImage
		{
			return this._bodyMc.getImage("hitMc");
		}
		
		override public function getIsBeHitOuting():Boolean
		{
			return this.isBeHitOuting;
		}
		
		override public function getIsBeHiting():Boolean
		{
			return this.isBeHiting;
		}
		
		
		
		
		override public function getGJSZ():Object{
			return this.gongjizhaoshiArr[this.cgjNum-1];
		}
		
		override public function getGJSZArr():Array
		{
			return this.gongjizhaoshiArr;
		}
		
		
		
		override public function gedang():void
		{
			_gedang();
		}
		
		override public function gedangOver():void
		{
			this._isGedang = false;
			this._isGedanging = false;
		}
		
		override public function getStop():void
		{
			super.getStop();
			this.ztreSet();
			stand();
			this.body.velocity.x = 0;
			this.body.velocity.y = 0;
		}
		
		override public function getHeight():Number
		{
			return this.height;
		}
		
		override public function getParent():DisplayObjectContainer
		{
			return this.parent;
		}
		
		override public function getThisChildIndex():int
		{
			return this.parent.getChildIndex(this);
		}
		
		override public function getTheDongzuo(label:String, DZcbkFNum:int, DZcbk:Function):void
		{
			this.getDongzuo(label, DZcbkFNum, DZcbk);
		}
		
		
		
	}
}