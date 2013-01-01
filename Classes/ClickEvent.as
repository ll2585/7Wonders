package
{
	
	import flash.events.Event;
	
	class ClickEvent extends Event
	{
		
		public static const cardClicked:String = "card clicked";
		public static const ELEVATE:String = "ELEVATED";
		public static const FREEBUILD:String = "FREEBUILD";
		public static const PAYBUILD:String = "PAYBUILD";
		public static const BUILT:String = "BUILT";
		public static const CANNOTBUILD:String = "CANNOTBUILD";
		public static const DISCARD:String = "DISCARD";
		public static const FREEWONDER:String = "FREEWONDER";
		public static const PAYWONDER:String = "PAYWONDER";
		public static const NEXTSTAGE:String = "NEXTSTAGE";
		
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
		
		public function getType():String{
			return myString;
		}
	}
}