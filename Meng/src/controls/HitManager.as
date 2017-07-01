package controls
{
	import elements.I.IGuai;
	import elements.I.IHitObj;
	
	import nape.callbacks.CbEvent;
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
	import nape.callbacks.PreCallback;
	import nape.callbacks.PreFlag;
	import nape.callbacks.PreListener;
	import nape.dynamics.CollisionArbiter;
	

	public class HitManager
	{
		public static var roles:CbType = new CbType();
		public static var hitBox:CbType = new CbType();
		public static var onXlDb:CbType = new CbType();
		public static var onXlGg:CbType = new CbType();
		public static var hitDie:CbType = new CbType();
		public static var mogu:CbType = new CbType();
		public static var ggXlXj:CbType = new CbType();
		public static var door:CbType  = new CbType();
		public static var daoju:CbType = new CbType();
		public static var tsp:CbType = new CbType();
		public static var diban:CbType = new CbType();
		
		public function HitManager()
		{
			
		}
		
		private static var _instance:HitManager;
		
		
		public static function getInstance():HitManager{
			if(!_instance)_instance = new HitManager();
			return _instance;
		}
		
		public function hitMgr():void
		{
			
//			var roleHitDibanListener:InteractionListener=new InteractionListener(CbEvent.BEGIN,InteractionType.COLLISION,HitManager.roles,HitManager.diban,roleHitDiban);
//			Napes.instance.space.listeners.add(roleHitDibanListener);
			
			var roleHitRoleListener:InteractionListener=new InteractionListener(CbEvent.BEGIN,InteractionType.COLLISION,HitManager.roles,HitManager.roles,test);
			Napes.instance.space.listeners.add(roleHitRoleListener);
			
			
			var roleHitBoxListener:InteractionListener=new InteractionListener(CbEvent.BEGIN,InteractionType.COLLISION,HitManager.roles,HitManager.hitBox,roleHitBox);
			Napes.instance.space.listeners.add(roleHitBoxListener);
			
			var roleXlBoxListener:InteractionListener=new InteractionListener(CbEvent.ONGOING,InteractionType.COLLISION,HitManager.roles,HitManager.onXlDb,roleXlBox);
			Napes.instance.space.listeners.add(roleXlBoxListener);
			
			var roleXlGgListener:InteractionListener=new InteractionListener(CbEvent.BEGIN,InteractionType.COLLISION,HitManager.roles,HitManager.onXlGg,roleXlGg);
			Napes.instance.space.listeners.add(roleXlGgListener);
			
			var hitDieListener:InteractionListener=new InteractionListener(CbEvent.BEGIN,InteractionType.COLLISION,HitManager.roles,HitManager.hitDie,hitDie);
			Napes.instance.space.listeners.add(hitDieListener);
			
			var moguListener:InteractionListener=new InteractionListener(CbEvent.BEGIN,InteractionType.COLLISION,HitManager.roles,HitManager.mogu,mogu);
			Napes.instance.space.listeners.add(moguListener);
			
			var ggXlXjListener:InteractionListener=new InteractionListener(CbEvent.BEGIN,InteractionType.COLLISION,HitManager.roles,HitManager.ggXlXj,ggXlXj);
			Napes.instance.space.listeners.add(ggXlXjListener);
			
			var ggXLMoguListener:InteractionListener = new InteractionListener(CbEvent.BEGIN,InteractionType.COLLISION,HitManager.mogu,HitManager.ggXlXj,ggXlXjMogu);
			Napes.instance.space.listeners.add(ggXLMoguListener);
			
			var doorListener:InteractionListener = new InteractionListener(CbEvent.BEGIN,InteractionType.COLLISION,HitManager.roles,HitManager.door,doorHit);
			Napes.instance.space.listeners.add(doorListener);
			
			var daojuListener:InteractionListener = new InteractionListener(CbEvent.BEGIN,InteractionType.COLLISION,HitManager.roles,HitManager.daoju,daojuHit);
			Napes.instance.space.listeners.add(daojuListener);
			
//			var preListener:PreListener = new PreListener(InteractionType.COLLISION,HitManager.onXlGg,HitManager.hitDie,onPre);
//			Napes.instance.space.listeners.add(preListener);
			
			var preListener2:PreListener = new PreListener(InteractionType.COLLISION,HitManager.roles,HitManager.roles,onPre);
			Napes.instance.space.listeners.add(preListener2);
			
			
		}
		
		private function roleHitDiban(cb:InteractionCallback):void
		{
			// TODO Auto Generated method stub
//			trace("hitdiban" +cb.int1.castBody.graphic.parent.x+"    "+cb.int2.castBody.graphic.parent.x);
		}
		
		private function test(cb:InteractionCallback):void
		{
			// TODO Auto Generated method stub
//			trace("hittest!!!");
		}
		
//		public function PreListener(
//			interactionType:InteractionType, 
//			options1:*, 
//			options2:*, 
//			handler:Function, 
//			precedence:int=0, 
//			pure:Boolean=false
//		)
		
		private function onPre(cb:PreCallback):PreFlag
		{
//			var ca:CollisionArbiter = cb.arbiter.collisionArbiter;
//			if (cb.swapped && ca.normal.y>0 ) return PreFlag.IGNORE;
//			if(!cb.swapped && ca.normal.y<0) return PreFlag.IGNORE;
//			trace(">>>>>>>>>>>>>>?????????????????");
			return  PreFlag.IGNORE;
		}	
		
		private function daojuHit(cb:InteractionCallback):void
		{
			(cb.int2.castBody.graphic.parent as IHitObj).hitCbk();
		}
		
		private function doorHit(cb:InteractionCallback):void
		{
			(cb.int2.castBody.graphic.parent as IHitObj).hitCbk();
		}
		
		private function ggXlXjMogu(cb:InteractionCallback):void
		{
			//可以压死怪物
			(cb.int1.castBody.graphic.parent as IGuai).igetDie(cb.int2);
		}
		
		private function ggXlXj(cb:InteractionCallback):void{
			(cb.int2.castBody.graphic.parent as IHitObj).hitCbk(cb.int1);
		}
		
		private function mogu(cb:InteractionCallback):void{
			(cb.int2.castBody.graphic.parent as IHitObj).hitCbk(cb.int1);
		}
		
		private function hitDie(cb:InteractionCallback):void{
//			trace("hei!!!");
//			if(cb.int2.castBody.graphic.parent is IHitObj)(cb.int2.castBody.graphic.parent as IHitObj).hitCbk();
//			Globals.cat.isDie = true;
			
		}
		
		private function roleXlGg(cb:InteractionCallback):void
		{
			(cb.int2.castBody.graphic.parent as IHitObj).hitCbk(cb.int1);
		}
		
		private function roleXlBox(cb:InteractionCallback):void
		{
			(cb.int2.castBody.graphic.parent as IHitObj).hitCbk(cb.int1);
		}
		private function roleHitBox(cb:InteractionCallback):void
		{
			(cb.int2.castBody.graphic.parent as IHitObj).hitCbk(cb.int1);
		}
	}
}