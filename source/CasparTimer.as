package  
{
	import fl.core.UIComponent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.system.Capabilities;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import org.computus.model.*;
	import se.svt.caspar.template.components.ICasparComponent;
	
	public class CasparTimer extends UIComponent implements ICasparComponent
	{
		public static const COUNT_UP:String = "up";
		public static const COUNT_DOWN:String = "down";
		
		private var _displayField:TimerDisplay;
		private var _textFormat:TextFormat;
		private var _timekeeper:Timekeeper;
		
		private var _startTime:Number;
		private var _stopTime:Number;
		private var _mode:String;
		private var _format:String;
		private var _formatProvider:ITimerDisplayFormat
		
		private var _isRunning:Boolean;
		
		public function CasparTimer() 
		{
trace("CasparTimer");			
			
			_mode = COUNT_UP;
			_startTime = 0;
			_stopTime = 0;
			_format = "mm:ss";
			_formatProvider = new TimerDisplayFormat_mmss();
			
			_textFormat = new TextFormat();
			_textFormat.font = "Arial";
			_textFormat.color = 0x000000;
			_textFormat.size = 12;
			_textFormat.align = "left";
			_textFormat.bold = false;
			_textFormat.italic = false;
			
			_displayField.DisplayTextFormat = _textFormat;
			
			updateTimeDisplay(this.StartTime);

			_timekeeper = new Timekeeper();
			_timekeeper.setValue(0);
			_timekeeper.setTickDuration(50);
			_timekeeper.setTickFrequency(50);
			_timekeeper.addEventListener(TimekeeperEvent.CHANGE, this.onTick);
			
			_isRunning = false;
		}

		override protected function configUI():void 
		{
trace("configUI");			
			super.configUI();
			
			//Create a definition for the display text field
			var displayDef:Object = this.loaderInfo.applicationDomain.getDefinition("TimerDisplay");
			
			 //Create the display text field object, cast it as TextField and add it in our object
            _displayField = addChild(new displayDef) as TimerDisplay;
		}		
		
		override protected function draw():void 
		{
trace("draw: " + width + " " + height);			
			//it is always important to set the display field object with the same width of the component
            //It doesnt resize automatically
			/*
			_displayField.x = 0;
			_displayField.y = 0;
			_displayField.width = width;
			_displayField.height = height;
			
			_displayField.SetBounds(0, 0, width, height);
			*/
			// always call super.draw() at the end 
			super.draw();			
		}
		
		protected function onTick(param1:TimekeeperEvent) : void
		{
			var t:Number = param1.time;
			if (_mode == COUNT_DOWN)
			{
				// subtract elapsed time from start time if we are counting down
				t = _startTime - t;
			}
			
			updateTimeDisplay(t);
		}			
		
		private function updateTimeDisplay(t:Number)
		{
			if ((_mode == COUNT_UP && _stopTime > 0 && t >= _stopTime) || (_mode == COUNT_DOWN && t <= _stopTime))
			{
				// we have reached stop time, so stop the timer
				_timekeeper.stopTicking();
				_timekeeper.setValue(_stopTime);
				_displayField.UpdateTimerDisplay(_formatProvider.formatTime(_stopTime));
			}
			else
			{
				_displayField.UpdateTimerDisplay(_formatProvider.formatTime(t));
			}
		}
		
		/******    COMPONENT CUSTOM PROPERTIES    ******/

		[Inspectable(name="CountMode", defaultValue="up", enumeration="up,down", type="String")]
		public function set CountMode(mode:String):void 
		{
			_mode = mode.toLowerCase() == COUNT_DOWN ? COUNT_DOWN : COUNT_UP;
		}
		public function get CountMode():String
		{
			return _mode;
		}
		
		[Inspectable(name="StartTime", defaultValue="0")]
		public function set StartTime(milliseconds:Number):void 
		{
			_startTime = milliseconds;
			if (!_isRunning)
			{
				Reset();
			}
		}
		public function get StartTime():Number
		{
			return _startTime;
		}
		
		[Inspectable(name="StopTime", defaultValue="0")]
		public function set StopTime(milliseconds:Number):void 
		{
			_stopTime = milliseconds;
			if (!_isRunning)
			{
				Reset();
			}
		}
		public function get StopTime():Number
		{
			return _stopTime;
		}
		
		[Inspectable(name="Format", defaultValue="mm:ss", type="String")]
		public function set Format(f:String):void 
		{
			if (f != _format)
			{
				switch (f)
				{
					case "hh:mm:ss":
						_format = f;
						_formatProvider = new TimerDisplayFormat_hhmmss();
						break;

					case "mm:ss":
						_format = f;
						_formatProvider = new TimerDisplayFormat_mmss();
						break;

					case "mm:ss.f":
						_format = f;
						_formatProvider = new TimerDisplayFormat_mmssf();
						break;

					case "ss.f":
						_format = f;
						_formatProvider = new TimerDisplayFormat_ssf();
						break;
				}
				
				if (!_isRunning)
				{
					Reset();
				}
			}
		}
		
		public function get Format():String
		{
			return _mode;
		}
		
		public function set FormatProvider(fp:ITimerDisplayFormat):void 
		{
			if (fp != null)
			{
				_formatProvider = fp;
				if (!_isRunning)
				{
					Reset();
				}
			}
		}
		
		public function get FormatProvider():ITimerDisplayFormat
		{
			return _formatProvider;
		}
		
		// text format options
		[Inspectable(name = "Font", type="Font Name", defaultValue="Arial")]
		public function set Font(font:String):void
		{
			_textFormat.font = font;
			_displayField.DisplayTextFormat = _textFormat;
		}
		public function get Font():String
		{
			return _textFormat.font;
		}

		[Inspectable(name = "TextColor", type="Color", defaultValue="0x000000")]
		public function set TextColor(c:int):void
		{
			_textFormat.color = c;
			_displayField.DisplayTextFormat = _textFormat;
			updateTimeDisplay(this.StartTime);
		}
		public function get TextColor():int
		{
			return int(_textFormat.color);
		}
		
		[Inspectable(name = "Size", type="Number", defaultValue=12)]
		public function set Size(s:Number):void
		{
			_textFormat.size = s;
			_displayField.DisplayTextFormat = _textFormat;
		}
		public function get Size():Number
		{
			return Number(_textFormat.size);
		}

		[Inspectable(name = "Align", type="String", enumeration="left, center, right", defaultValue="left")]
		public function set Align(a:String):void
		{
			_textFormat.align = a;
			_displayField.DisplayTextFormat = _textFormat;
		}
		public function get Align():String
		{
			return _textFormat.align;
		}

		[Inspectable(name = "Bold", type="Boolean", defaultValue=false)]
		public function set Bold(b:Boolean):void
		{
			_textFormat.bold = b;
			_displayField.DisplayTextFormat = _textFormat;
		}
		public function get Bold():Boolean
		{
			return _textFormat.bold;
		}
		
		[Inspectable(name = "Italic", type="Boolean", defaultValue=false)]
		public function set Italic(i:Boolean):void
		{
			_textFormat.italic = i;
			_displayField.DisplayTextFormat = _textFormat;
		}
		public function get Italic():Boolean
		{
			return _textFormat.italic;
		}		

		
		
		
		
		/******    COMPONENT PUBLIC METHODS    ******/
		
		public function Start():void 
		{
trace("START CALLED");
			_timekeeper.startTicking();
			_isRunning = true;
		}
		
		public function Stop():void 
		{
			_timekeeper.stopTicking();
		}
		
		public function SetTime(milliseconds:Number):void 
		{
			_timekeeper.setValue(milliseconds);
			updateTimeDisplay(milliseconds);
		}
		
		public function Reset():void 
		{
trace("RESET CALLED");			
			_timekeeper.stopTicking();
			_timekeeper.setValue(_startTime);
			_isRunning = false;
			
			updateTimeDisplay(this.StartTime);
		}

		
		/* INTERFACE se.svt.caspar.template.components.ICasparComponent */
		
		[Inspectable(name='description', defaultValue='<component name="CasparTimer"><property name="text" type="string" info="Commands for controlling the timer separated by ;" /></component>')]
		public var description;
		
		public function SetData(xmlData:XML):void 
		{ 
			try
			{
				for each (var element:XML in xmlData.children())
				{
					switch(element.@id.toLowerCase())
					{
						case "text":
							var commandTokens:Array = element.@value.toLowerCase().split(" ");
							ProcessTimerCommands(commandTokens);
							break;
					}
				}
			}
			catch (e:Error)
			{
				throw new Error("CasparTimer error in SetData: " + e.message);
			}
		}
		
		private function ProcessTimerCommands(commandTokens:Array):void
		{
			for (var i:int = 0; i < commandTokens.length; i++)
			{
				if (startsWith(commandTokens[i], "set"))
				{
					this.SetTime(Number(commandTokens[i].substring(3)));
				}
				else if (startsWith(commandTokens[i], "begin"))
				{
					this.StartTime = Number(commandTokens[i].substring(4));
				}
				else if (startsWith(commandTokens[i], "end"))
				{
					this.StopTime = Number(commandTokens[i].substring(3));
				}
				else
				{
					switch(commandTokens[i])
					{
						case "countup":
							this.CountMode = "up";
							break;
							
						case "countdown":
							this.CountMode = "down";
							break;
	
						case "start":
							Start();
							break;
							
						case "stop":
							Stop();
							break;
							
						case "reset":
							Reset();
							break;
					}
				}
			}
		}
		
		private function startsWith(string:String, pattern:String):Boolean
		{
			string  = string.toLowerCase();
			pattern = pattern.toLowerCase();
					 
			return pattern == string.substr( 0, pattern.length );
		}		
		
		public function dispose():void
		{
			try
			{
				if (_timekeeper != null)
				{
					_timekeeper.stopTicking();
					_timekeeper.destroy();
				}
				_timekeeper = null;
			}
			catch (e:Error)
			{
				throw new Error("CasparTimer error in dispose: " + e.message);
			}
		}
	}
}
