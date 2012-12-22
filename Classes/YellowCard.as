package 
{
	import flash.display.MovieClip;
		import flash.display.Bitmap;
		import flash.events.MouseEvent;
	public class YellowCard extends Card 
	{
		private var cardName:String;
		private var color:String;
		private var cardType:int;
		private var benefit:String;

		/*
		card types:
		0: marketplace
			left: left
			right: right
			grey: grey
		1: tavern
			benefit = amt of money
		
		*/
 		public function YellowCard(givenName:String, coinCost:Number, cost:Array,  cardType:int, benefit:String , preReq:Array = null) 
		{
			super(givenName, coinCost, cost, preReq);
			setColor("yellow");
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