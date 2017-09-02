package elements.role
{
	import com.greensock.TweenLite;
	
	import flash.filters.DisplacementMapFilter;
	
	import controls.BeHitColor;
	import controls.GetHit;
	import controls.Globals;
	
	import elements.I.Ibiont;
	import elements.jineng.JinengObj;
	import elements.jineng.JinengVO;
	import elements.texiao.TexiaoPool;
	import elements.texiao.TexiaoPool2;
	
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
			if(!_jinengVO)_jinengVO = new JinengVO();
			if(!acStopNums)acStopNums = ACStopNums.getInstance();
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
			
			isRoleInAir();
			
			
			
			
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
			
			
			
				if(isRunLeft){
					this.runLeft();
				}
				
				if(isRunRight){
					this.runRight();
				}
			
			
			
			
			if(_isDongzuoing){
				Dongzuoing();
				return;
			}
			
			if(_isJumping){
				jump();
			}
			
			
			if(!this.isCanAtk&&_isInAir&&!isBeHit&&!isStand&&!_isDie&&!_isDongzuoing&&!isBeHitOuting){
				this._bodyMc.gotoAndPlay("jumpUp");
				this._bodyMc.gotoAndStop(this._bodyMc.endFrame);
			}
			
			
			if(!this.isCanAtk&&!isRunLeft &&!isRunRight&&!isBeHit&&!isStand&&!_isJumping&&!_isDie&&!_isDongzuoing&&!isAvoiding){
				if(_isInAir){
					this._bodyMc.gotoAndPlay("jumpUp");
					this._bodyMc.gotoAndStop(this._bodyMc.endFrame);
				}else{
					stand();
				}
				
				return;
			}
			
			
			
			
		}
		
		
		private function isRoleInAir():Boolean{
			if(_isInAir){
				if(this.body.velocity.y >= 0&&this.body.velocity.y <= 1){
					_isInAir = false;
					return false
				}else{
					true;
				}
			}
			return false;
		}
		
		
		
		
		
		
		private var _isRest:Boolean = false;
		private var _isResting:Boolean = false;
		private function getRest():void{
			if(zuduan2())return;
			if(!this._isRest){
				this.ztreSet();
				this._isInAir = false;
				this._isRest = true;
				this._isResting = true;
				this._bodyMc.gotoAndPlay("rest");
			}
			
			if(this._bodyMc.currentLabel=="rest" &&  this._bodyMc.currentFrame == this._bodyMc.endFrame){
				this._isResting = false;
				_isRest = false;
			}
		}
		
		
		private function theBeHiting():void{
			if(this.isBeHiting){
				if(this._bodyMc.currentFrame == this._bodyMc.endFrame){
					this._isInAir = false;
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
				this._isInAir = false;
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
				acStopNums.stopNums(15,this);
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
		
		
		
		
		
		protected var _isDongzuo:Boolean = false;
		public var _isDongzuoing:Boolean = false;
		/**倒帧返回帧数*/
		protected var _showTXFrameNum:int = 0;
		protected var _DZcbk:Function;
		protected var _DZcanMoveFrame:int = 1;
		
		protected function getDongzuo(label:String,showTXFrameNum:int,DZcbk:Function,DZcanMoveFrame:int=1):void{
//			trace(">>>>>>>>>>>>>>3  "+this.zuduan()+"   "+_isDongzuoing);
//			trace(this.isBeHitOuting + "   "+this.isBeHiting +"  "+this.isStandUping);
			if(this.zuduan()||isAvoiding)return;
//			trace(">>>>>>>>>>>>>>3   "+_isDongzuo);
			if(!_isDongzuo){
				this.ztreSet();
				_isDongzuo = true;
				this._bodyMc.gotoAndPlay(label);
				_showTXFrameNum = this._bodyMc.currentFrame+showTXFrameNum;
				_DZcanMoveFrame = DZcanMoveFrame;
				if(_DZcanMoveFrame>=this._bodyMc.endFrame-showTXFrameNum){
					_DZcanMoveFrame = showTXFrameNum-1;
				}
				_DZcbk = DZcbk;

//				trace(">>>>>>>>>>>>>>4");
				_isDongzuoing = true;
			}
		}
		
		protected function Dongzuoing():void{
			if(_isInAir){
				_isJumping = true;
			}
			
			
			if(this._bodyMc.currentFrame==_showTXFrameNum){
				_DZcbk();
			}
			if(this._bodyMc.currentFrame == this._bodyMc.endFrame-_DZcanMoveFrame){
				this._isDongzuoing = false;
				_isDongzuo = false;
			}
		}
		
		
		
		protected var _isInAir:Boolean = false;
		
		
		//当前帧 防止同一帧多跑
		private var theCF:int = -1;
		
		public var isCanAtk:Boolean = false;
		//攻击后没有收招完就可以移动
		protected var isCanAtkedMove:Boolean = false;
		public override function atk(nums:int = 0):void
		{
			if(this._isGedanging)return;
			if(this.isAvoiding)return;
			if(zuduan())return;
			
			if(nums == 0){
				
			}else{
				gjNum = cgjNum = nums-1;
			}
			
			if(_isInAir){
				if(this.gjNum >= this.jumpGJArr.length)this.gjNum = 0;
				_jinengVO.getVO(JinengObj[jumpGJArr[this.gjNum]]);
			}else{
				if(this.gjNum >= this.gongjizhaoshiArr.length)this.gjNum = 0;
				_jinengVO.getVO(JinengObj[gongjizhaoshiArr[this.gjNum]]);
			}
			
			
			if(!xiaohaotili(_jinengVO.xhtl))return;
			
			
			
			if(_isInAir){
				TexiaoPool2.getInstance().getOnTexiao(_jinengVO.jnName,this);
				this.body.velocity.y = 0;
				this.body.velocity.y = -200;
			}else{
				
				TexiaoPool2.getInstance().getOnTexiao(_jinengVO.jnName,this);
			}
			
			
			this.gjNum++;
			this.cgjNum = this.gjNum;
			
			
			gjnqnum = 0;
			
		}
		
		
		public function xiaohaotili(num:Number):Boolean{
			this._roleTili.getXRest();
			if(_roleTili.curTili==1){
				_roleTili.curTili = 0;
				return false;
			}
			if(_roleTili.curTili-num>=0){
				this._roleTili.curTili-=num;
			}else{
				this._roleTili.curTili = 1;
				return false;
			} 
			return true;
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
				this._bodyMc.gotoAndPlay(labelAvoid);
				this.body.velocity.y = 0;
				this.body.velocity.x = 0;
				this.body.velocity.x+=this.scaleX*690;
				this.body.velocity.y-=400;
			}
			
			if(this._bodyMc.currentFrame == this._bodyMc.endFrame){
				isAvoiding  =false;
			}
			
			
		}
		
		private var gjendNum:int = 1;
		
		
		
		
		private function theBeHit(cjvx:Number,cjvy:Number,gjl:Number):void
		{
			if(this.isDie())return;
			if(this._isGedanging){
				/**格挡计算*/
				if(this._roleTili)this._roleTili.curTili-=gjl;
				theVelocityX(cjvx);
				TexiaoPool.getInstance().getOnTexiao("mc_ba1_gjtx",this,0,-60);
				return;
			}
			
			if(_roleTili)_roleTili.getBeHitTiliStart();
			
			
			
			this._roleLive.curLive-=(gjl - this.fangyuli);
			if(this._roleLive.curLive<=0)this._isDie = true;
			this.body.velocity.x =0;
			this.body.velocity.y = 0;
			
			this._beHitCorlor.getBeHitColor(this._bodyMc);
			MySoundPool.instance.getSound("beHit",Globals.soundNums);
			
			if(!this._isJumping)this._bodyMc.stop();
			TweenLite.to(this._bodyMc,0.1,{"onComplete":onComplete});
			theVelocityX(cjvx);
			/**特效*/
			TexiaoPool.getInstance().getOnTexiao("mc_ba1_gjtx",this,0,-60);
			
			
			
			//每个都要单独reset 
			
			if(this.isDie()){
				this.ztreSet();
				this.isBeHitOut = true;
				this.beHitOut();
				return;
			}
			
			
			if(gjl/this.yingzhi>=2){
				this.ztreSet();
				this.isBeHitOut = true;
				this.beHitOut();
				theVelocityY(-cjvy);
				return;
			}
			
			
//			if(gjl/this.yingzhi>=2){
//				this.ztreSet();
//				this.isBeHitOut = true;
//				this.beHitOut();
//				return;
//			}
			
			//			this.body.velocity.y-=300;
			
			//被攻击不一定被击退  看硬直属性
			//加if(瞬间总伤害和>硬直)
			
			if(this._isJumping&&_isInAir){
				this.ztreSet();
				this.isBeHitOut = true;
				this.beHitOut();
				return;
			}
			
			if(this.isBeHitOuting){
				this.ztreSet();
				this.isBeHitOut = true;
				this.beHitOut();
				return;
			}
			
			
			if(gjl/this.yingzhi>=1){
				this.ztreSet();
				if(this._bodyMc.currentLabel=="beHitOut"){
					
					this.isBeHitOut = true;
					this.beHitOut();
					
					return;
				}
				this.isBeHiting = true;
				this._bodyMc.gotoAndPlay(labelBeHit);
				return;
			}
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
			
			
			acStopNums.mcPlay();
			
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
			_isInAir = false;
			this._bodyMc.gotoAndPlay(labelStand);
		}
		
		
		
		
		private var _isWalkLefting:Boolean = false;
		private var _isWalkRighting:Boolean = false;
		private var _isJumping:Boolean = false;
		
		private var isRunStop:Boolean = false;
		private var isRunStoping:Boolean = false;
		
		
		private var isRunBegin:Boolean = false;
		public function runLeft():void{
			if(zuduan())return;
			if(!_isJumping&&!_isWalkLefting&&!isRunRight&&!_isInAir){
				ztreSet();
				_isWalkLefting = true;
				this.body.position.y-=3;
				
				this._bodyMc.gotoAndPlay("runBegin");
				this.isRunBegin = true;
			}
			
			if(this.isRunBegin&&this._bodyMc.currentFrame == this._bodyMc.endFrame){
				this.isRunBegin = false;
				this._bodyMc.gotoAndPlay(labelRun);
				this.isRunStop = true;
			}
			
			
			this.scaleX = 1;
			if(this.isAvoiding)return;
			this.body.velocity.x = this.body.velocity.x>-maxSpeed?this.body.velocity.x -= minSpeed:-maxSpeed;
			
		}
		
		public function runRight():void{
			if(zuduan())return;
			if(!_isJumping&&!_isWalkRighting&&!isRunLeft&&!_isInAir){
				ztreSet();
				_isWalkRighting = true;
				this.body.position.y-=3;
				this._bodyMc.gotoAndPlay("runBegin");
				this.isRunBegin = true;
			}
			
			if(this.isRunBegin&&this._bodyMc.currentFrame == this._bodyMc.endFrame){
				this.isRunBegin = false;
				this._bodyMc.gotoAndPlay(labelRun);
				this.isRunStop = true;
			}
			
			this.scaleX = -1;
			if(this.isAvoiding)return;
			this.body.velocity.x = this.body.velocity.x<maxSpeed?this.body.velocity.x += minSpeed:maxSpeed;
		}
		
		
		
		
		
		
		private var isJumpUp:Boolean = false;
		private var jumpUpBegin:Boolean = false;
		private var isJumpDown:Boolean = false;
		
		private var _inAirFrame:int = 0;
		
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
			
			
			
			if(this._bodyMc.currentLabel=="jumpUp" &&this._bodyMc.currentFrame == this._bodyMc.endFrame){
				if(!this.isJumpUp){
					this.isJumpUp = true;
					this.body.velocity.y = 0;
					this.body.velocity.y-=jumpPow;
					_isInAir = true;
					jumpUpBegin = false;
					_inAirFrame = this._bodyMc.endFrame;
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
					_isInAir = false;
					this.isJumpUp = false;
					/**starling 的帧从0开始的*/
					this._bodyMc.gotoAndStop(this._bodyMc.endFrame);
				}
			}
			
		}
		
		
		private var _isGedang:Boolean = false;
		private var _isGedanging:Boolean = false;
		private function _gedang():void{
			if(this._isJumping||this._isDongzuoing)return;
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
			runLeft();
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
			runRight();
		}
		
		override public function removeSelf():void
		{
			super.removeSelf();
		}
		
		override public function getPlayFrameOver(num:int = 0,isCZ:Boolean = false):Boolean
		{
//			trace(this._bodyMc.currentLabel+"  > "+this._bodyMc.currentFrame+" : "+(this._bodyMc.endFrame-num)+"   end  "+this._bodyMc.endFrame);
//			if(isCZ){
//				gjendNum = num;
//			}else{
//				gjendNum = getJNObj()["bcf"];
//			}
			
			
			if(this._bodyMc.currentLabel == "stand"){
				return true;
			}
			
			if(zuduan()){
				return false;
			}
			
			return !_isDongzuoing;
			
//			if(this.isAtking&&this._bodyMc.currentFrame == this._bodyMc.endFrame-gjendNum){
//				this.isAtking = false;
//				return true;
//			}
			return false;
		}
		
		override public function moveStop():void
		{
			this.isRunRight = false;
			this.isRunLeft = false;
			super.moveStop();
		}
		
		override public function beHit(cjvx:Number,cjvy:Number,gjl:Number):void
		{
			this.theBeHit(cjvx,cjvy,gjl);
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
		
		
		
		private var _jinengVO:JinengVO;
		override public function getJNObj():JinengVO{
			_jinengVO.getVO(JinengObj[this.gongjizhaoshiArr[this.cgjNum-1]])
			return _jinengVO;
		}
		
		override public function getJNObjArr():Array
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
		
		override public function getTheDongzuo(label:String, showTXFrameNum:int, DZcbk:Function,DZcanMoveFrame:int=1):void
		{
			this.getDongzuo(label, showTXFrameNum, DZcbk,DZcanMoveFrame);
		}
		
		override public function getACStopNums(nums:int):void
		{
			acStopNums.stopNums(nums,this);
		}
		
		
		
	}
}