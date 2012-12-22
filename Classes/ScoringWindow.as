package
{
	import flash.display.MovieClip;
	import flash.text.*;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.events.MouseEvent;


	public class ScoringWindow extends MovieClip 
	{
		private var players:Array;
		private var p1Array;
		private var p2Array;
		private var p3Array;
		private var scoreArray:Array;

		public function ScoringWindow(playerArray:Array)
		{
			players = playerArray;
			p1Array = new Array(player1, p1red, p1money, p1wonder, p1blue, p1yellow, p1purple, p1green, p1sum);
			p2Array = new Array(player2, p2red, p2money, p2wonder, p2blue, p2yellow, p2purple, p2green, p2sum);
			p3Array = new Array(player3, p3red, p3money, p3wonder, p3blue, p3yellow, p3purple, p3green, p3sum);
			scoreArray = new Array(p1Array, p2Array, p3Array);
			for(var i:int = 0; i < scoreArray.length; i++){
				scoreArray[i][0].text = players[i].getBoardName();
				scoreArray[i][1].text = players[i].getMilitaryPoints();
				scoreArray[i][2].text = players[i].getMoneyPoints();
				scoreArray[i][3].text = players[i].getWonderPoints();
				scoreArray[i][4].text = players[i].getBluePoints();
				scoreArray[i][5].text = players[i].getYellowPoints();
				scoreArray[i][6].text = players[i].getPurplePoints();
				scoreArray[i][7].text = players[i].getGreenPoints();
				scoreArray[i][8].text = players[i].getTotalPoints();
			}
			
		}
		
	}
}