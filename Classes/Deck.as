package{

	public class Deck  {
		private var deck:Array;
		private var age1Deck:Array;
		private var age2Deck:Array;
		private var age3Deck:Array;
		private var numPlayers:int;
		public static var allCards:Array = new Array();
		
		public function Deck(){
			age1Deck = new Array();
			age2Deck = new Array();
			age3Deck = new Array();
			numPlayers = 3;
			makeCards();
			deck = new Array(age1Deck, age2Deck, age3Deck);
			/*for(var i:int=0; i < deck.length; i++){
				for(var j:int=0; j < deck[i].length; j++){
					trace("the cost of " + deck[i][j] + " is " + deck[i][j].getCost());
				}
			}*/
			for(var i:Number = 0; i < age1Deck.length; i++){
				allCards.push(age1Deck[i]);
			}
			for(var i:Number = 0; i < age2Deck.length; i++){
				allCards.push(age2Deck[i]);
			}
			for(var i:Number = 0; i < age3Deck.length; i++){
				allCards.push(age3Deck[i]);
			}
		}
		
		public function makeCards():void{
			//name, moneycost, costarray, benefit
			age1Deck.push(new BrownCard(0, "earth", 0, [], [Game.brownResources[0]]));
			age1Deck.push(new BrownCard(1, "fire", 0,[], [Game.brownResources[1]]));
			age1Deck.push(new BrownCard(2, "wind", 0,[], [Game.brownResources[2]]));
			age1Deck.push(new BrownCard(3, "water", 0,[], [Game.brownResources[3]]));
			age1Deck.push(new GreyCard(4, "heart",0 ,[], [Game.greyResources[0]]));
			age1Deck.push(new GreyCard(5, "light", 0,[], [Game.greyResources[1]]));
			age1Deck.push(new GreyCard(6, "dark", 0,[], [Game.greyResources[2]]));
			age1Deck.push(new BlueCard(7, "altar", 0,[], 2));
			age1Deck.push(new BlueCard(8, "baths", 0,[Game.brownResources[1]], 3));
			age1Deck.push(new BlueCard(9, "theater", 0,[], 2));
			age1Deck.push(new RedCard(10, "stockade", 0,[Game.brownResources[0]], 1));
			age1Deck.push(new RedCard(11, "barracks", 0,[Game.brownResources[3]], 1));
			age1Deck.push(new RedCard(12, "guardtower", 0,[Game.brownResources[2]], 1));
			age1Deck.push(new GreenCard(13, "apothocary", 0,[Game.greyResources[0]], 1));
			age1Deck.push(new GreenCard(14, "workshop", 0,[Game.greyResources[1]], 2));
			age1Deck.push(new GreenCard(15, "scriptorium", 0,[Game.greyResources[2]], 3));
			age1Deck.push(new BrownCard(16, "windwater", 1,[], [Game.brownResources[2] + "/" + Game.brownResources[3]]));
			age1Deck.push(new BrownCard(17, "earthfire", 1,[], [Game.brownResources[0] + "/" + Game.brownResources[1]]));
			age1Deck.push(new YellowCard(18, "westtradingpost", 0,[], 0, "left"));
			age1Deck.push(new YellowCard(19, "easttradingpost", 0,[], 0, "right"));
			age1Deck.push(new YellowCard(20 ,"marketplace", 0,[], 0, "gray"));
			//name, moneycost, costarray, benefit
			age2Deck.push(new GreyCard(21 ,"heart",0 ,[], [Game.greyResources[0]]));
			age2Deck.push(new GreyCard(22, "light", 0,[], [Game.greyResources[1]]));
			age2Deck.push(new GreyCard(23, "dark", 0,[], [Game.greyResources[2]]));
			age2Deck.push(new BrownCard(24, "sawmill",0 ,[], [Game.brownResources[0],Game.brownResources[0]]));
			age2Deck.push(new BrownCard(25, "quarry", 0,[], [Game.brownResources[1],Game.brownResources[1]]));
			age2Deck.push(new BrownCard(26, "brickyard", 0,[], [Game.brownResources[2],Game.brownResources[2]]));
			age2Deck.push(new BrownCard(27, "foundry", 0,[], [Game.brownResources[3],Game.brownResources[3]]));
			age2Deck.push(new BlueCard(28, "aqueduct", 0,[Game.brownResources[1],Game.brownResources[1],Game.brownResources[1]], 5, ["baths"]));
			age2Deck.push(new BlueCard(29, "temple", 0,[Game.brownResources[0], Game.brownResources[2], Game.greyResources[1]], 3, ["altar"]));
			age2Deck.push(new BlueCard(30, "statue", 0,[Game.brownResources[0], Game.brownResources[3], Game.brownResources[3]], 4, ["theater"]));
			age2Deck.push(new BlueCard(31, "courthouse", 0,[Game.brownResources[2], Game.brownResources[2], Game.greyResources[0]], 4, ["scriptorium"]));
			age2Deck.push(new YellowCard(32, "forum", 0,[Game.brownResources[2], Game.brownResources[2]], 3, Game.greyResources[0] + "/" + Game.greyResources[1] + "/" +Game.greyResources[2], ["westtradingpost", "easttradingpost"]));
			age2Deck.push(new YellowCard(33, "caravansary", 0,[Game.brownResources[0], Game.brownResources[0]], 3, Game.brownResources[0] + "/" + Game.brownResources[1] + "/" +Game.brownResources[2] + "/" +Game.brownResources[3], ["marketplace"]));
			age2Deck.push(new YellowCard(34, "vineyard", 0,[], 2, "1_brown_2"));
			age2Deck.push(new RedCard(35, "walls", 0,[Game.brownResources[1],Game.brownResources[1],Game.brownResources[1]], 2));
			age2Deck.push(new RedCard(36, "stables", 0,[Game.brownResources[0],Game.brownResources[2],Game.brownResources[3]], 2, ["apothocary"]));
			age2Deck.push(new RedCard(37, "archeryrange", 0,[Game.brownResources[0],Game.brownResources[0],Game.brownResources[3]], 2, ["workshop"]));
			age2Deck.push(new GreenCard(38, "dispensary", 0,[Game.brownResources[3],Game.brownResources[3],Game.greyResources[1]], 1, ["apothocary"]));
			age2Deck.push(new GreenCard(39, "laboratory", 0,[Game.brownResources[2],Game.brownResources[2],Game.greyResources[2]], 2, ["workshop"]));
			age2Deck.push(new GreenCard(40, "library", 0,[Game.brownResources[1], Game.brownResources[1], Game.greyResources[0]], 3, ["scriptorium"]));
			age2Deck.push(new GreenCard(41 ,"school", 0,[Game.brownResources[0],Game.greyResources[2]], 3));
			
			//name, moneycost, costarray, benefit
			age3Deck.push(new BlueCard(42, "pantheon", 0 ,[Game.brownResources[2],Game.brownResources[2],Game.brownResources[3],Game.greyResources[0],Game.greyResources[1],Game.greyResources[2]], 7, ["temple"]));
			age3Deck.push(new BlueCard(43 ,"gardens",0 ,[Game.brownResources[0],Game.brownResources[2],Game.brownResources[2]], 5, ["statuecard"]));
			age3Deck.push(new BlueCard(44, "townhall", 0, [Game.brownResources[1],Game.brownResources[1],Game.brownResources[3],Game.greyResources[0]], 6));
			age3Deck.push(new BlueCard(45, "palace",0 ,[Game.brownResources[0],Game.brownResources[1],Game.brownResources[2],Game.brownResources[3],Game.greyResources[0],Game.greyResources[1],Game.greyResources[2]], 8));
			age3Deck.push(new BlueCard(46, "senate", 0 ,[Game.brownResources[0],Game.brownResources[0],Game.brownResources[1],Game.brownResources[3]], 6, ["library"]));
			age3Deck.push(new YellowCard(47, "haven", 0,[Game.greyResources[0], Game.brownResources[0], Game.brownResources[3]], 4, "1_brown_1", ["forum"]));
			age3Deck.push(new YellowCard(48, "lighthouse", 0,[Game.greyResources[1], Game.brownResources[1]], 4, "1_yellow_1", ["caravansary"]));
			age3Deck.push(new YellowCard(49, "arena", 0,[Game.brownResources[3], Game.brownResources[1], Game.brownResources[1]], 4, "3_none_1", ["dispensarycard"]));
			age3Deck.push(new RedCard(50 ,"fortifications", 0,[Game.brownResources[1],Game.brownResources[3],Game.brownResources[3],Game.brownResources[3]], 3, ["walls"]));
			age3Deck.push(new RedCard(51, "arsenal", 0,[Game.greyResources[0],Game.brownResources[0],Game.brownResources[0],Game.brownResources[3]], 3));
			age3Deck.push(new RedCard(52, "siegeworkshop", 0,[Game.brownResources[0],Game.brownResources[2],Game.brownResources[2],Game.brownResources[2],Game.brownResources[2]], 3, ["laboratory"]));
			age3Deck.push(new GreenCard(53, "lodge", 0,[Game.brownResources[2],Game.brownResources[2],Game.greyResources[0],Game.greyResources[2]], 1, ["dispensary"]));
			age3Deck.push(new GreenCard(54, "observatory", 0,[Game.brownResources[3],Game.brownResources[3],Game.greyResources[1],Game.greyResources[0]], 2, ["laboratory"]));
			age3Deck.push(new GreenCard(55, "university", 0,[Game.brownResources[0],Game.brownResources[0],Game.greyResources[1],Game.greyResources[2]], 3, ["library"]));
			age3Deck.push(new GreenCard(56, "academy", 0,[Game.brownResources[1],Game.brownResources[1],Game.brownResources[1],Game.greyResources[1]], 1, ["school"]));
			age3Deck.push(new GreenCard(57, "study", 0,[Game.brownResources[0],Game.greyResources[0],Game.greyResources[2]], 2, ["school"]));

			//name, moneycost, costarray, benefit
			var guildDeck:Array = new Array(); 
			guildDeck.push(new PurpleCard(58, "workersguild", 0,[Game.brownResources[3], Game.brownResources[3], Game.brownResources[2], Game.brownResources[0], Game.brownResources[1]], 0, "1_brown_2"));
			guildDeck.push(new PurpleCard(59, "craftsmenguild", 0,[Game.brownResources[3], Game.brownResources[3],Game.brownResources[1],Game.brownResources[1]], 0, "2_grey_2"));
			guildDeck.push(new PurpleCard(60, "tradersguild", 0,[Game.greyResources[0],Game.greyResources[1],Game.greyResources[2]], 0, "1_yellow_2"));
			guildDeck.push(new PurpleCard(61, "philosophersguild", 0,[Game.brownResources[2],Game.brownResources[2],Game.brownResources[2],Game.greyResources[0],Game.greyResources[2]], 0, "1_green_2"));
			guildDeck.push(new PurpleCard(62, "spiesguild", 0,[Game.brownResources[2],Game.brownResources[2],Game.brownResources[2],Game.greyResources[1]], 0, "1_red_2"));
			guildDeck.push(new PurpleCard(63, "strategistsguild", 0,[Game.brownResources[3],Game.brownResources[3],Game.brownResources[2],Game.greyResources[0]], 1, "1_defeat_2"));
			guildDeck.push(new PurpleCard(64, "shipownersguild", 0,[Game.brownResources[0],Game.brownResources[0],Game.brownResources[0],Game.greyResources[1],Game.greyResources[2]], 2, "1_2_brown_grey_purple"));
			guildDeck.push(new PurpleCard(65, "scientistsguild", 0,[Game.brownResources[0],Game.brownResources[0],Game.brownResources[3],Game.brownResources[3],Game.greyResources[2]], 3));
			guildDeck.push(new PurpleCard(66, "magistratesguild", 0,[Game.brownResources[0], Game.brownResources[0], Game.brownResources[0],Game.brownResources[1],Game.greyResources[0]], 0, "1_blue_2"));
			guildDeck.push(new PurpleCard(67, "buildersguild", 0,[Game.brownResources[1],Game.brownResources[1],Game.brownResources[2],Game.brownResources[2],Game.greyResources[1]], 0, "1_none_3"));
			
			guildDeck = DocumentClass.shuffle(guildDeck);
			for(var i:int = 0; i < numPlayers+2; i++){
				age3Deck.push(guildDeck[i]);
			}
		}
		
	public function getAgeDeck(age:int, numPlayers:int):Array{
		return deck[age-1];
	}
	
	public static function parseCard(n:Number):Card{
		for(var i:Number = 0; i < allCards.length; i++){
			var c:Card = allCards[i];
			if(c.getID() == n) return c;
		}
		return null;
	}
	}
}