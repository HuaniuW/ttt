package elements.role
{
	
	import controls.HitManager;
	
	import elements.I.IElementBase;
	import elements.I.IHit;
	import elements.I.Ibiont;
	import elements.jineng.JinengVO;
	
	import lzm.starling.swf.display.SwfImage;
	import lzm.starling.swf.display.SwfMovieClip;
	import lzm.starling.swf.display.SwfSprite;
	
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Circle;
	import nape.shape.Polygon;
	import nape.shape.Shape;
	import nape.space.Space;
	
	import starling.display.DisplayObjectContainer;
	
	
	public class RoleBase extends SwfSprite implements IElementBase,Ibiont,IHit
	{
		/**攻击力*/
		public var gongjili:int = 0;
		/**防御力*/
		public var fangyuli:int = 0;
		/**硬直*/
		public var yingzhi:int = 0;
		public var minSpeed:Number = 0;
		public var maxSpeed:Number = 0;
		public var jumpPow:Number = 0;
		
		public var gongjizhaoshiArr:Array = [];
		public var jumpGJArr:Array = [];
		
		protected var _isDie:Boolean = false;
		
		
		
		public var jinengArr:Array = [];
		
		public var gjNum:int = 0;
		
		public var alertDistance:int = 200;
		
		public var beHitAcArr:Array = [];
		
		/**重量 硬直*/
		public var weight:Number = 0;
		
		public var maxLive:Number = 0;
		public var curLive:Number = 0;
		public var maxTili:Number = 0;
		public var curTili:Number = 0;
		
		
		protected var _bodyMc:SwfMovieClip;
		protected var _dataObj:Object;
		protected var _space:Space;
		public var body:Body;
		/**
		 *当前攻击是第几招 
		 */		
		public var cgjNum:int = -1;
		public var gjnqnum:int = 0;
		
		
		public var _roleLive:RoleLive;
		public var _roleTili:RoleTili;
		
		public var shiyingTXScale:Number = 1;
		
		
		protected var enemyArr:Array = [];
		
		public function RoleBase(mc:SwfMovieClip,dataObj:Object,_x:Number,_y:Number,w:Number,h:Number,space:Space)
		{
			super();
			_bodyMc = mc;
			_dataObj = dataObj;
			_space = space;
			view(_x,_y,w,h);
		}
		
		private var shape:Polygon;
		private function view(_x:Number,_y:Number,_w:Number,_h:Number):void
		{
			body = new Body(BodyType.DYNAMIC,new Vec2(_x,_y));
			body.cbTypes.add(HitManager.roles);
			shape = new Polygon(Polygon.box(int(_w-10),int(_h-11)));
			body.shapes.push(shape);
//			trace("w>>  "+_w+" h: "+_h+" x "+_x+"  y "+_y);
			var circle:Shape =new Circle((int(_w-10))*0.5);
			circle.localCOM.setxy(0,_h*0.5-10);
			body.shapes.push(circle);
			body.align();
			body.space = _space;
			body.position.x = _x;
			body.position.y = _y;
			body.allowRotation = false;
			_bodyMc.pivotY = -_bodyMc.height*0.5;
			_bodyMc.y =0;
			_bodyMc.rotation = body.rotation;
			body.graphic = _bodyMc;
			addChild(body.graphic);
			
			
		}
		
		/**
		 *设置自己 body 和刚体的 Y的误差 
		 * @param nums
		 * 
		 */		
		protected function setBodyY(nums):void{
			_bodyMc.pivotY = -_bodyMc.height*0.5+nums;
		}
		
		public function getEnemyArr():Array
		{
			return this.enemyArr;
		}
		
		public function getCurrentLabel():String
		{
			return this._bodyMc.currentLabel;
		}
		
		
		
		public function getAction(acName:String):void
		{
			_bodyMc.gotoAndPlay(acName);
		}
		
		
		public function removeSelf():void
		{
		}
		
		public function atk(nums:int = 0):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function jump():void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function moveL():void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function moveR():void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function getX():int
		{
			// TODO Auto Generated method stub
			return 0;
		}
		
		public function getWidth():Number
		{
			// TODO Auto Generated method stub
			return this.weight;
		}
		
		public function theVelocityX(vx:Number):void
		{
			this.body.velocity.x = 0;
			this.body.velocity.x+=vx;
		}
		
		
		
		public function theVelocityY(vy:Number):void
		{
			this.body.velocity.y+=vy;
		}
		
		
		public function getY():int
		{
			// TODO Auto Generated method stub
			return 0;
		}
		
		public function getPlayFrameOver(num:int = 0,isCZ:Boolean = false):Boolean
		{
			// TODO Auto Generated method stub
			return false;
		}
		
		public function moveStop():void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function beHit(cjvx:Number,cjvy:Number,gjl:Number):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function getBeHitMc():SwfImage
		{
			// TODO Auto Generated method stub
			return null;
		}
		
		public function getScaleX():int
		{
			// TODO Auto Generated method stub
			return 1;
		}
		
		
		public function getHitMc():SwfImage
		{
			// TODO Auto Generated method stub
			return null;
		}
		
		
		
		public function getIsBeHitOuting():Boolean
		{
			// TODO Auto Generated method stub
			return false;
		}
		
		public function getIsBeHiting():Boolean
		{
			// TODO Auto Generated method stub
			return false;
		}
		
		
		
		public function getIsAtking():Boolean
		{
			// TODO Auto Generated method stub
			return false;
		}
		
		public function getAlertDistance():int
		{
			// TODO Auto Generated method stub
			return this.alertDistance;
		}
		
		/**
		 *取到攻击属性设置 调整攻击范围等。。。 
		 * @return 
		 * 
		 */		
		public function getJNObj():JinengVO
		{
			// TODO Auto Generated method stub
			return null;
		}
		
		public function theCurLive():Number
		{
			// TODO Auto Generated method stub
			return 0;
		}
		
		public function theMaxLive():Number
		{
			// TODO Auto Generated method stub
			return 0;
		}
		
		public function avoid():void
		{
			// TODO Auto Generated method stub
		}
		
		public function gedang():void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function gedangOver():void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function theCurTili():Number
		{
			// TODO Auto Generated method stub
			return this._roleTili.curTili;
		}
		
		public function theMaxTili():Number
		{
			// TODO Auto Generated method stub
			return this._roleTili.maxTili;
		}
		
		public function getRoleLive():RoleLive
		{
			// TODO Auto Generated method stub
			return this._roleLive;
		}
		
		public function getRoleTili():RoleTili
		{
			// TODO Auto Generated method stub
			return this._roleTili;
		}
		
		public function isDie():Boolean
		{
			// TODO Auto Generated method stub
			return _isDie;
		}
		
		public function getStop():void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function getJNObjArr():Array
		{
			// TODO Auto Generated method stub
			return null;
		}
		
		public function getHeight():Number
		{
			// TODO Auto Generated method stub
			return 0;
		}
		
		public function getParent():DisplayObjectContainer
		{
			// TODO Auto Generated method stub
			return null;
		}
		
		public function getThisChildIndex():int
		{
			// TODO Auto Generated method stub
			return 0;
		}
		
		public function getTheDongzuo(label:String, showTXFrameNum:int, DZcbk:Function,DZcanMoveFrame:int=1):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function bodyMcPlay():void
		{
			this._bodyMc.stop();
		}
		
		public function bodyMcStop():void
		{
			this._bodyMc.play();
		}
		
		public function getShiyingTXScale():Number
		{
			// TODO Auto Generated method stub
			return shiyingTXScale;
		}
		
		
		
	}
}