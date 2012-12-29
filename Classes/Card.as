package 
{
	import flash.display.MovieClip;
		import flash.display.Bitmap;
		import flash.display.BitmapData;
		import flash.events.MouseEvent;
		import flash.utils.getDefinitionByName;
	public class Card extends MovieClip 
	{
		public static const SMALLIMAGESIZE:Number = 85;
		public static const MEDIUMIMAGESIZE:Number = 100;
		private var cardName:String;
		private var color:String;
		private var benefit:String;
		private var cost:Array;
		private var coinCost:Number;
		private var preRequisiteCards:Array;
		private var smallImage:Bitmap;
		private var id:Number;

		
 		public function Card(givenID:Number, givenName:String, moneyCost:Number, costArray:Array, preRequisiteCards:Array = null, benefit:Array = null) 
		{
			id = givenID;
			cardName = givenName;
			makeNewImage(givenName);
			cost = costArray;
			coinCost = moneyCost;
			this.preRequisiteCards = preRequisiteCards;
			makeSmallImage();
		}
		
		function makeClickable():void{
			addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		public function getID():Number{
			return id;
		}
		
		function getColor():String{
			return color;
		}
		function getChain():Array{
			return preRequisiteCards;
		}
		protected function setColor(s:String):void{
			color = s;
		}
		function getCoinCost():Number{
			return coinCost;
		}
		function clickHandler(event:MouseEvent):void {
			dispatchEvent( new ClickEvent( ClickEvent.cardClicked , this ) );
		}
		protected function makeNewImage(file:String):void {
			var bmp:Bitmap = getNewBigImage();
			bmp.scaleX = bmp.scaleY = (MEDIUMIMAGESIZE/bmp.width);
			addChild(bmp);
		}
		public function getSmallImage():Bitmap{
			return smallImage;
		}
		public function makeSmallImage():void{
			var bmp:Bitmap = getNewBigImage();
			bmp.scaleX = bmp.scaleY = (SMALLIMAGESIZE/bmp.width);
			smallImage = bmp;
		}
		public function getName():String{
			return cardName;
		}
		protected function setName(newName:String):void{
			cardName = newName;
		}
		public function getCost():Array{
			return cost;
		}
		public function setPosition(xposition:Number, yposition:Number):void{
			x = xposition;
			y = yposition;
		}
		public function setSmallPosition(xposition:Number, yposition:Number):void{
			smallImage.x = xposition;
			smallImage.y = yposition;
		}
		public function setSmallRotation(rot:Number):void{
			smallImage.rotation = rot;
		}
		public function getNewBigImage():Bitmap{
			var bigImage:String = cardName;
			var ClassReference:Class = getDefinitionByName(bigImage) as Class;
			var classInstance:BitmapData;
  			classInstance = new ClassReference (0,0) as BitmapData;
			var bitmap:Bitmap=new Bitmap(classInstance);
			return bitmap;
		}
		
		public override function toString():String{
			return cardName;
		}
	}
}