﻿package {
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
			b.x = -61;
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
				addChild(military);
				military.x = i * (military.getImage().width);
				military.y = board.y -board.height-military.getImage().height;
			}

		}


		public function setBuilt(cards:Array):void {
			playedCards = cards;
			var cardXMove:Number = 30;
			var brownX:Number = board.x+90;
			var brownY:Number = board.y -86;
			var greyX:Number = brownX;
			var greyY:Number = brownY -86;
			var yellowX:Number = brownX;
			var yellowY:Number = greyY - 86;
			var redX:Number = brownX;
			var redY:Number = yellowY - 86;
			var blueX:Number = brownX;
			var blueY:Number = redY - 86;
			var greenX:Number = brownX;
			var greenY:Number = blueY - 86;
			var purpleX:Number = brownX;
			var purpleY:Number = greenY - 86;
			for (var i:Number = 0; i < cards.length; i++) {
				var c:Card = cards[i];
				c.setSmallRotation(90);
				if (c.getColor()=="brown") {
					c.setSmallPosition(brownX, brownY);
					brownX +=  cardXMove;
				}else if (c.getColor()=="grey") {
					c.setSmallPosition(greyX, greyY);
					greyX +=  cardXMove;
				} else if (c.getColor()=="yellow") {
					c.setSmallPosition(yellowX, yellowY);
					yellowX +=  cardXMove;
				} else if (c.getColor()=="red") {
					c.setSmallPosition(redX, redY);
					redX +=  cardXMove;
				} else if (c.getColor()=="blue") {
					c.setSmallPosition(blueX, blueY);
					blueX +=  cardXMove;
				} else if (c.getColor()=="green") {
					c.setSmallPosition(greenX, greenY);
					greenX +=  cardXMove;
				} else if (c.getColor()=="purple") {
					c.setSmallPosition(purpleX, purpleY);
					purpleX +=  cardXMove;
				}
				addChildAt(c.getSmallImage(),1);
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