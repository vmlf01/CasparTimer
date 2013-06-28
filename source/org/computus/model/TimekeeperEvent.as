/*	
	====================================================================================
	2008 | John Dalziel  | The Computus Engine  |  http://www.computus.org

	All source code licenced under The MIT Licence
	====================================================================================  
	
	Timekeeper Event
*/

package org.computus.model
{
	import flash.events.Event;
      
	public class TimekeeperEvent extends Event 
	{
   
	// --------------------------------------------------------------
	// PROPERTIES

		public static const CHANGE:String = "change";
		public var time:Number
      
	// --------------------------------------------------------------
	// CONSTRUCTOR & DESTRUCTOR
	  
		public function TimekeeperEvent(type:String, ms:Number):void
		{
			super(type, true);
			time = ms
		}
      
		public override function clone():Event 
		{
			return new TimekeeperEvent(type, time);
		}
	}
}