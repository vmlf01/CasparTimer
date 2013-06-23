package  
{
	import fl.core.UIComponent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.system.Capabilities;
	import flash.text.Font;
	import flash.text.TextField;
	//import flash.text.TextField;
	import org.computus.model.*;
	import se.svt.caspar.template.components.ICasparComponent;
	
	public class CasparTimer extends UIComponent implements ICasparComponent
	{
		public static const COUNT_UP:String = "up";
		public static const COUNT_DOWN:String = "down";
		
		private var _displayField:TimerDisplay;
		private var _timekeeper:Timekeeper;
		
		private var _startTime:Number;
		private var _stopTime:Number;
		private var _mode:String;
		
		private var _isRunning:Boolean;
		
		public function CasparTimer() 
		{
trace("CasparTimer");			
			
			_mode = COUNT_UP;
			
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
			if ((_mode == COUNT_UP && _stopTime > 0 && param1.time >= _stopTime) || (_mode == COUNT_DOWN && param1.time <= _stopTime))
			{
				// we have reached stop time, so stop the timer
				_timekeeper.stopTicking();
				_timekeeper.setValue(_stopTime);
				_displayField.UpdateTimerDisplay(millisecondsConverter(_stopTime));
			}
			else
			{
				_displayField.UpdateTimerDisplay(millisecondsConverter(param1.time));
			}
		}			
		
		protected function millisecondsConverter(millisec:Number):String
		{
			var h:Number=Math.floor(millisec/3600000);
			var m:Number=Math.floor((millisec%3600000)/60000);
			var s:Number = Math.floor(((millisec % 3600000) % 60000) / 1000);
			var f:Number = Math.floor((millisec % 1000) / 100);
			
			return(h==0?"00:":(h<10?"0"+h.toString()+":":h.toString()+":"))+(m<10?"0"+m.toString():m.toString())+":"+(s<10?"0"+s.toString():s.toString())+"."+f.toString();
		}		
	
		/******    COMPONENT CUSTOM PROPERTIES    ******/

		[Inspectable(defaultValue="up", type="list", enumeration="up,down")]
		public function set CountMode(mode:String):void 
		{
			_mode = mode.toLowerCase() == COUNT_DOWN ? COUNT_DOWN : COUNT_UP;
		}
		public function get CountMode():String
		{
			return _mode;
		}
		
		[Inspectable(defaultValue="0")]
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
		
		
		/******    COMPONENT PUBLIC METHODS    ******/
		
		public function Start():void 
		{
			_timekeeper.startTicking();
			_isRunning = true;
		}
		
		public function Stop():void 
		{
			_timekeeper.stopTicking();
		}
		
		public function Reset():void 
		{
			_timekeeper.stopTicking();
			_timekeeper.setValue(_startTime);
			_isRunning = false;
			
			_displayField.UpdateTimerDisplay(millisecondsConverter(_startTime));
		}

		
		/* INTERFACE se.svt.caspar.template.components.ICasparComponent */
		
		//<component name='CasparTimer'><property name='text' type='string' info='URL to the image to load (.png, .jpg, .gif)' /><property name='x' type='number' info='X position offset' /><property name='y' type='number' info='Y position offset' /><property name='scale' type='number' info='The scale of the image (in percent)' /><property name='mirrorX' type='boolean' info='If true the image is mirrored in the x axis' /><property name='mirrorY' type='boolean' info='If true the image is mirrored in the y axis' /><property name='opacity' type='number' info='The opacity of the image (in percent)' /><property name='rotation' type='number' info='The rotation of the image (in degrees)' /><property name='bitmap' type='string' info='URL to the image to load (.png, .jpg, .gif)' /><property name='bitmapBytes' type='base64' info='Base64 representation of the image to load (.png, .jpg, .gif)' /></component>
		
//		[Inspectable(name='description', defaultValue='<component name="CasparTimer"><property name="text" type="string" info="URL to the image to load (.png, .jpg, .gif)" /><property name="x" type="number" info="X position offset" /><property name="y" type="number" info="Y position offset" /><property name="scale" type="number" info="The scale of the image (in percent)" /><property name="mirrorX" type="boolean" info="If true the image is mirrored in the x axis" /><property name="mirrorY" type="boolean" info="If true the image is mirrored in the y axis" /><property name="opacity" type="number" info="The opacity of the image (in percent)" /><property name="rotation" type="number" info="The rotation of the image (in degrees)" /><property name="bitmap" type="string" info="URL to the image to load (.png, .jpg, .gif)" /></component>')]
		//public var description:String;
		
		public function SetData(xmlData:XML):void 
		{ 
			/*
			for each (var element:XML in xmlData.children())
			{
				switch(element.@id.toXMLString())
				{
					case "text":
						loadBitmap(element.@value.toXMLString());
						break;
					case "x":
						bitmap_x = Number(element.@value.toXMLString());
						break;
					case "y":
						bitmap_y = Number(element.@value.toXMLString());
						break;
					case "scale":
						bitmap_scale = Number(element.@value.toXMLString());
						break;
					case "outline":
						toggleOutline(element.@value.toXMLString().toLowerCase() == "false" ? false : true);
						break;
					//case "scaleY":
						//bitmap_scaleY = Number(element.@value.toXMLString());
						//break;
					case "mirrorX":
						bitmap_mirrorX = element.@value.toXMLString().toLowerCase() == "false" ? false : true;
						break;
					case "mirrorY":
						bitmap_mirrorY = element.@value.toXMLString().toLowerCase() == "false" ? false : true;
						break;
					case "opacity":
						bitmap_opacity = Number(element.@value.toXMLString());
						break;
					case "rotation":
						bitmap_rotation = Number(element.@value.toXMLString());
						break;
					case "bitmap":
						loadBitmap(element.@value.toXMLString());
						break;
					case "bitmapBytes":
						//loadBitmapBytes(decode(element.@value.toXMLString()));
						loadBitmapBytes(Base64.decode(element.@value.toXMLString()));
						break;
				}
			}			
			*/
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
