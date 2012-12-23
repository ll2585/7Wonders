package
{
	
	import flash.events.Event;
	
	class InformationEvent extends Event
	{
		

		public static const wat:String = "wat";
		private var myString:String;
		private var info:Array;
		
		public function InformationEvent( type:String, information:Array )
		{
			info = information;
			myString = type;
			super( type );
		}
		
		public function getInfo():Array{
			return info;
		}
		
		public function getType():String{
			return myString;
		}
	}
}