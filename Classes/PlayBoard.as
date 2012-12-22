package 
{
	import flash.display.MovieClip;
	import flash.utils.*;
	public class PlayBoard extends MovieClip 
	{
		private var boardName:String;
		private var resources:Array;
		private var leftResources:Array;
		private var rightResources:Array;
		private var coins:Number;
		private var militaryTokens:Array;
		
 		public function PlayBoard(b:Board) 
		{
			x = 1;
			y = 1;	
			leftResources = new Array();
			rightResources = new Array();
			resources = new Array();
			militaryTokens = new Array();
			resources.push(b.getResource());
		}
		
		public function addCard(c:Card):void{
			var card:Card = c;
			if(card.getColor() == "brown"){
				var bCard:BrownCard =  card as BrownCard;
				resources.splice(0,0,bCard.getResources());
			}
			if(card.getColor() == "grey"){
				var gCard:GreyCard =  card as GreyCard;
				resources.splice(0,0,gCard.getResources());
			}
			if(card.getColor() == "yellow"){
				var yCard:YellowCard =  card as YellowCard;
				if(yCard.getCardType() == 3)
				resources.splice(0,0,yCard.getBenefit());
			}
		}
		
		public function update():void{
			myResources.text = resources.toString();
			leftResourcesText.text = leftResources.toString();
			rightResourcesText.text = rightResources.toString();
			discardedCardsText.text = Game.discardPile.toString();
			coinCount.text = String(coins);
			militaryTokenText.text = String(militaryTokens);
		}
		
		public function setLeftResources(res:Array):void{
			leftResources = res;
		}
		public function setRightResources(res:Array):void{
			rightResources = res;
		}
		public function setCoins(amt:Number):void{
			coins=amt;
		}
		public function setMilitary(military:Array):void{
			militaryTokens=military;
		}

	}
}