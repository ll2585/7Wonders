package
{
	import flash.display.MovieClip;

	public class GameScreen extends MovieClip
	{
		public playerScreen:PlayerScreen;
		public leftScreen:NeighborScreen;
		public rightScreen:NeighborScreen;
		public function GameScreen(s:State) 
		{
			playerScreen = parsePlayerScreen(s.getPlayerStates()[1]);
		}
		
		public function parsePlayerScreen(s:Array):PlayerScreen{
			
		}
		
	}

}