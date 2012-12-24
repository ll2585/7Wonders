package 
{
		import flash.display.MovieClip;

	public class CoinImage extends MovieClip 
	{
		private var coins:Number;
		
		
 		public function CoinImage() 
		{
			coins = 0;
			updateDisplay();
		}
	
		public function updateDisplay(){
			coinAmt.text = coins.toString();
		}
		
		public function updateCoins(c:Number){
			coins = c;
			updateDisplay();
		}


	}
}