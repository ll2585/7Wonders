package 
{
		import flash.display.MovieClip;
		import flash.events.MouseEvent;

	public class Player  extends MovieClip
	{
		private var board:Board;
		private var cards:Array;
		private var playedCards:Array;
		private var clickedCard:Card;

		private var toSend:Array;
		private var coins:Number;
		private var playBoard:PlayBoard;
		private var leftNeighbor:Player;
		private var leftNeighborPayment:Array;
		private var rowcards:Array;
		private var rightNeighborPayment:Array;
		private var wonderStagesBuilt:Array;
		private var rightNeighbor:Player;
		private var cardY:Number = 415;
		private var firstCardX:Number = 400;
		private var resourceYMove:Number = 23;
		private var resourceXMove:Number = Card.SMALLIMAGESIZE;
		private var distanceBetweenCards:Number = -15;
		private var lengthofCard:Number = 102;
		private var discardedLastTurn:Boolean = false;
		private var shiftOverDistance:Number = -(distanceBetweenCards/2+lengthofCard/2);
		private var militaryTokens:Array;
		private var scienceArray:Array;
		private var resourceX:Number;
		private var resourceY:Number;
		private var yellowX:Number;
		private var yellowY:Number;
		private var redX:Number;
		private var redY:Number;
		private var blueX:Number;
		private var blueY:Number;
		private var greenX:Number;
		private var greenY:Number;
		private var purpleX:Number;
		private var purpleY:Number;
		private var cardXMove:Number;
		private var cardYMove:Number;
		private var resourceCards:Number;
		
 		public function Player(b:Board) 
		{
			coins = 6;
 			board = b;
			cards = new Array();
			militaryTokens = new Array();
			leftNeighborPayment = new Array(2,2);
			rightNeighborPayment = new Array(2,2);
			playedCards = new Array();
			rowcards = new Array();
			scienceArray = new Array(0,0,0,0);
			playBoard = new PlayBoard(board);
			//DELETE addChild(board);
			cardY = board.y + 65;
			firstCardX = board.x+285;
			resourceX = board.x;
			resourceY = board.y -resourceYMove;
			wonderStagesBuilt = new Array();
			cardXMove = 15;
			cardYMove = 28;
			yellowX = board.x;
			yellowY = board.y-330;
			redX = yellowX + 137;
			redY = yellowY;
			blueX = redX + 137;
			blueY = yellowY;
			greenX = blueX + 137;
			greenY = yellowY;
			purpleX = greenX + 137;
			purpleY = yellowY;
			resourceCards = 0;
			//DELETE addChildAt(playBoard,0);
			addEventListener(ClickEvent.cardClicked, cardClicked);
		}
		
		public function getWonderStagesBuilt():Array{
			return wonderStagesBuilt;
		}
		
		public function getCoins():Number{
			return coins;
		}
		
		
		public function getMilitaryTokens():Array{
			return militaryTokens;
		}
		
		public function addCard(c:Card){
			var midpoint = Math.round((cards.length-1)/2);
			if (cards.length==0) {
				c.setPosition(firstCardX,cardY);
			}	else {
				for(var i:Number=0; i<cards.length; i++){
					cards[i].setPosition(cards[i].x+shiftOverDistance, cardY);
				}
				c.setPosition(cards[i-1].x+lengthofCard+distanceBetweenCards,cardY);
			}
			cards.push(c);
			c.addEventListener(ClickEvent.cardClicked, cardClicked);
			c.makeClickable();
			//DELETE addChild(c);
		}
		
		public function getCards():Array{
			return cards;
		}
		
		private function canBuildCard(c:Card):Boolean{
			if(haveCard(c.getName())) return false;
			var res = getResources();
			var checkedRes:Array = new Array(res.length);
			var cardCost:Array = c.getCost();
			var leftRes:Array = leftNeighbor.getTradableResources();
			var leftCheck:Array = new Array(leftRes.length);
			var rightRes:Array = rightNeighbor.getTradableResources();
			var rightCheck:Array = new Array(rightRes.length);
			var built:Boolean = false;
			var coinsAfterPaying:Number = coins;
			var canBuild:Boolean = true;
			if(canChain(c)) return true;
			for(var i:int = 0; i<cardCost.length; i++){
				for(var j:int = 0; j<res.length; j++){
					if(res[j].indexOf(cardCost[i])>-1 && checkedRes[j]!=1){
						checkedRes[j] = 1;
						built = true;
						break;
					}
				}
				if(!built){
					for(var j:int = 0; j<leftRes.length; j++){
						if(leftRes[j].indexOf(cardCost[i])>-1 && leftCheck[j]!=1 && coinsAfterPaying >= leftNeighborFee(cardCost[i])){
							leftCheck[j] = 1;
							built = true;
							coinsAfterPaying = coinsAfterPaying - leftNeighborFee(c.getCost()[i]);
							break;
						}
					}
				}
				if(!built){
					for(var j:int = 0; j<rightRes.length; j++){
						if(rightRes[j].indexOf(cardCost[i])>-1 && rightCheck[j]!=1 && coinsAfterPaying >= rightNeighborFee(cardCost[i])){
							rightCheck[j] = 1;
	
							built = true;
							coinsAfterPaying = coinsAfterPaying - rightNeighborFee(c.getCost()[i]);
							break;
						}
					}
				}
				if(built == false || c.getCoinCost() > coins){

					canBuild = false;
				}
				built = false;
			}
			if(canBuild == false){
				canBuild = true;
				checkedRes = new Array(res.length);
				leftCheck = new Array(leftRes.length);
				rightCheck = new Array(rightRes.length);
				for(var i:int = 0; i<cardCost.length; i++){
					for(var j:int = 0; j<res.length; j++){
						if(res[j].indexOf(cardCost[i])>-1 && checkedRes[j]!=1){
							checkedRes[j] = 1;
							built = true;
							break;
						}
					}
				
					if(!built){
						for(var j:int = 0; j<rightRes.length; j++){
							if(rightRes[j].indexOf(cardCost[i])>-1 && rightCheck[j]!=1 ){
								rightCheck[j] = 1;
								built = true;
								coinsAfterPaying = coinsAfterPaying - rightNeighborFee(c.getCost()[i]);
								break;
							}
						}
					}
					if(!built){
						for(var j:int = 0; j<leftRes.length; j++){
							if(leftRes[j].indexOf(cardCost[i])>-1 && leftCheck[j]!=1){
								leftCheck[j] = 1;
								built = true;
								coinsAfterPaying = coinsAfterPaying - leftNeighborFee(c.getCost()[i]);
								break;
							}
						}
					}
					if(built == false && c.getCoinCost() < coins){
						canBuild = false;
					}
					built = false;
				}
			}
			return canBuild;
		}

		public function canChain(c:Card):Boolean{
			var preReq:Array = c.getChain();
			if(preReq == null) return false;
			for(var i:int = 0; i < preReq.length; i++){
				if(haveCard(c.getName())) return true;
			}
			return false;
			
		}
		
		public function haveCard(cardName:String):Boolean{
				for(var j:int = 0; j < playedCards.length; j++){
					if(playedCards[j].getName() == cardName){
						trace("YOU HAVE THIS CARD " + cardName);
						return true;
					}
			}
			return false;
			
		}

		private function canBuildWonderStage():Boolean{
			if(board.getNextStage()!=null){
				return canBuildCard(board.getNextStage());
			}
			else return false;
		}
		public function cardClicked(e:ClickEvent):void {
			clickedCard = e.getClickedCard();

			if(canBuildCard(clickedCard)){
				
				if(freeBuild(clickedCard)){
					dispatchEvent( new ClickEvent( ClickEvent.FREEBUILD, e.getClickedCard() ) );
				}
				else{
					dispatchEvent( new ClickEvent( ClickEvent.PAYBUILD, e.getClickedCard() ) );
					//cardInfo.enablePayBuild(getResources(), coins,leftNeighbor.getTradableResources(), leftNeighborPayment, rightNeighbor.getTradableResources(), rightNeighborPayment);
				}
				//cardInfo.addEventListener( GameEvent.BUILD, buildCard );
			}
			if(board.getNextStage()!=null){
				var wonderStage:Card = board.getNextStage();
				if(canBuildCard(wonderStage)){
					
					//cardInfo.setWonderStage(board.getNextStage());
				if(freeBuild(wonderStage)){
					trace("I CAN BUILD WONDER STAGE FOR FREE");
					//cardInfo.enableWonderBuild();
				}
				else{
					trace("I CANNOT BUILD WONDER STAGE FOR FREE");
					//cardInfo.enablePayWonderBuild(getResources(), coins,leftNeighbor.getTradableResources(), leftNeighborPayment, rightNeighbor.getTradableResources(), rightNeighborPayment);
				}
				//cardInfo.addEventListener( GameEvent.BUILDWONDER, buildWonder );
			}
			}
			
			
			//cardInfo.addEventListener( GameEvent.DISCARD, discardCard );
			//cardInfo.addEventListener( NavigationEvent.closeCardInfo, closeCardInfo );
			//cardInfo.addEventListener( GameEvent.OOPS, enableListeners );
			/*if (playedCards.length==0) {
				c.setPosition(firstCardX,cardY-150);
			}	else {
				for(var i:Number=0; i<playedCards.length; i++){
					playedCards[i].setPosition(playedCards[i].x+shiftOverDistance, cardY-150);
				}
				c.setPosition(playedCards[i-1].x+lengthofCard+distanceBetweenCards,cardY-150);
			}
			playedCards.push(c);
			playBoard.addCard(c);
			for(var i:Number=0; i<cards.length; i++){
				if(cards[i]==c) {
					cards.splice(i,1);
				}
			}
			c.removeEventListener(ClickEvent.cardClicked, cardClicked);
			addChild(c);
			dispatchEvent( new GameEvent( GameEvent.DONE  ) );
			*/
		}
		public function enableListeners(e:GameEvent):void{
			for(var i:int = 0; i < cards.length; i++){
				cards[i].addEventListener(ClickEvent.cardClicked, cardClicked);
			}
		}
		

		
		public function freeBuild(c:Card):Boolean{
			if(canChain(c)) return true;
			var res = getResources();
			var checkedRes:Array = new Array(res.length);
			var built:Boolean = false;
			for(var i:int = 0; i<c.getCost().length; i++){
				for(var j:int = 0; j<res.length; j++){
					if(res[j].indexOf(c.getCost()[i])>-1 && checkedRes[j]!=1){
						checkedRes[j] = 1;
						built = true;
						break;
					}
				}
				if(built == false && c.getCoinCost() < coins){
					return false;
				}
				built = false;
			}
			return true;
		}
		
		public function buildCard(c:Card):void{
			coins = coins - c.getCoinCost();
			playedCards.push(c);
			for(var i:Number=0; i<cards.length; i++){
				if(cards[i]==c) {
					cards.splice(i,1);
				}
			}
			if(c.getColor() == "yellow") {
				getBenefit(c as YellowCard);
			}
			//addChild(c);
			//dispatchEvent( new GameEvent( GameEvent.DONE  ) );
		}
		
		public function buildWonder(e:GameEvent):void{
			coins = coins - board.getNextStage().getCoinCost();
			var c:Card = board.getNextStage();
			var clicked:Card = clickedCard;
			c.setPosition(board.getStageX(),board.getStageY());
			for(var i:Number=0; i<cards.length; i++){
				if(cards[i]==clicked) {
					cards.splice(i,1);
				}
			}
			//c.removeEventListener(ClickEvent.cardClicked, cardClicked);
			//DELETE addChildAt(c, getChildIndex(board));
			wonderStagesBuilt.push(c);
			board.updateStage();
			//DELETE removeChild(clicked);
			dispatchEvent( new GameEvent( GameEvent.DONE  ) );
		}
		
		public function getPlayedCards():Array{
			return playedCards;
		}
		
		public function discardCard(e:GameEvent):void{
			coins += 3;
			var clicked:Card = clickedCard;
			for(var i:Number=0; i<cards.length; i++){
				if(cards[i]==clicked) {
					cards.splice(i,1);
				}
			}
			//DELETE removeChild(clicked);
			discardedLastTurn = true;
			dispatchEvent( new GameEvent( GameEvent.DONE  ) );
		}
		private function getBenefit(c:YellowCard):void{
			if(c.getCardType()==0){
				if(c.getBenefit()=="left"){
					leftNeighborPayment[0] = 1;
				}else if(c.getBenefit()=="right"){
					rightNeighborPayment[0] = 1;
				}else{
					leftNeighborPayment[1] = 1;
					rightNeighborPayment[1] = 1;
				}
			} else if(c.getCardType()==1){
				coins += Number(c.getBenefit());
			} else if(c.getCardType()==2){
				var coin_per:Number = Number(c.getBenefit().split("_")[0]);
				var card_color:String = c.getBenefit().split("_")[1];
				var which_players:Number = Number(c.getBenefit().split("_")[2]);
				var total_count:int = 0;
				if(which_players == 2){
					for(var i:int=0; i<playedCards.length; i++){
						if(playedCards[i].getColor()==card_color)
							total_count++;
					}
				}
				
				for(var i:int=0; i<leftNeighbor.getPlayedCards().length; i++){
						if(leftNeighbor.getPlayedCards()[i].getColor()==card_color)
							total_count++;
				}
				for(var i:int=0; i<rightNeighbor.getPlayedCards().length; i++){
						if(rightNeighbor.getPlayedCards()[i].getColor()==card_color)
							total_count++;
				}
				coins += (total_count * coin_per);
			}
		}
		public function readyHand():void{
			toSend = cards;
			for(var i:Number=0; i<cards.length; i++){
				cards[i].removeEventListener(ClickEvent.cardClicked, cardClicked);
				//DELETE removeChild(cards[i]);
			}
		}
		public function lastCard():Card{
			var lastCard:Card = cards[0];
			cards = new Array();
			return lastCard;
		}
		
		
		public function leftNeighborFee(r:String):Number{
			return 2;
		}
		
		public function getSelectedCard():Card{
			return clickedCard;
		}
		public function rightNeighborFee(r:String):Number{
			return 2;
		}
		//0 is from left, 1 is from right
		public function getFrom(j:Number):void{
			var toGet:Array;
			switch (j) {
				case 0 :
					toGet = leftNeighbor.getToSend();
					break;
				default :
					toGet = rightNeighbor.getToSend();
					break;
			}
			cards = new Array();
			for(var i:Number=0; i<toGet.length; i++){
				addCard(toGet[i]);
			}
		}
		
		public function getToSend():Array{
			return toSend;
		}
		
		public function setNeighbors(left:Player, right:Player):void{
			leftNeighbor = left;
			rightNeighbor = right;
		}
		
		public function getLeftNeighbor():Player{
			return leftNeighbor;
		}
		
		public function getRightNeighbor():Player{
			return rightNeighbor;
		}
		
		public function getVictory(age:int, fromPlayer:Player):void{
			militaryTokens.push(Game.militaryTokens[age]);
		}
		public function getLoss(age:int, fromPlayer:Player):void{
			militaryTokens.push(Game.militaryTokens[0]);
		}
		
		public function getBoardName():String{
			return board.getName();
		}
		public function getBoard():Board{
			return board;
		}
		public function getResources():Array{
			var temp:Array = new Array();
			temp.push(board.getResource());
			for(var i:int = 0; i < playedCards.length; i++){
				if(playedCards[i].getColor() == "brown" || playedCards[i].getColor() == "grey"){
					for(var j:int = 0; j < playedCards[i].getResources().length; j++){
						temp.push(playedCards[i].getResources()[j]);
					}
				} else if (playedCards[i].getColor() == "yellow" &&playedCards[i].getCardType() == 3 ){
					trace("the benefit is " + playedCards[i].getBenefit());
					temp.push(playedCards[i].getBenefit());
					trace("we have a caravbanasry or something");
				}
				
			}
			trace("my resources: " + temp);
			return temp;
		}
		public function getMilitary():int{
			var temp:Array = getRedCards();
			var military:int = 0;
			for(var i:int = 0; i < temp.length; i++){
				military += temp[i].getPower();
			}
			return military;
		}
		public function getRedCards():Array{
			var temp:Array = new Array();
			for(var i:int = 0; i < playedCards.length; i++){
				if(playedCards[i].getColor() == "red"){
					var redCard:Card = playedCards[i] as RedCard;
					temp.push(redCard);
				}
				
			}
			return temp;
		}
		public function getTradableResources():Array{
			var temp:Array = new Array();
			temp.push(board.getResource());
			for(var i:int = 0; i < playedCards.length; i++){
				if(playedCards[i].getColor() == "brown" || playedCards[i].getColor() == "grey"){
					for(var j:int = 0; j < playedCards[i].getResources().length; j++){
						temp.push(playedCards[i].getResources()[j]);
					}
				}
			}
			return temp;
		}
		
		public function updateBoard():void{
			discardedLastTurn = false;
			playBoard.setLeftResources(leftNeighbor.getTradableResources());
			playBoard.setRightResources(rightNeighbor.getTradableResources());
			playBoard.setCoins(coins);
			playBoard.setMilitary(militaryTokens);
			playBoard.update();
		}
		
		public function playCard():void{
			var c:Card = playFirstCard();
			playedCards.push(c);
			playBoard.addCard(c);
			for(var i:Number=0; i<cards.length; i++){
				if(cards[i]==c) {
					cards.splice(i,1);
				}
			}
		}
		
		public function setBuiltCard(c:Card):void{
			playedCards.push(c);
			playBoard.addCard(c);
		}
		
		public function discarded():Boolean{
			return discardedLastTurn;
		}
		public function playFirstCard():Card{
			return cards[0];
		}
		
		public function getCompletedStages():int{
			return board.getCurrentStage();
		}
		
		public function getDefeatNumber():int{
			var temp:int = 0;
			for(var i:int = 0; i < militaryTokens.length; i++){
				if(militaryTokens[i]==-1) temp++;
			}
			return temp;
		}
		
		
		
		
		
		
		/** POINTS **/
		public function traceScore():void{
			/*trace(getBoardName() + " my military score: " + getMilitaryPoints());
			trace(getBoardName() + " my money score: " + getMoneyPoints());
			trace(getBoardName() + " my wonder score: " + getWonderPoints());
			trace(getBoardName() + " my blue score: " + getBluePoints());
			*/
		}
		public function getMilitaryPoints():int{
			var temp:int = 0;
			for(var i:int = 0; i < militaryTokens.length; i++){
				temp += militaryTokens[i];
			}
			return temp;
		}
		public function getBluePoints():int{
			var temp:int = 0;
			for(var i:int = 0; i < playedCards.length; i++){
				if(playedCards[i].getColor() == "blue"){
					temp += playedCards[i].getPoints();
				}
				
			}
			return temp;
		}
		public function getYellowPoints():int{
			var temp:int = 0;
			for(var i:int = 0; i < playedCards.length; i++){
				if(playedCards[i].getColor() == "yellow"){
					var yellowCard:YellowCard = playedCards[i] as YellowCard;
					if(yellowCard.getCardType() == 4){
						var points_per:Number = Number(yellowCard.getBenefit().split("_")[2]);
						var card_color:String = yellowCard.getBenefit().split("_")[1];
						var total_count:int = 0;
						if(card_color != "none"){
							for(var i:int=0; i<playedCards.length; i++){
								if(playedCards[i].getColor()==card_color)
									total_count++;
							}
						} else{
							total_count = getCompletedStages();
							total_count += leftNeighbor.getCompletedStages();
							total_count += rightNeighbor.getCompletedStages();
						}
						temp += (total_count * points_per);
					}
				}
				
			}
			return temp;
		}
		public function getPurplePoints():int{
			var temp:int = 0;
			for(var i:int = 0; i < playedCards.length; i++){
				if(playedCards[i].getColor() == "purple"){
					var purpleCard:PurpleCard = playedCards[i] as PurpleCard;
					if(purpleCard.getCardType() == 0){
						var points_per:Number = Number(purpleCard.getBenefit().split("_")[0]);
						var card_color:String = purpleCard.getBenefit().split("_")[1];
						var total_count:int = 0;
						if(card_color != "none"){
							for(var j:int=0; j<leftNeighbor.getPlayedCards().length; j++){
								if(leftNeighbor.getPlayedCards()[j].getColor()==card_color)
									total_count++;
							}
							for(var j:int=0; j<rightNeighbor.getPlayedCards().length; j++){
								if(rightNeighbor.getPlayedCards()[j].getColor()==card_color)
									total_count++;
							}
						} else{
							total_count = getCompletedStages();
							total_count += leftNeighbor.getCompletedStages();
							total_count += rightNeighbor.getCompletedStages();
						}
						temp += (total_count * points_per);
					} else if (purpleCard.getCardType() == 1){
						var points_per:Number = Number(purpleCard.getBenefit().split("_")[2]);
						var tokenType:String = purpleCard.getBenefit().split("_")[1];
						if(tokenType == "defeat"){
							total_count += leftNeighbor.getDefeatNumber();
							total_count += rightNeighbor.getDefeatNumber();
						}
						temp += total_count;
					} else if (purpleCard.getCardType() == 2){
						var total_colors:int = purpleCard.getBenefit().split("_").length = 2;
						var points_per:Number = Number(purpleCard.getBenefit().split("_")[0]);
						for(var j:int = 0; j < total_colors; j++){
							var card_color:String = purpleCard.getBenefit().split("_")[j+2];
							var total_count:int = 0;
							if(card_color != "none"){
								for(var k:int=0; k<playedCards.length; k++){
									if(playedCards[k].getColor()==card_color)
										total_count++;
								}
							}
							temp += (total_count * points_per);
						}
					}
				}
				
			}
			return temp;
		}
		public function getGreenPoints():int{
			var temp:int = 0;
			var max:int = 0;
			var mid:int = 0;
			var min:int = 0;
			scienceArray = [0,0,0,0];
			for(var i:int = 0; i < playedCards.length; i++){
				if(playedCards[i].getColor() == "green"){
					var greenCard:GreenCard = playedCards[i] as GreenCard;
					scienceArray[greenCard.getSymbolType()-1]++;
				} else if (playedCards[i].getColor() == "purple"){
					var purpleCard:PurpleCard = playedCards[i] as PurpleCard;
					if(purpleCard.getCardType()==3){
						scienceArray[3]++;
					}
				}
				
			}
			if(scienceArray[3] > 0){
				while(scienceArray[3] > 0){
					var make1:int = ((scienceArray[0]+1) * (scienceArray[0]+1)) + (scienceArray[1] * scienceArray[1])  + (scienceArray[2] * scienceArray[2] ) + 7 * Math.min((scienceArray[0]+1), scienceArray[1], scienceArray[2]);
					var make2:int = (scienceArray[0] * (scienceArray[0]+1)) + ((scienceArray[1]+1) * (scienceArray[1]+1))  + (scienceArray[2] * scienceArray[2] ) + 7 * Math.min(scienceArray[0], (scienceArray[1]+1), scienceArray[2]);
					var make3:int = (scienceArray[0] * scienceArray[0]) + (scienceArray[1] * scienceArray[1])  + ((scienceArray[2]+1) * (scienceArray[2]+1) ) + 7 * Math.min(scienceArray[0], scienceArray[1], (scienceArray[2]+1));
					if(Math.max(make1, make2, make3)==make1){
						scienceArray[0]++;
					}else if (Math.max(make1, make2, make3)==make2){
						scienceArray[1]++;
					}else if (Math.max(make1, make2, make3)==make2){
						scienceArray[2]++;
					}
					scienceArray[3]--;
				}
			}
			temp = (scienceArray[0] * scienceArray[0]) + (scienceArray[1] * scienceArray[1])  + (scienceArray[2] * scienceArray[2] ) + 7 * Math.min(scienceArray[0], scienceArray[1], scienceArray[2]);				
			return temp;
		}
		public function getMoneyPoints():Number{
			return Math.floor(coins/3);
		}
		public function getWonderPoints():int{
			var temp:int = 0;
			var wonderStages:Array = board.getWonderStages();
			var stagesBuilt:int = board.getCurrentStage();
			for(var i:int = 0; i < wonderStages.length; i++){
				if(wonderStages[i] != null && i<stagesBuilt){
					var builtStage:WonderStage = wonderStages[i];
					for(var j:int = 0; j < builtStage.getCardType().length; j++){
						if(builtStage.getCardType()[j]==0){
							temp += builtStage.getBenefit()[j];
						}
					}
				}
			}
			return temp;
		}
		public function getTotalPoints():int{
			var temp:int = getMilitaryPoints()+getBluePoints()+getYellowPoints()+getPurplePoints()+getGreenPoints()+getMoneyPoints()+getWonderPoints();
			return temp;
		}
	}
}