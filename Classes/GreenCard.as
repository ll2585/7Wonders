package 
{
	import flash.display.MovieClip;
		import flash.display.Bitmap;
		import flash.events.MouseEvent;
	public class GreenCard extends Card 
	{
		private var cardName:String;
		private var color:String;
		private var benefit:String;
		private var symbolType:int;

		
 		public function GreenCard(id:Number, givenName:String, coinCost:Number, cost:Array,  symbolType:int , preReq:Array = null) 
		{
			super(id, givenName, coinCost, cost, preReq);
			setColor("green");
			cardName = givenName;
			makeClickable();
			this.symbolType = symbolType;
		}
		
		public function getSymbolType():int{
			return symbolType;
		}

	}
}