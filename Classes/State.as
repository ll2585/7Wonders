package 
{

	public class State 
	{
		private var age:Number;
		private var discardPile:Array;
		private var playerStates:Array;
		private var round:Number;
		
 		public function State(...args) 
		{
			if(args[0] =="new"){
				makeNewState(args[1]);
			}else{
				age = args[0];
				round = args[1];
				discardPile = args[2];
				playerStates = args[3];
			}
			
		}
		
		private function emptyPlayerState():Array{
			var hand:Array = new Array();
			var cards:Array = new Array();
			var wonderStages:Array = new Array();
			var gold:Number = 6;
			var militaryTokens:Array = new Array();
			var temp:Array = [hand, cards, wonderStages, gold, militaryTokens];
			return temp;
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
		
		public function makeNewState(numPlayers:Number){
			age = 0;
			round = 0;
			discardPile = new Array();
			playerStates = new Array();
			for(var i:Number = 0; i < numPlayers; i++){
				playerStates.unshift(emptyPlayerState());
			}
		}
		
		public function toString():String{
			var result:String = "age: " + age;
			result += "\n round: " + round;
			result += "\n discard pile: " + discardPile;
			result += "\n players: " + playerStates.length;
			for(var i:Number = 0; i < playerStates.length; i++){
				result += "\n player " + i + ": " + "hand: " + playerStates[i][0] + ", cards built: " + playerStates[i][1] + ", wonder stages used: " + playerStates[i][2] + ", coins: " + playerStates[i][3] + ", military tokens: " + playerStates[i][4];
			}
			return result;
		}
	}
}