package 
{
	import flash.display.MovieClip;
		import flash.display.Bitmap;
		import flash.events.MouseEvent;
	public class RedCard extends Card 
	{
		private var cardName:String;
		private var color:String;
		private var benefit:String;
		private var swords:int;

		
 		public function RedCard(givenName:String, coinCost:Number, cost:Array,  swords:int, preReq:Array = null) 
		{
			super(givenName, coinCost, cost, preReq);
			setColor("red");
			cardName = givenName;
			makeClickable();
			this.swords = swords;
		}
		
		public function getPower():int{
			return swords;
		}

	}
}