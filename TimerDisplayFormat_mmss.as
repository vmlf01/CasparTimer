/*
* 
* Formats a milliseconds time value into an 'mm:ss' string representation
*
*/
package  
{
	public class TimerDisplayFormat_mmss implements ITimerDisplayFormat
	{
		public function formatTime(millisec:Number):String
		{
			var m:Number=Math.floor(millisec/60000);
			var s:Number = Math.floor((millisec % 60000) / 1000);

			return	(m<10 ? "0" + m.toString() : m.toString()) + ":" +
					(s<10 ? "0" + s.toString() : s.toString());
		}
	}
}