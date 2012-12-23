﻿package
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
			temp.addEventListener(ClickEvent.BUILT, elevated);
			return temp;
		}
		
		public function elevated(e:ClickEvent){
			if(e.getType() == "ELEVATED"){
				dispatchEvent( new ClickEvent( ClickEvent.ELEVATE, e.getClickedCard()  ) ); 
			} else if (e.getType() == "BUILT"){
				dispatchEvent( new ClickEvent( ClickEvent.BUILT, e.getClickedCard()  ) ); 
			}
		}
		
		public function passOn(e:ClickEvent){
			playerScreen.receiveEvent(e);
		}
		
	}

}