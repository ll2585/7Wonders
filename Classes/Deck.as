package{

	public class Deck  {
		private var deck:Array;
		private var age1Deck:Array;
		private var age2Deck:Array;
		private var age3Deck:Array;
		private var numPlayers:int;
		
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
		}
		
		public function makeCards():void{
			//name, moneycost, costarray, benefit
			age1Deck.push(new BrownCard("earth", 0, [], [Game.brownResources[0]]));
			age1Deck.push(new BrownCard("fire", 0,[], [Game.brownResources[1]]));
			age1Deck.push(new BrownCard("wind", 0,[], [Game.brownResources[2]]));
			age1Deck.push(new BrownCard("water", 0,[], [Game.brownResources[3]]));
			age1Deck.push(new GreyCard("heart",0 ,[], [Game.greyResources[0]]));
			age1Deck.push(new GreyCard("light", 0,[], [Game.greyResources[1]]));
			age1Deck.push(new GreyCard("dark", 0,[], [Game.greyResources[2]]));
			age1Deck.push(new BlueCard("altar", 0,[], 2));
			age1Deck.push(new BlueCard("baths", 0,[Game.brownResources[1]], 3));
			age1Deck.push(new BlueCard("theater", 0,[], 2));
			age1Deck.push(new RedCard("stockade", 0,[Game.brownResources[3]], 1));
			age1Deck.push(new RedCard("barracks", 0,[Game.brownResources[0]], 1));
			age1Deck.push(new RedCard("guardtower", 0,[Game.brownResources[2]], 1));
			age1Deck.push(new GreenCard("apothocary", 0,[Game.greyResources[0]], 1));
			age1Deck.push(new GreenCard("workshop", 0,[Game.greyResources[1]], 2));
			age1Deck.push(new GreenCard("scriptorium", 0,[Game.greyResources[2]], 3));
			age1Deck.push(new BrownCard("windwater", 1,[], [Game.brownResources[2] + "/" + Game.brownResources[3]]));
			age1Deck.push(new BrownCard("earthfire", 1,[], [Game.brownResources[0] + "/" + Game.brownResources[1]]));
			age1Deck.push(new YellowCard("westtradingpost", 0,[], 0, "left"));
			age1Deck.push(new YellowCard("easttradingpost", 0,[], 0, "right"));
			age1Deck.push(new YellowCard("marketplace", 0,[], 0, "gray"));
			//name, moneycost, costarray, benefit
			age2Deck.push(new GreyCard("heart",0 ,[], [Game.greyResources[0]]));
			age2Deck.push(new GreyCard("light", 0,[], [Game.greyResources[1]]));
			age2Deck.push(new GreyCard("dark", 0,[], [Game.greyResources[2]]));
			age2Deck.push(new BrownCard("sawmill",0 ,[], [Game.brownResources[0],Game.brownResources[0]]));
			age2Deck.push(new BrownCard("quarry", 0,[], [Game.brownResources[1],Game.brownResources[1]]));
			age2Deck.push(new BrownCard("brickyard", 0,[], [Game.brownResources[2],Game.brownResources[2]]));
			age2Deck.push(new BrownCard("foundry", 0,[], [Game.brownResources[3],Game.brownResources[3]]));
			age2Deck.push(new BlueCard("aqueduct", 0,[Game.brownResources[1],Game.brownResources[1],Game.brownResources[1]], 5, ["baths"]));
			age2Deck.push(new BlueCard("temple", 0,[Game.brownResources[0], Game.brownResources[2], Game.greyResources[1]], 3, ["altar"]));
			age2Deck.push(new BlueCard("statue", 0,[Game.brownResources[0], Game.brownResources[3], Game.brownResources[3]], 4, ["theater"]));
			age2Deck.push(new BlueCard("courthouse", 0,[Game.brownResources[2], Game.brownResources[2], Game.greyResources[0]], 4, ["scriptorium"]));
			age2Deck.push(new YellowCard("forum", 0,[Game.brownResources[2], Game.brownResources[2]], 3, Game.greyResources[0] + "/" + Game.greyResources[1] + "/" +Game.greyResources[2], ["westtradingpost", "easttradingpost"]));
			age2Deck.push(new YellowCard("caravansary", 0,[Game.brownResources[0], Game.brownResources[0]], 3, Game.brownResources[0] + "/" + Game.brownResources[1] + "/" +Game.brownResources[2] + "/" +Game.brownResources[3], ["marketplace"]));
			age2Deck.push(new YellowCard("vineyard", 0,[], 2, "1_brown_2"));
			age2Deck.push(new RedCard("walls", 0,[Game.brownResources[1],Game.brownResources[1],Game.brownResources[1]], 2));
			age2Deck.push(new RedCard("stables", 0,[Game.brownResources[0],Game.brownResources[2],Game.brownResources[3]], 2, ["apothocary"]));
			age2Deck.push(new RedCard("archeryrange", 0,[Game.brownResources[0],Game.brownResources[0],Game.brownResources[3]], 2, ["workshop"]));
			age2Deck.push(new GreenCard("dispensary", 0,[Game.brownResources[3],Game.brownResources[3],Game.greyResources[1]], 1, ["apothocary"]));
			age2Deck.push(new GreenCard("laboratory", 0,[Game.brownResources[2],Game.brownResources[2],Game.greyResources[2]], 2, ["workshop"]));
			age2Deck.push(new GreenCard("library", 0,[Game.brownResources[1], Game.brownResources[1], Game.greyResources[0]], 3, ["scriptorium"]));
			age2Deck.push(new GreenCard("school", 0,[Game.brownResources[0],Game.greyResources[2]], 3));
			
			//name, moneycost, costarray, benefit
			age3Deck.push(new BlueCard("pantheon", 0 ,[Game.brownResources[2],Game.brownResources[2],Game.brownResources[3],Game.greyResources[0],Game.greyResources[1],Game.greyResources[2]], 7, ["temple"]));
			age3Deck.push(new BlueCard("gardens",0 ,[Game.brownResources[0],Game.brownResources[2],Game.brownResources[2]], 5, ["statuecard"]));
			age3Deck.push(new BlueCard("townhall", 0, [Game.brownResources[1],Game.brownResources[1],Game.brownResources[3],Game.greyResources[0]], 6));
			age3Deck.push(new BlueCard("palace",0 ,[Game.brownResources[0],Game.brownResources[1],Game.brownResources[2],Game.brownResources[3],Game.greyResources[0],Game.greyResources[1],Game.greyResources[2]], 8));
			age3Deck.push(new BlueCard("senate", 0 ,[Game.brownResources[0],Game.brownResources[0],Game.brownResources[1],Game.brownResources[3]], 6, ["library"]));
			age3Deck.push(new YellowCard("haven", 0,[Game.greyResources[0], Game.brownResources[0], Game.brownResources[3]], 4, "1_brown_1", ["forum"]));
			age3Deck.push(new YellowCard("lighthouse", 0,[Game.greyResources[1], Game.brownResources[1]], 4, "1_yellow_1", ["caravansary"]));
			age3Deck.push(new YellowCard("arena", 0,[Game.brownResources[3], Game.brownResources[1], Game.brownResources[1]], 4, "3_none_1", ["dispensarycard"]));
			age3Deck.push(new RedCard("fortifications", 0,[Game.brownResources[1],Game.brownResources[3],Game.brownResources[3],Game.brownResources[3]], 3, ["walls"]));
			age3Deck.push(new RedCard("arsenal", 0,[Game.greyResources[0],Game.brownResources[0],Game.brownResources[0],Game.brownResources[3]], 3));
			age3Deck.push(new RedCard("siegeworkshop", 0,[Game.brownResources[0],Game.brownResources[2],Game.brownResources[2],Game.brownResources[2],Game.brownResources[2]], 3, ["laboratory"]));
			age3Deck.push(new GreenCard("lodge", 0,[Game.brownResources[2],Game.brownResources[2],Game.greyResources[0],Game.greyResources[2]], 1, ["dispensary"]));
			age3Deck.push(new GreenCard("observatory", 0,[Game.brownResources[3],Game.brownResources[3],Game.greyResources[1],Game.greyResources[0]], 2, ["laboratory"]));
			age3Deck.push(new GreenCard("university", 0,[Game.brownResources[0],Game.brownResources[0],Game.greyResources[1],Game.greyResources[2]], 3, ["library"]));
			age3Deck.push(new GreenCard("academy", 0,[Game.brownResources[1],Game.brownResources[1],Game.brownResources[1],Game.greyResources[1]], 1, ["school"]));
			age3Deck.push(new GreenCard("study", 0,[Game.brownResources[0],Game.greyResources[0],Game.greyResources[2]], 2, ["school"]));

			//name, moneycost, costarray, benefit
			var guildDeck:Array = new Array(); 
			guildDeck.push(new PurpleCard("workersguild", 0,[Game.brownResources[3], Game.brownResources[3], Game.brownResources[2], Game.brownResources[0], Game.brownResources[1]], 0, "1_brown_2"));
			guildDeck.push(new PurpleCard("craftsmenguild", 0,[Game.brownResources[3], Game.brownResources[3],Game.brownResources[1],Game.brownResources[1]], 0, "2_grey_2"));
			guildDeck.push(new PurpleCard("tradersguild", 0,[Game.greyResources[0],Game.greyResources[1],Game.greyResources[2]], 0, "1_yellow_2"));
			guildDeck.push(new PurpleCard("philosophersguild", 0,[Game.brownResources[2],Game.brownResources[2],Game.brownResources[2],Game.greyResources[0],Game.greyResources[2]], 0, "1_green_2"));
			guildDeck.push(new PurpleCard("spiesguild", 0,[Game.brownResources[2],Game.brownResources[2],Game.brownResources[2],Game.greyResources[1]], 0, "1_red_2"));
			guildDeck.push(new PurpleCard("strategistsguild", 0,[Game.brownResources[3],Game.brownResources[3],Game.brownResources[2],Game.greyResources[0]], 1, "1_defeat_2"));
			guildDeck.push(new PurpleCard("shipownersguild", 0,[Game.brownResources[0],Game.brownResources[0],Game.brownResources[0],Game.greyResources[1],Game.greyResources[2]], 2, "1_2_brown_grey_purple"));
			guildDeck.push(new PurpleCard("scientistsguild", 0,[Game.brownResources[0],Game.brownResources[0],Game.brownResources[3],Game.brownResources[3],Game.greyResources[2]], 3));
			guildDeck.push(new PurpleCard("magistratesguild", 0,[Game.brownResources[0], Game.brownResources[0], Game.brownResources[0],Game.brownResources[1],Game.greyResources[0]], 0, "1_blue_2"));
			guildDeck.push(new PurpleCard("buildersguild", 0,[Game.brownResources[1],Game.brownResources[1],Game.brownResources[2],Game.brownResources[2],Game.greyResources[1]], 0, "1_none_3"));
			
			guildDeck = DocumentClass.shuffle(guildDeck);
			for(var i:int = 0; i < numPlayers+2; i++){
				age3Deck.push(guildDeck[i]);
			}
		}
		
	public function getAgeDeck(age:int, numPlayers:int):Array{
		return deck[age-1];
	}
	}
}