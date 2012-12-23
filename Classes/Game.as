package
{
	import flash.display.MovieClip;

	public class Game extends MovieClip
	{
		private var boards:Array;
		private var cards:Array;
		private var players:Array;
		private var deck:Deck;
		public static var discardPile:Array;
		public static const brownResources:Array = new Array("Earth", "Fire", "Wind", "Water");
		public static const greyResources:Array = new Array("Heart", "Light", "Dark");
		private var gameState:Array;
		public static const militaryTokens:Array = new Array(-1, 1, 3, 5);
		private const startcardcount:int = 7;
		private var age:int;
		private var round:int;
				
		private var human:Player;
		private var gameScreen:GameScreen;
		
		
		public function Game() 
		{
			cards = new Array();
			deck = new Deck();
			players = new Array();
			discardPile = new Array();
			boards = new Array();
			gameState = new Array();
			age = 0
			makeboards();
			boards = DocumentClass.shuffle(boards);
			makePlayers();
			//var a14:Card= new GreenCard("apothocarycard", 0,[greyResources[0]], 1);
			//var a5:Card= new BrownCard("heartcard",0 ,[], [greyResources[0]]);
			//leftPlayer.setBuiltCard(a5);
			//human.addCard(a14);
			//leftPlayer.setBuiltCard(a8);
			//rightPlayer.setBuiltCard(a9);
			//rightPlayer.setBuiltCard(a11);
			//human.setBuiltCard(a8);
			//leftPlayer.setBuiltCard(a8);
			//leftPlayer.setBuiltCard(a9);
			for(var i:int = 0; i < players.length; i++){
				players[i].updateBoard();
			}
			newRound();
		}
		
		private function makePlayers():void{
			var leftPlayer:Player;
			var rightPlayer:Player
			for(var i:int = 0; i < boards.length; i++){
				if(i==0){
					human = new Player(boards[i]);
				} else if (i==1){
					leftPlayer = new Player(boards[i]);
				} else{
					rightPlayer = new Player(boards[i]);
				}
			}

			players.push(leftPlayer);
			players.push(human);
			human.addEventListener(GameEvent.DONE, roundEnd);
			players.push(rightPlayer);
			for(var i:int = 0; i < players.length; i++){
				players[i].setNeighbors(players[(i-1+players.length) % players.length], players[(i+1) % players.length]);
			}
			addChild(human);
		}
		
		private function dealCards():void{
			for(var i:int = 0; i < cards.length; i++){
				players[i%(players.length)].addCard(cards[i]);
			}
			gameState.unshift(new State(age, round, discardPile, getPlayerStates()));
			trace("the current state is " + gameState[0]);
			gameScreen = new GameScreen(gameState[0]);
			gameScreen.addEventListener(ClickEvent.ELEVATE, elevated);
			addChild(gameScreen);
		}
		
		private function roundEnd(e:GameEvent):void{
			round++;
			playCards();
			if(round==startcardcount-1){
				endOfRound();
			}else{
				passCards();
			}
			for(var i:int = 0; i < players.length; i++){
				players[i].updateBoard();
				players[i].traceScore();
			}
			gameState.unshift(new State(age, round, discardPile, getPlayerStates()));
			trace("the current state is " + gameState[0]);
		}
		
		private function endOfRound():void{
			for(var i:int = 0; i < players.length; i++){
				discardPile.push(players[i].lastCard());
				if(players[i].getMilitary() > players[i].getLeftNeighbor().getMilitary()){
					players[i].getVictory(age, players[i].getLeftNeighbor());
					trace(players[i].getBoardName() + " defeats " + players[i].getLeftNeighbor().getBoardName());
				}else if(players[i].getMilitary() < players[i].getLeftNeighbor().getMilitary()){
					players[i].getLoss(age, players[i].getLeftNeighbor());
				}
				if(players[i].getMilitary() > players[i].getRightNeighbor().getMilitary()){
					players[i].getVictory(age, players[i].getRightNeighbor());
					trace(players[i].getBoardName() + " defeats "  + players[i].getRightNeighbor().getBoardName());
				}else if(players[i].getMilitary() < players[i].getRightNeighbor().getMilitary()){
					players[i].getLoss(age, players[i].getRightNeighbor());
				}
			}
			if(age!=3){
			newRound();
			}else{
				trace("GAME OVER");
				var endScreen:ScoringWindow = new ScoringWindow(players);
				addChild(endScreen);
			}
		}
		
		private function newRound():void{
			round = 0;
			age++;
			makecards(age);
			cards = DocumentClass.shuffle(cards);
			dealCards();
		}
		
		private function playCards():void{
			for(var i:int = 0; i < players.length; i++){
				if(players[i].discarded()){
					discardPile.push(players[i].getSelectedCard());
				}
			}
			for(var i:int = 0; i < players.length; i++){
				if(players[i]!=human){
					players[i].playCard();
				}
			}
			for(var i:int = 0; i < players.length; i++){
				players[i].readyHand();
			}
		}
		
		private function passCards():void{
			for(var i:int = 0; i < players.length; i++){
				players[i].getFrom(0);
			}
		}
		
		private function makecards(age):void{
			cards = new Array();
			for(var i:int = 0; i<deck.getAgeDeck(age, players.length).length; i++){
				cards.push(deck.getAgeDeck(age, players.length)[i]);
			}

		}
		private function makeboards():void{
			//name, moneycost, costarray, benefit
			var b1:Board= new Board("gizaboard", brownResources[1], new WonderStage("Giza Stage 1", 0, [brownResources[1],brownResources[1]],[0],[3]),
									new WonderStage("Giza Stage 2", 0, [brownResources[0],brownResources[0],brownResources[0]],[0],[5]),
									new WonderStage("Giza Stage 3", 0, [brownResources[1],brownResources[1],brownResources[1],brownResources[1]],[0],[7]));
			var b2:Board= new Board("zeusboard", brownResources[0], new WonderStage("Zeus Stage 1", 0, [brownResources[0],brownResources[0]],[0],[3]),
									new WonderStage("Zeus Stage 2", 0, [brownResources[1],brownResources[1]], [], []),//free build,
									new WonderStage("Zeus Stage 3", 0, [brownResources[3],brownResources[3]],[0],[7]));
			var b3:Board= new Board("rhodesboard", brownResources[3], new WonderStage("Rhodes Stage 1", 0, [brownResources[0],brownResources[0]],[0],[3]),
									new WonderStage("Rhodes Stage 2", 0, [brownResources[2],brownResources[2],brownResources[2]],[1],[2]),//free build,
									new WonderStage("Rhodes Stage 3", 0, [brownResources[3],brownResources[3],brownResources[3],brownResources[3]],[0],[7]));
			boards.push(b1);
			boards.push(b2);
			boards.push(b3);

		}
		
		
		private function getPlayerStates():Array{
			var bob:Array = new Array();
			trace(bob);
			var playerStates:Array = new Array();
			for(var i:Number = 0; i < players.length; i++){
				trace(players[i].getCards());
				playerStates.push([players[i].getBoard(), players[i].getCards(), players[i].getPlayedCards(), players[i].getWonderStagesBuilt(), players[i].getCoins(), players[i].getMilitaryTokens()]);
			}
			return playerStates;
		}
		
		public function elevated(e:ClickEvent){
			human.cardClicked(e);
		}
		
	}

}