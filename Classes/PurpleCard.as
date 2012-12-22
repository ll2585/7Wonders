package 
{
	import flash.display.MovieClip;
		import flash.display.Bitmap;
		import flash.events.MouseEvent;
	public class PurpleCard extends Card 
	{
		private var cardName:String;
		private var color:String;
		private var cardType:int;
		private var benefit:String;

		/*
		card types:
		0: points for left right
		1: points for defeat
		2: points for multiple colors
		3: science
		
		*/
 		public function PurpleCard(givenName:String, coinCost:Number, cost:Array,  cardType:int, benefit:String=null) 
		{
			super(givenName, coinCost, cost);
			setColor("purple");
			cardName = givenName;
			makeClickable();
			this.benefit = benefit;
			this.cardType = cardType;
		}
		
		public function getCardType():int{
			return cardType;
		}
		
		public function getBenefit():String{
			return benefit;
		}

	}
}