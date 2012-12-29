package
{
	import flash.display.MovieClip;

	public class GameScreen extends MovieClip
	{
		
		private var playerScreen:PlayerScreen;
		private var leftScreen:LeftNeighborScreen;
		private var rightScreen:LeftNeighborScreen;
		public function GameScreen(s:State) 
		{	
			playerScreen = parsePlayerScreen(s.getPlayerStates()[1]);
			playerScreen.x = 250;
			addChild(playerScreen);
			leftScreen = parseLeftNeighborScreen(s.getPlayerStates()[0]);
			addChild(leftScreen);
		}
		
		public function parsePlayerScreen(s:Array):PlayerScreen{
			var temp:PlayerScreen = new PlayerScreen();
			
			temp.setBoard(s[0]);
			temp.setHand(s[1]);
			temp.setBuilt(s[2]);
			temp.setCoins(s[4]);
			temp.setMilitary(s[5]);
			temp.addEventListener(ClickEvent.ELEVATE, elevated);
			temp.addEventListener(ClickEvent.BUILT, elevated);
			temp.addEventListener(ClickEvent.DISCARD, elevated);
			return temp;
		}
		
		public function parseLeftNeighborScreen(s:Array):LeftNeighborScreen{
			var temp:LeftNeighborScreen = new LeftNeighborScreen();
			
			temp.setBoard(s[0]);
			temp.setBuilt(s[2]);
			temp.setCoins(s[4]);
			temp.setMilitary(s[5]);
			temp.addEventListener(ClickEvent.ELEVATE, elevated);
			temp.addEventListener(ClickEvent.BUILT, elevated);
			temp.addEventListener(ClickEvent.DISCARD, elevated);
			return temp;
		}
		
		public function elevated(e:ClickEvent){
			if(e.getType() == "ELEVATED"){
				dispatchEvent( new ClickEvent( ClickEvent.ELEVATE, e.getClickedCard()  ) ); 
			} else if (e.getType() == "BUILT"){
				dispatchEvent( new ClickEvent( ClickEvent.BUILT, e.getClickedCard()  ) ); 
			} else if (e.getType() == "DISCARD"){
				dispatchEvent( new ClickEvent( ClickEvent.DISCARD, e.getClickedCard()  ) ); 
			}
		}
		
		public function passOn(e:ClickEvent){
			playerScreen.receiveEvent(e);
		}
		
		public function passInfo(e:InformationEvent){
			playerScreen.receiveInfoEvent(e);
		}
		
	}

}