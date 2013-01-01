package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class GameScreen extends MovieClip
	{
		
		private var playerScreen:PlayerScreen;
		private var leftScreen:LeftNeighborScreen;
		private var rightScreen:RightNeighborScreen;
		private var scoringButton:ScoreButton;
		private var players:Array;
		private var scoringWindow:ScoringWindow;
				
		public function GameScreen(s:State, p:Array) 
		{	scoringButton = new ScoreButton();
			scoringButton.x = 730;
			scoringButton.y = 280;
			scoringButton.addEventListener( MouseEvent.CLICK, scoreWindow );
			addChild(scoringButton);
			playerScreen = parsePlayerScreen(s.getPlayerStates()[1]);
			playerScreen.x = 260;
			players = p;
			leftScreen = parseLeftNeighborScreen(s.getPlayerStates()[0]);
			addChild(leftScreen);
			rightScreen = parseRightNeighborScreen(s.getPlayerStates()[2]);
			addChild(rightScreen);
			rightScreen.x = 960;
			addChild(playerScreen);
			
		}
		
		public function parsePlayerScreen(s:Array):PlayerScreen{
			var temp:PlayerScreen = new PlayerScreen();
			
			temp.setBoard(s[0]);
			if(s[1].length > 0){
				temp.setHand(s[1]);
			}
			trace("s2 is " + s[2]);
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
		
		public function parseRightNeighborScreen(s:Array):RightNeighborScreen{
			var temp:RightNeighborScreen = new RightNeighborScreen();
			
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
		
		public function scoreWindow( mouseEvent:MouseEvent ):void{
			scoringWindow = new ScoringWindow(players);
			playerScreen.removeListeners();
			addChild(scoringWindow);
			scoringWindow.addEventListener(NavigationEvent.closeScoringWindow, closeWindow);
		}
		
		public function closeWindow( e:NavigationEvent ):void{
			removeChild(scoringWindow);
			playerScreen.enableListeners( new GameEvent(GameEvent.OOPS));
		}
		
		public function passInfo(e:InformationEvent){
			playerScreen.receiveInfoEvent(e);
		}
		
	}

}