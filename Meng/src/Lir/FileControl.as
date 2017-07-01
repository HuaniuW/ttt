package Lir
{
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.utils.StringUtil;

	public class FileControl
	{
		private static var instance:FileControl;
		
		public function FileControl()
		{
		}
		
		public function createFile(url:String,fileName:String):void
		{	
			var _url:String =  File.applicationDirectory.resolvePath("").nativePath+url+"\\"+fileName;
			var file:File = new File(_url);
			var flieStream:FileStream = new FileStream();
			flieStream.open( file, FileMode.WRITE);
			flieStream.close( ); //记得要关闭流
		}
		
		public static function getInsance():FileControl{
			if(!instance)instance = new FileControl();
			return instance;
		}
		
		public function readFile(url:String):Object{
			var obj:Object;
			var file:File = getFile(url);
			if(file.exists){
			}
			var fs:FileStream = new FileStream();
			fs.open(file,FileMode.READ);
			obj = fs.readObject();
			fs.close();
			return obj;
		}
		
		public function writeFile(url:String,arr:Object):void{
			var obj:Object;
			var file:File = getFile(url);
			if(file.exists){
			}
			var fs:FileStream = new FileStream();
			fs.open(file,FileMode.WRITE);
			fs.writeObject(arr);
			fs.close();
		}
		
		public function writeString(url:String,arr:Object):void{
			var obj:Object;
			var file:File = getFile(url);
			if(file.exists){
			}
			var fs:FileStream = new FileStream();
			fs.open(file,FileMode.WRITE);
			fs.writeObject(arr);
			fs.close();
		}
		
		
		public function isHasFile(url:String):Boolean{
			var _url:String =  File.applicationDirectory.resolvePath("").nativePath+url;
			var file:File = new File(_url);
			if(file.exists)return true;
			return false;
		}
		
		public function getFileUrl(_url:String):String{
			var url:String = File.applicationDirectory.resolvePath("").nativePath+_url;
			return url;
		}
		
		public function getFile(_url:String):File{
			var url:String =  File.applicationDirectory.resolvePath("").nativePath+"\\"+_url;
//			trace("url:  "+url);
			var file:File = new File(url);
			return file;
		}
		
		public function getXMLFile(path:String):XML
		{
			var xml:XML;
			var file:File = File.documentsDirectory.resolvePath(getFileUrl(path));
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.READ);
			xml = XML(fileStream.readUTFBytes(fileStream.bytesAvailable));
			fileStream.close();
			return xml;
		}
		
		
		public function getJsonFile(_url:String):Object{
			var obj:Object;
			var file:File = getFile(_url);
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.READ);
//			trace("fileStream:  "+fileStream.toString());
			obj = JSON.parse(fileStream.toString());
			return obj;
		}
		
		public function getConfig(key:String,defaultValue:String=" ",fileName:String="config.inf"):String
		{
			var value:String = "";
			var url:String = File.applicationDirectory.resolvePath("").nativePath+fileName;
			var file:File = new File(url);
			var fs:FileStream = new FileStream();
			fs.open(file,FileMode.UPDATE);
			var str:String = fs.readUTFBytes(fs.bytesAvailable);
			var items:Array = str.split("\r\n");
			var vals:Array;
			var item:String;
			for(var idx:String in items)
			{
				item = items[idx];
				vals = item.split("=");
				if(vals[0]==key)
				{
					if(vals.length==2)
//						value = StringUtil.trim(vals[1]);
					if(value.length)
					{
						fs.close();
						return value;
					}
					items[idx] = key+"="+defaultValue;
					value = defaultValue;
				}
			}
			if(!value.length)
			{
				items.push(key+"="+defaultValue);
				fs.open(file,FileMode.WRITE);
				fs.writeUTFBytes(items.join("\r\n"));
			}
			fs.close();
			return value;
		}
	}
}