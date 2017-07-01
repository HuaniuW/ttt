package screens
{
	import flash.geom.Point;
	
	import controls.GameManager;
	import controls.Globals;
	
	import elements.role.RoleO;
	
	import game.engine.Engine;
	
	import lzm.starling.display.Button;
	import lzm.starling.gestures.HoverGestures;
	import lzm.starling.gestures.MoveOverGestures;
	import lzm.starling.gestures.TapGestures;
	import lzm.starling.swf.display.SwfSprite;
	
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import lzm.starling.gestures.HoldGestures;
	
	public class BtnUI extends Sprite
	{
		private var gMgr:GameManager;
		private var btnFX:Button;
		private var btnA:Button;
		private var btnB:Button;
		private var btnC:Button;
		private var btnBar:SwfSprite;
		public function BtnUI()
		{
			super();
			gMgr = GameManager.getInstance();
			
			
			
			
			
			
			btnFX = new Button(gMgr.assetMgr.createImage("img_UI_btnFX"));
			addChild(btnFX);
			btnFX.x = 50;
			btnFX.y = Starling.current.stage.stageHeight - btnFX.height+90;
			btnFX.addEventListener(TouchEvent.TOUCH,onTouchFX);
			
			
			btnA = new Button(gMgr.assetMgr.createImage("img_UI_btnA"));
			addChild(btnA);
			btnA.x = Starling.current.stage.stageWidth - btnA.width*3;
			btnA.y = Starling.current.stage.stageHeight - btnA.height-60; 
			new TapGestures(btnA,getAtk);
//			new MoveOverGestures(btnA,getAtk);
			
			var holdGestures:HoldGestures = new HoldGestures(btnA,onGetAtk,holdCbk,holdStarCbk);
			holdGestures.holdTime = 200;
			
			btnB = new Button(gMgr.assetMgr.createImage("img_UI_btnB"));
			addChild(btnB);
			btnB.x = Starling.current.stage.stageWidth - btnB.width-30;
			btnB.y = btnA.y-20;
			this.btnB.addEventListener(TouchEvent.TOUCH,onJump);
			
			btnC = new Button(gMgr.assetMgr.createImage("img_UI_btnC"));
			addChild(btnC);
			btnC.x = Starling.current.stage.stageWidth - btnB.width-30;
			btnC.y = btnB.y-btnC.height-30;
			this.btnC.addEventListener(TouchEvent.TOUCH,avoid);
			
			
			
			Engine.createEngine().push(action);
		}
		
		private function holdStarCbk():void
		{
			trace("holdStarCbk");
			
		}
		
		private function holdCbk():void
		{
			// TODO Auto Generated method stub
			trace("holdCbk");
			_role.gedangOver();
		}
		
		private function onGetAtk():void
		{
			// TODO Auto Generated method stub
//			trace("on");
			_role.gedang();
		}
		
		private function avoid(e:TouchEvent):void
		{
			var btn:Button = e.currentTarget as Button;
			if(e.getTouch(btn,TouchPhase.BEGAN))
			{
				if(_role)
				{
					_role.avoid();
				}
			}
		}		
		
		private function onJump(e:TouchEvent):void{
			var btn:Button = e.currentTarget as Button;
			
			if(e.getTouch(btn,TouchPhase.BEGAN))
			{
				if(_role)
				{
					_role.jump();
				}
			}
		}
		
		private function action():void
		{
			// TODO Auto Generated method stub
			if(_role){
				_role.isRunLeft = btnX ==btnFXX-10;
				_role.isRunRight = btnX == btnFXX+10;
			}
		}
		
		
		private var btnX:int = 0;
		private var btnFXX:int = 50;
		private function onTouchFX(e:TouchEvent):void
		{
			var btn:Button = e.currentTarget as Button;
			var touch:Touch = e.getTouch(btn);
			if(touch)var pos:Point = touch.getLocation(btn);
//			trace("pos   "+pos+"  w   "+btn.width+"   x  "+btn.x);
			var _w2:int = btn.width*0.5
				
			if(e.getTouch(btn,TouchPhase.BEGAN)||e.getTouch(btn,TouchPhase.MOVED))
			{
				if(pos.x>=_w2-30){
					btnX = btn.x = btnFXX+10;
				}else{
					btnX = btn.x = btnFXX-10
				}
				
			}else if(touch &&e.getTouch(btn,TouchPhase.ENDED))
			{
				btnX = btnX = 0;
			}
		}
		
		private var _role:RoleO;
		public function getRole(role:RoleO):void
		{
			if(this._role)this._role = null;
			_role = role;
		}
		
		private function getJump(touch:Touch):void
		{
			if(_role)
			{
				_role.jump();
			}
			
		}
		
		private function getAtk(touch:Touch):void
		{
			if(_role)_role.atk();
		}
		
		private static var _instance:BtnUI;
		public static function getInstance():BtnUI
		{
			if(!_instance)_instance = new BtnUI();
			return _instance;
		}
		
		public function onStage(contaner:DisplayObjectContainer):void
		{
			contaner.addChild(this);
			this.visible = !Globals.isKeyBorad;
		}
		
		public function removeSelf():void
		{
			this.removeFromParent();
		}
	}
}