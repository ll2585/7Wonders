package
{
	
	import flash.events.Event;
	
	class ClickEvent extends Event
	{
		
		public static const cardClicked:String = "card clicked";
		public static const ELEVATE:String = "event elevated";
		private var myString:String;
		private var card:Card;
		
		public function ClickEvent( type:String, cardType:Card )
		{
			card = cardType;
			myString = type;
			super( type );
		}
		
		public function getClickedCard():Card{
			return card;
		}
	}
}