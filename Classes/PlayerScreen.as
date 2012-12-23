package
{
	import flash.display.MovieClip;

	public class PlayerScreen extends MovieClip
	{
		private var board:Board;
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
			trace("first x is " + board.width);
			var distance:Number = -(10 + 7*c[0].width-board.width)/6;
			var startX:Number;
			if(c.length % 2 == 0){
				startX = board.x + board.width/2-c.length/2*(c[0].width+distance)+(distance/2);
			}else{
				startX = board.x + board.width/2-Math.floor(c.length/2)*(c[0].width+distance)-(c[0].width/2);
			}
			//var startX:Number = board.x + board.width/2-Math.floor(c.length/2)*(c[0].width-distance)-c.length%2*(distance/2)-(c.length+1)%2*(c[0].width/2);
			trace("the first x is " + startX);
			for(var i:Number = 0; i < c.length; i++){
				c[i].x = startX + i*distance + i*( c[i].width);
				c[i].y = 410;
				addChild(c[i]);
			}
		}
		
	}

}