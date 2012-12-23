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
				result += "\n player " + i + ": " + "board: " + playerStates[i][0].getName() + "hand: " + playerStates[i][1] + ", cards built: " + playerStates[i][2] + ", wonder stages used: " + playerStates[i][3] + ", coins: " + playerStates[i][4] + ", military tokens: " + playerStates[i][5];
			}
			return result;
		}
	}
}