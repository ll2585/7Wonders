package {
	import flash.display.MovieClip;

	public class PlayerScreen extends MovieClip {
		private var board:Board;
		private var cardInfo:CardInfoScreen;
		private var cards:Array;
		private var playedCards:Array;
		private var coins:Number;
		private var info:Array;
		private var coinScreen:CoinImage;
		private var militaryArray:Array;
		
		public function PlayerScreen() {
			info = new Array();
			coinScreen = new CoinImage();
		}


		public function setBoard(b:Board):void {
			board = b;
			b.y = 350;
			addChild(b);
		}

		public function setHand(c:Array):void {
			var firstX:Number = (board.width/2)-(c[0].width/2);
			var distance:Number = -(10 + 7*c[0].width-board.width)/6;
			var startX:Number;
			if (c.length % 2 == 0) {
				startX = board.x + board.width/2-c.length/2*(c[0].width+distance)+(distance/2);
			} else {
				startX = board.x + board.width/2-Math.floor(c.length/2)*(c[0].width+distance)-(c[0].width/2);
			}
			//var startX:Number = board.x + board.width/2-Math.floor(c.length/2)*(c[0].width-distance)-c.length%2*(distance/2)-(c.length+1)%2*(c[0].width/2);
			for (var i:Number = 0; i < c.length; i++) {
				c[i].x = startX + i*distance + i*( c[i].width);
				c[i].y = 410;
				addChild(c[i]);
				c[i].addEventListener(ClickEvent.cardClicked, cardClicked);
				c[i].makeClickable();
			}
			cards = c;
		}
		
		public function setCoins(c:Number):void {
			coins = c;
			coinScreen.updateCoins(c);
			addChild(coinScreen);
			coinScreen.x = board.x + 150;
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

		public function cardClicked(e:ClickEvent):void {
			for (var i:int = 0; i < cards.length; i++) {
				cards[i].removeEventListener(ClickEvent.cardClicked, cardClicked);
			}
			dispatchEvent( new ClickEvent( ClickEvent.ELEVATE, e.getClickedCard()  ) );
		}

		public function closeCardInfo(e:NavigationEvent):void {
			removeChild(cardInfo);
			cardInfo = null;
		}

		public function receiveEvent(e:ClickEvent):void {
			cardInfo = new CardInfoScreen(e.getClickedCard());
			cardInfo.x = 400;
			cardInfo.y = 200;

			cardInfo.addEventListener( ClickEvent.DISCARD, discardCard );
			cardInfo.addEventListener( NavigationEvent.closeCardInfo, closeCardInfo );
			cardInfo.addEventListener( GameEvent.OOPS, enableListeners );
			if (e.getType() == "FREEBUILD") {
				cardInfo.enableBuild();

			} else if (e.getType() == "PAYBUILD") {
				cardInfo.enablePayBuild(info[0], info[1],info[2], info[3], info[4], info[5]);
			} else if (e.getType() == "CANNOTBUILD"){
				
			}
			cardInfo.addEventListener( ClickEvent.BUILT, buildCard );
			addChild(cardInfo);
		}
		
		public function enableListeners(e:GameEvent):void{
			for(var i:int = 0; i < cards.length; i++){
				cards[i].addEventListener(ClickEvent.cardClicked, cardClicked);
			}
		}
		
		public function discardCard(e:ClickEvent):void{
			dispatchEvent( new ClickEvent( ClickEvent.DISCARD, e.getClickedCard()  ) );
		}
		public function receiveInfoEvent(e:InformationEvent):void {
			info = e.getInfo();
		}
		

		public function buildCard(e:ClickEvent):void {
			dispatchEvent( new ClickEvent( ClickEvent.BUILT, e.getClickedCard()  ) );
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
					c.setSmallPosition(resourceX, resourceY);
					resourceCards++;
					if (resourceCards % 3 == 0) {
						resourceX = board.x;
						resourceY -=  resourceYMove;
					} else {
						resourceX +=  resourceXMove;
					}
					addChildAt(c.getSmallImage(),0);
					
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
				}/*else{
				if (rowcards.length==0) {
				trace("the x is " + firstCardX);
				c.setPosition(firstCardX,cardY-150);
				}else {
				for(var i:Number=0; i<rowcards.length; i++){
				trace("the x is now " + (rowcards[i].x+shiftOverDistance));
				rowcards[i].setPosition(rowcards[i].x+shiftOverDistance, cardY-150);
				}
				c.setPosition(rowcards[i-1].x+lengthofCard+distanceBetweenCards,cardY-150);
				addCard(c);
				}
				
				rowcards.push(c);
				}*/
				//DELETE removeChild(c);
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