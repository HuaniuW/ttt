package elements.jineng
{
	import flash.utils.getDefinitionByName;
	

	public class JNClassGet
	{
		private var _JNBase:JNBase
		public function JNClassGet()
		{
			
		}
		
		public static function getClass(JNName:String):Class{
			var s:String = "elements.jineng::"+JNName;
			return getDefinitionByName(s) as Class;
		}
	}
}