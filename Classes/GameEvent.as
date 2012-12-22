package
{
	
	import flash.events.Event;
	
	class GameEvent extends Event
	{
		
		public static const DONE:String = "DONE";
		public static const DISCARD:String = "discard";
		public static const BUILD:String = "build";
		public static const ADDEDRESOURCE:String = "ADDEDRESOURCE";
		public static const BUILDWONDER:String = "BUILDWONDER";
		public static const OOPS:String = "OOPS";
				
		private var myString:String;
		
		public function GameEvent( type:String )
		{
			myString = type;
			super( type );
		}
		
	}
}