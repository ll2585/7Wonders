package 
{

	public class State 
	{
		private var age:Number;
		private var discardPile:Array;
		private var playerStates:Array;
		
 		public function State(numPlayers:Number) 
		{
			age = 1;
			discardPile = new Array();
			playerStates = new Array();
			for(var i:Number = 0; i < numPlayers; i++){
				playerStates.unshift(emptyPlayerState());
			}
		}
		
		private function emptyPlayerState():Array{
			var hand:Array = new Array();
			var cards:Array = new Array();
			var wonderStages:Array = new Array();
			var gold:Number = 6;
			var militaryTokens:Array = new Array();
			var temp:Array = [gold, hand, cards, wonderStages, militaryTokens];
			return temp;
		}
		
	}
}