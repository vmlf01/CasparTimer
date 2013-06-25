/*
* 
* Formats a milliseconds time value into an 'hh:mm:ss' string representation
*
*/
package  
{
	public class TimerDisplayFormat_hhmmss implements ITimerDisplayFormat
	{
		public function formatTime(millisec:Number):String
		{
			var h:Number=Math.floor(millisec/3600000);
			var m:Number=Math.floor((millisec%3600000)/60000);
			var s:Number = Math.floor(((millisec % 3600000) % 60000) / 1000);

			return	(h<10 ? "0" + h.toString() : h.toString()) + ":" +
					(m<10 ? "0" + m.toString() : m.toString()) + ":" +
					(s<10 ? "0" + s.toString() : s.toString());
		}
	}
}