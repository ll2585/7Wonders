package 
{

	public class State 
	{
		private var age:Number;
		private var discardPile:Array;
		private var playerStates:Array;
		private var round:Number;
		
 		public function State(theage:Number, theround:Number, discard:Array, theplayerStates:Array) 
		{
				age = theage;
				round = theround;
				discardPile = discard;
				playerStates = theplayerStates;
			
		}
		
		
		public function getAge():Number{
			return age;
		}
		
		public function getDiscardPile():Array{
			return discardPile;
		}
		
		public function getPlayerStates():Array{
			return playerStates;
		}
		
		
		public function toString():String{
			var result:String = "age: " + age;
			result += "\n round: " + round;
			result += "\n discard pile: " + discardPile;
			result += "\n players: " + playerStates.length;
			for(var i:Number = 0; i < playerStates.length; i++){
				result += "\n player " + i + ": " + "board: " + playerStates[i][0].getName() + 
				"hand: " + playerStates[i][1] + ", cards built: " + playerStates[i][2] + 
				", wonder stages used: " + playerStates[i][3] + ", coins: " + playerStates[i][4] + 
				", military tokens: " + playerStates[i][5];
			}
			return result;
		}
		
		//s = string
		//s = for example, 12;4,3,2,1,5;1.2,3,4,5.6,4,2,4.1,2.6.-1,5,-1[1.2,3,4,5.6,4,2,4.1,2.6.-1,5,-1[1.2,3,4,5.6,4,2,4.1,2.6.-1,5,-1
		//so 3 players, 1st age, 2nd round, discard has cards 4,3,2,1,5
		//312
		//4,3,2,1,5
		//1.2,3,4,5.6,4,2,4.1,2.6.-1,5,-1[1.2,3,4,5.6,4,2,4.1,2.6.-1,5,-1[1.2,3,4,5.6,4,2,4.1,2.6.-1,5,-1
		
		//1.2,3,4,5.6,4,2,4.1,2.6.-1,5,-1
		//1.2,3,4,5.6,4,2,4.1,2.6.-1,5,-1
		//1.2,3,4,5.6,4,2,4.1,2.6.-1,5,-1
		//first player has board 1, in his hand he has cards 2,3,4,5, he has built cards 6,4,2,4, and wonder stages 1,2, and he has 6 gold, and -1, 5, -1 militar tokens
		public static function parseState(s:String):State{
			var sections:Array = s.split(";");
			var ageParse:Number = Number(sections[0].charAt(0));
			var roundParse:Number = Number(sections[0].charAt(1));
			var discardPileParse:Array = sections[1].split(",");
			var newDiscardPile:Array = new Array();
			for(var j:String in discardPileParse){
				newDiscardPile.push(Deck.parseCard(Number(j)));
			}
			
			var playerStatesArray:Array = new Array();
			var playerArrayParse = sections[2].split("[");
			for(var i:Number = 0; i < playerArrayParse.length; i++){
				var thisPlayerArray = playerArrayParse[i].split(".");
				var newPlayerState = new Array();
				newPlayerState.push(Game.parseBoard(thisPlayerArray[0]));
				var handParse:Array = thisPlayerArray[1].split(",");
				var newHand:Array = new Array();
				for(var n:String in handParse){
					newHand.push(Deck.parseCard(Number(n)));
				}
				newPlayerState.push(newHand);
				
				var builtParse:Array = thisPlayerArray[2].split(",");
				var newBuilt:Array = new Array();
				for(var n:String in builtParse){
					newBuilt.push(Deck.parseCard(Number(n)));
				}
				newPlayerState.push(newBuilt);
				var wonderStageParse:Array = thisPlayerArray[3].split(",");
				var newWonder:Array = new Array();
				for(var n:String in wonderStageParse){
					//!!!! CHANGE THIS
					newWonder.push(Deck.parseCard(Number(n)));
				}
				newPlayerState.push(newWonder);
				newPlayerState.push(Number(thisPlayerArray[4]));
				
				var militaryTokens:Array = thisPlayerArray[5].split(",");
				newPlayerState.push(militaryTokens);
				
				playerStatesArray.push(newPlayerState);
			}
			return new State(ageParse, roundParse, newDiscardPile, playerStatesArray);
			
		}
	}
}