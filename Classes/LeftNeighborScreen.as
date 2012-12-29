package {
	import flash.display.MovieClip;

	public class LeftNeighborScreen extends MovieClip {
		private var board:Board;
		private var cards:Array;
		private var playedCards:Array;
		private var coins:Number;
		private var info:Array;
		private var coinScreen:CoinImage;
		private var militaryArray:Array;
		
		public function LeftNeighborScreen() {
			info = new Array();
			coinScreen = new CoinImage();
		}


		public function setBoard(b:Board):void {
			board = b;
			b.rotation = -90;
			b.x = -60;
			b.y = 750;
			addChild(b);
		}

		
		public function setCoins(c:Number):void {
			coins = c;
			coinScreen.updateCoins(c);
			addChild(coinScreen);
			coinScreen.x = board.x + 100;
			coinScreen.y = board.y;
		}
		
		public function setMilitary(s:Array):void {
			militaryArray = s;
			for(var i:Number = 0; i < militaryArray.length; i++){
				var military = new MilitaryToken(militaryArray[i]);
				trace("added military");
				addChild(military);
				military.x = board.x+board.width;
				military.y = board.y + i * military.getImage().height;
			}

		}


		public function setBuilt(cards:Array):void {
			playedCards = cards;
			var resourceCards:Number = 0;
			var resourceYMove:Number = 23;
			var resourceXMove:Number = Card.SMALLIMAGESIZE;
			var resourceX:Number = board.x;
			var resourceY:Number = board.y - resourceYMove;
			var yellowX:Number = board.x;
			var yellowY:Number = board.y - 330;
			var redX:Number = yellowX + 137;
			var redY:Number = yellowY;
			var blueX:Number = redX + 137;
			var blueY:Number = yellowY;
			var greenX:Number = blueX + 137;
			var greenY:Number = yellowY;
			var purpleX:Number = greenX + 137;
			var purpleY:Number = yellowY;
			var cardXMove:Number = 15;
			var cardYMove:Number = 28;
			for (var i:Number = 0; i < cards.length; i++) {
				var c:Card = cards[i];
				if (c.getColor()=="brown" || c.getColor()=="grey" || (c.getColor() == "yellow" && YellowCard(c).getCardType() == 3 )) {
					c.setSmallRotation(90);
					c.setSmallPosition(resourceX, resourceY);
					resourceCards++;
					if (resourceCards % 3 == 0) {
						resourceX = board.x;
						resourceY -=  resourceYMove;
					} else {
						resourceX +=  resourceXMove;
					}
					addChild(c.getSmallImage());
				} else if (c.getColor()=="yellow") {
					c.setSmallPosition(yellowX, yellowY);
					yellowX +=  cardXMove;
					yellowY +=  cardYMove;
					addChild(c.getSmallImage());
				} else if (c.getColor()=="red") {
					c.setSmallPosition(redX, redY);
					redX +=  cardXMove;
					redY +=  cardYMove;
					addChild(c.getSmallImage());
				} else if (c.getColor()=="blue") {
					c.setSmallPosition(blueX, blueY);
					blueX +=  cardXMove;
					blueY +=  cardYMove;
					addChild(c.getSmallImage());
				} else if (c.getColor()=="green") {
					c.setSmallPosition(greenX, greenY);
					greenX +=  cardXMove;
					greenY +=  cardYMove;
					addChild(c.getSmallImage());
				} else if (c.getColor()=="purple") {
					c.setSmallPosition(purpleX, purpleY);
					purpleX +=  cardXMove;
					purpleY +=  cardYMove;
					addChild(c.getSmallImage());
				}
			}



		}
		public function getResources():Array {
			var temp:Array = new Array();
			temp.push(board.getResource());
			for (var i:int = 0; i < playedCards.length; i++) {
				if (playedCards[i].getColor() == "brown" || playedCards[i].getColor() == "grey") {
					for (var j:int = 0; j < playedCards[i].getResources().length; j++) {
						temp.push(playedCards[i].getResources()[j]);
					}
				} else if (playedCards[i].getColor() == "yellow" &&playedCards[i].getCardType() == 3 ) {
					temp.push(playedCards[i].getBenefit());
				}

			}
			return temp;
		}

	}

}