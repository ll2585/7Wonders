﻿package  
{
	import flash.events.Event;
	public class NavigationEvent extends Event 
	{
		public static const closeCardInfo:String = "CLOSE CARD WINDOW";

		
		public function NavigationEvent( type:String ) 
		{ 
			super( type );
			
		} 

	}
}