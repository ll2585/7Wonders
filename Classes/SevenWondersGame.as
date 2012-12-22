package 
{
	import flash.display.MovieClip;
	public class SevenWondersGame extends MovieClip 
	{
		private var table:Table;
		public function SevenWondersGame() 
		{
 			table = new Table();
			addChild(table);
		}
	}
}