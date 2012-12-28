package 
{
		import flash.display.MovieClip;
		import flash.display.Bitmap;
		import flash.display.BitmapData;
		import flash.utils.getDefinitionByName;

	public class MilitaryToken extends MovieClip 
	{
		private var pts:Number;
		private var image:Bitmap;
		
		
 		public function MilitaryToken(amt:Number) 
		{
			pts = amt;
			makeImage(amt);
		}
		
		protected function makeImage(amt:Number):void {
			var imageName:String;
			if(amt < 0){
				imageName = "militaryloss";
			}else{
				imageName = "military" + String(amt) + "pt";
			}
			var ClassReference:Class = getDefinitionByName(imageName) as Class;
			var classInstance:BitmapData;
  			classInstance = new ClassReference (0,0) as BitmapData;
			var bitmap:Bitmap=new Bitmap(classInstance);
			image = bitmap;
			addChild(bitmap);
		}
		
		public function getImage():Bitmap{
			return image;
		}
		


	}
}