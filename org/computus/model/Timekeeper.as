/*	
	====================================================================================
	2008 | John Dalziel  | The Computus Engine  |  http://www.computus.org

	All source code licenced under The MIT Licence
	====================================================================================  
	
	Accurate Timekeeper in AS3
	
	PROBLEM
	- Both 'onEnterFrame' and 'Timer' events have variable periodicity and cannot be relied upon 
	  to keep reliable time.
	
	SOLUTION
	- The timekeeper works by keeping a very fast internal regulator to update a slower user clock.
	- Periodic accuracy is achieved by referencing the system clock and maintaining an accumulator.
	
	FEATURES
	- Stop and start the timekeeper
	- Get and set the time (in milliseconds)
	- Get and set the tickFrequency. Default = every 1 second
	- Get and set the tickDuration. Default = 1 second
	
	LIMITATIONS
	- tickDuration values smaller than one second will work but are not recommended.
	- For capacity reasons the datatype for both 'time' and 'tickDuration' is Number.
	- For speed reasons the datatype for 'time' is Number, rather than a Date. 
	  Conversion to Date is really simple: var d = new Date(time)
*/

package org.computus.model
{
	import flash.events.*;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	import flash.utils.getTimer;

	public class Timekeeper extends EventDispatcher
	{

	// --------------------------------------------------------------
	// PROPERTIES
	
		// user defined 'tick' duration and frequency 
		protected var time:Number					// user time in ms since Uinx epoch
		protected var isTicking:Boolean 	= false	// is user clock ticking?
		protected var tickFrequency:int		= 1000	// 1 second
		protected var tickDuration:Number	= 1000	// per second
	
		// internal system timekeeper
		private var regulator:Timer					// system timekeeper
		private var regulatorAcc:int				// ms accumulated since last 'tick'
		private var regulatorCache:int = 0			// previous value of getTimer()
		
	// --------------------------------------------------------------
	// CONSTRUCTOR & DESTRUCTOR

		public function Timekeeper():void
		{
			super()
			init()
		}
		
		public function destroy():void
		{
			// Cleanup listeners
			regulator.removeEventListener(TimerEvent.TIMER, onTimerEvent);
		}
				
	// --------------------------------------------------------------
	// PUBLIC

		// convenient 'real time' functions
		public function setRealTimeValue():void 
		{
			var d = new Date()
			time = d.valueOf() 
		}
		public function setRealTimeTick():void
		{
			setTickDuration( 1000 )
			setTickFrequency( 1000 )
		}
		
		// Time in milliseconds since the Unix epoch
		public function getValue():Number	{ return time }
		public function setValue( ms:Number ):void 
		{
			if (time != ms )
			{
				time = ms
trace ( "TICK: " + time + "  " + new Date(time))

				// send onChange TimekeeperEvent
				var o = new TimekeeperEvent( TimekeeperEvent.CHANGE, time )
				dispatchEvent(o);
			}
		}
	
		// Tick duration in milliseconds. Negative values will make the timekeeper tick backwards
		public function getTickDuration():Number { return tickDuration }
		public function setTickDuration( ms:Number ):void	{ tickDuration = ms }

		// Tick frequency in milliseconds
		public function getTickFrequency():int { return tickFrequency }
		public function setTickFrequency( ms:int ):void	{ tickFrequency = ms }
		
		// Stop / Start ticking
		public function stopTicking():void	{ isTicking = false }
		public function startTicking():void	{ isTicking = true }
				
	// --------------------------------------------------------------
	// INTERNAL REGULATOR
	
		private function init():void
		{
			regulatorAcc = 0;
			regulatorCache = getTimer();
			regulator = new Timer( 50 );	// updates regulator 20 times per second
			regulator.addEventListener(TimerEvent.TIMER, onTimerEvent);
			regulator.start();
		}

		private function onTimerEvent( event:TimerEvent ):void
		{
			var regulatorNew = getTimer()						// get system timer value
			var regulatorDelta = regulatorNew - regulatorCache	// calculate elapsed time since last 'tick'
			regulatorAcc += regulatorDelta						// increment accumulator
			
trace ( "regulator accumulator = " + regulatorAcc )
			
			if ( regulatorAcc > tickFrequency )					// check for a tick
			{
				// update user time
				if ( isTicking == true ) { setValue( time + tickDuration ) }
				
				// reset accumulator
				regulatorAcc -= tickFrequency
			}
			regulatorCache 		= regulatorNew					// cache previous regulator	value
		}				
	}
}