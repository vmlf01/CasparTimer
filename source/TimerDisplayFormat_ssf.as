/*
* 
* Formats a milliseconds time value into an 'ss.f' string representation
*
*/
package  
{
	public class TimerDisplayFormat_ssf implements ITimerDisplayFormat
	{
		public function formatTime(millisec:Number):String
		{
			var s:Number = Math.floor(millisec / 1000);
			var f:Number = Math.floor((millisec % 1000) / 100);

			return	(s<10 ? "0" + s.toString() : s.toString()) + "." +
					f.toString();
		}
	}
}