package 
{
	import flash.display.MovieClip;
		import flash.display.Bitmap;
		import flash.events.MouseEvent;
	public class BlueCard extends Card 
	{
		private var cardName:String;
		private var color:String;
		private var benefit:String;
		private var points:int;

		
 		public function BlueCard(id:Number, givenName:String, coinCost:Number, cost:Array,  points:int, preReq:Array = null) 
		{
			super(id, givenName, coinCost, cost, preReq);
			setColor("blue");
			cardName = givenName;
			makeClickable();
			this.points = points;
		}
		
		public function getPoints():int{
			return points;
		}

	}
}