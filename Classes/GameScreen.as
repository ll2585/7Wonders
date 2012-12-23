package
{
	import flash.display.MovieClip;

	public class GameScreen extends MovieClip
	{
		
		private var playerScreen:PlayerScreen;
		private var leftScreen:NeighborScreen;
		private var rightScreen:NeighborScreen;
		public function GameScreen(s:State) 
		{
			playerScreen = parsePlayerScreen(s.getPlayerStates()[1]);
			playerScreen.x = 170;
			addChild(playerScreen);
		}
		
		public function parsePlayerScreen(s:Array):PlayerScreen{
			var temp:PlayerScreen = new PlayerScreen();
			temp.setBoard(s[0]);
			var temp2:Array = new Array();
			for(var i:Number = 0; i < 6; i++){
				temp2.push(new BrownCard("earth", 0, [], [Game.brownResources[0]]));
			}
			temp.setHand(temp2);
			return temp;
		}
		
	}

}