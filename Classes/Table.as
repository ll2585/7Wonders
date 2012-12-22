package 
{
	import flash.display.MovieClip;
	public class Table extends MovieClip 
	{
		private var game:Game;
		public function Table() 
		{
 			game = new Game();
			addChild(game);
		}
	}
}