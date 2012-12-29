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
		
		public function getRound():Number{
			return round;
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
		
		public function toParser():String{
			var result:String = "";
			result += age + "" + round;
			result += ";";
			for(var i:Number = 0; i < discardPile.length; i++){
				var c:Card = discardPile[i];
				if(i != discardPile.length -1){
				result += c.getID() + ",";
				}
				else{
					result += c.getID();
				}
			}
			result += ";";
			for(var i:Number = 0; i < playerStates.length; i++){
				if(i != playerStates.length -1){
				result += parsePlayerState(playerStates[i]) + "[";
				}
				else{
					result += parsePlayerState(playerStates[i]);
				}
			}
			return result;
		}
		
		public function parsePlayerState(s:Array):String{
			var result:String = "";
			var b:Board = s[0];
			result += b.getID()+".";
			for(var i:Number = 0; i < s[1].length; i++){
				var c:Card = s[1][i];
				if(i != s[1].length -1){
				result += c.getID() + ",";
				}
				else{
					result += c.getID();
				}
			}
			result += ".";
			for(var i:Number = 0; i < s[2].length; i++){
				var c:Card = s[2][i];
				if(i != s[2].length -1){
				result += c.getID() + ",";
				}
				else{
					result += c.getID();
				}
			}
			result += ".";
			for(var i:Number = 0; i < s[3].length; i++){
				var c:Card = s[3][i];
				if(i != s[3].length -1){
				result += c.getID() + ",";
				}
				else{
					result += c.getID();
				}
			}
			result += ".";
			trace(" the gold is " + s[4]);
			result += s[4] + ".";
			for(var i:Number = 0; i < s[5].length; i++){
				if(i != s[5].length -1){
				result += s[5][i] + ",";
				}
				else{
					result += s[5][i];
				}
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
			trace("the sections are " + sections);
			var ageParse:Number = Number(sections[0].charAt(0));
			var roundParse:Number = Number(sections[0].charAt(1));
			
			var newDiscardPile:Array = new Array();
			if(sections[1].indexOf(",") > 0){
				var discardPileParse:Array = sections[1].split(",");
				for(var i:Number = 0; i < discardPileParse.length; i++){
					newDiscardPile.push(Deck.parseCard(Number(discardPileParse[i])));
				}
			}
			
			var playerStatesArray:Array = new Array();
			var playerArrayParse = sections[2].split("[");
			for(var i:Number = 0; i < playerArrayParse.length; i++){
				var thisPlayerArray = playerArrayParse[i].split(".");
				var newPlayerState = new Array();
				newPlayerState.push(Game.parseBoard(thisPlayerArray[0]));
				var handParse:Array = thisPlayerArray[1].split(",");
				var newHand:Array = new Array();
				for(var j:Number = 0; j < handParse.length; j++){
					newHand.push(Deck.parseCard(Number(handParse[j])));
				}
				newPlayerState.push(newHand);
				
				var newBuilt:Array = new Array();

				if(thisPlayerArray[2].indexOf(",") > 0){
					var builtParse:Array = thisPlayerArray[2].split(",");
					for(var j:Number = 0; j < builtParse.length; j++){
						newBuilt.push(Deck.parseCard(Number(builtParse[j])));
					}
				}
				newPlayerState.push(newBuilt);
				var newWonder:Array = new Array();
				if(thisPlayerArray[3].indexOf(",") > 0){
					var wonderStageParse:Array = thisPlayerArray[3].split(",");
					for(var j:Number = 0; j < wonderStageParse.length; j++){
					//!!!! CHANGE THIS
					newWonder.push(Deck.parseCard(Number(wonderStageParse[j])));
					}
				}
				newPlayerState.push(newWonder);
				newPlayerState.push(Number(thisPlayerArray[4]));

				var militaryTokens:Array = new Array();
				if(thisPlayerArray[5].indexOf(",") > 0){
					militaryTokens = thisPlayerArray[5].split(",");
				}
				newPlayerState.push(militaryTokens);
				
				playerStatesArray.push(newPlayerState);
			}
			return new State(ageParse, roundParse, newDiscardPile, playerStatesArray);
			
		}
	}
}