package 
{
	import flash.display.MovieClip;
		import flash.events.MouseEvent;
	public class WonderStage extends Card 
	{
		private var cost:Array;
		private var cardType:Array;
		private var benefit:Array;
		private var coinCost:Number;

		/*
		card types:
		0: points
		
		*/
 		public function WonderStage(id:Number, givenName:String, coinCost:Number, cost:Array,  cardType:Array, benefit:Array)
		{
			super(id, "wondercard", coinCost, cost);
			setColor("none");
			setName(givenName);
			this.benefit = benefit;
			this.cardType = cardType;
			this.coinCost = coinCost;


		}
		
		public function getCardType():Array{
			return cardType;
		}
		
		public function getBenefit():Array{
			return benefit;
		}

	}
}