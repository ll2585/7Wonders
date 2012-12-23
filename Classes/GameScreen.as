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
			temp.setHand(s[1]);
			temp.addEventListener(ClickEvent.ELEVATE, elevated);
			return temp;
		}
		
		public function elevated(e:ClickEvent){
			dispatchEvent( new ClickEvent( ClickEvent.ELEVATE, e.getClickedCard()  ) ); 
		}
		
	}

}