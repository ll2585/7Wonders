package 
{
	import flash.display.MovieClip;
		import flash.display.Bitmap;
		import flash.events.MouseEvent;
	public class GreyCard extends Card 
	{
		private var cardName:String;
		private var color:String;
		private var benefit:String;
		private var resource:Array;

		
 		public function GreyCard(givenName:String, coinCost:Number, cost:Array,  resources:Array) 
		{
			super(givenName, coinCost, cost);
			setColor("grey");
			cardName = givenName;
			//makeImage(givenName);
			makeClickable();
			resource = resources;
		}
		
		public function getResources():Array{
			return resource;
		}

	}
}