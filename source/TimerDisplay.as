package  
{
	import flash.display.MovieClip;
	import flash.text.TextField;

	public class TimerDisplay extends MovieClip
	{
		public var TimerDisplayField:TextField;
		
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