package
{
	import flash.display.MovieClip;

	public class PlayerScreen extends MovieClip
	{
		private var board:Board;
		private var cardInfo:CardInfoScreen;
		private var cards:Array;
		public function PlayerScreen() 
		{
			
		}
		
		
		public function setBoard(b:Board):void{
			board = b;
			b.y = 350;
			addChild(b);
		}
		
		public function setHand(c:Array):void{
			var firstX:Number = (board.width/2)-(c[0].width/2);
			var distance:Number = -(10 + 7*c[0].width-board.width)/6;
			var startX:Number;
			if(c.length % 2 == 0){
				startX = board.x + board.width/2-c.length/2*(c[0].width+distance)+(distance/2);
			}else{
				startX = board.x + board.width/2-Math.floor(c.length/2)*(c[0].width+distance)-(c[0].width/2);
			}
			//var startX:Number = board.x + board.width/2-Math.floor(c.length/2)*(c[0].width-distance)-c.length%2*(distance/2)-(c.length+1)%2*(c[0].width/2);
			for(var i:Number = 0; i < c.length; i++){
				c[i].x = startX + i*distance + i*( c[i].width);
				c[i].y = 410;
				addChild(c[i]);
				c[i].addEventListener(ClickEvent.cardClicked, cardClicked);
				c[i].makeClickable();
			}
			cards = c;
		}
		
		public function cardClicked(e:ClickEvent):void {
			for(var i:int = 0; i < cards.length; i++){
				cards[i].removeEventListener(ClickEvent.cardClicked, cardClicked);
			}
			dispatchEvent( new ClickEvent( ClickEvent.ELEVATE, e.getClickedCard()  ) );
			
			//cardInfo.addEventListener( GameEvent.OOPS, enableListeners );
		}
		
		public function closeCardInfo(e:NavigationEvent):void{
			removeChild(cardInfo);
		}
		
		public function receiveEvent(e:ClickEvent):void{
			cardInfo = new CardInfoScreen(e.getClickedCard());
			cardInfo.x = 400;
			cardInfo.y = 200;

			//cardInfo.addEventListener( GameEvent.DISCARD, discardCard );
			cardInfo.addEventListener( NavigationEvent.closeCardInfo, closeCardInfo );
			if(e.getType()=="FREEBUILD"){
				cardInfo.enableBuild();

			} else if(e.getType() == "PAYBUILD"){
				
			}
			cardInfo.addEventListener( ClickEvent.BUILT, buildCard );
			addChild(cardInfo);
		}
		
		public function buildCard(e:ClickEvent):void{
			dispatchEvent( new ClickEvent( ClickEvent.BUILT, e.getClickedCard()  ) );
		}
		
		public function setBuilt(c:Array):void{
			var resourceYMove:Number = 23;
			var resourceXMove:Number = Card.SMALLIMAGESIZE;
			var resourceX = board.x;
			var resourceY = board.y - resourceYMove;
			for(var i:Number = 0; i < c.length; i++){
				if(c[i].getColor() == "brown"){
				addChild(c[i]);
				}
			}
			
		}
		
	}

}