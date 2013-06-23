package  
{
	import flash.display.MovieClip;

	public class TimerDisplay extends MovieClip
	{
		public function TimerDisplay() 
		{
		}
		
		public function UpdateTimerDisplay(time:String)
		{
			TimerDisplayField.text = time;
		}
		
		public function SetBounds(x:int, y:int, w:int, h:int)
		{
			TimerDisplayField.x = x;
			TimerDisplayField.y = y;
			TimerDisplayField.width = w;
			TimerDisplayField.height = h;
		}
	}
}