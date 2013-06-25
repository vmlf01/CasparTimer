package
{
	import flash.events.Event;
	import fl.data.DataProvider;
	import flash.display.StageScaleMode;
	import adobe.utils.MMExecute;
	import fl.controls.ComboBox;
	import fl.controls.TextInput;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class CasparTimerParametersPanel extends Sprite 
	{
		private const COUNTMODE:String = "fl.getDocumentDOM().selection[0].parameters.CountMode.value";
		private const STARTTIME:String = "fl.getDocumentDOM().selection[0].parameters.StartTime.value";
		private const STOPTIME:String = "fl.getDocumentDOM().selection[0].parameters.StopTime.value";
		private const FORMAT:String = "fl.getDocumentDOM().selection[0].parameters.Format.value";
		
		private var availableFormats:Array = new Array(
			{data:"hh:mm:ss", label:"hh:mm:ss"}, 
			{data:"mm:ss", label:"mm:ss"}, 
			{data:"mm:ss.f", label:"mm:ss.f"}, 
			{data:"ss.f", label:"ss.f"}, 
			{data:"custom", label:"custom"}
		);
		
		public function CasparTimerParametersPanel() 
		{
			//this.stage.scaleMode = StageScaleMode.NO_SCALE;
			addEventListener(Event.EXIT_FRAME, onReady);
		}

		private function onReady(e:Event):void
		{
			removeEventListener(Event.EXIT_FRAME, onReady);
			init();
		}
			
		private function init():void 
		{
trace("executing init...");
			// setup params change event handlers
			rbCountUp.addEventListener(Event.CHANGE, onCountModeChanged);
			rbCountDown.addEventListener(Event.CHANGE, onCountModeChanged);
			cbFormat.addEventListener(Event.CHANGE, onFormatChanged);
			
			startHH.addEventListener(Event.CHANGE, onStartTimeChanged);
			startMM.addEventListener(Event.CHANGE, onStartTimeChanged);
			startSS.addEventListener(Event.CHANGE, onStartTimeChanged);
			
			endHH.addEventListener(Event.CHANGE, onEndTimeChanged);
			endMM.addEventListener(Event.CHANGE, onEndTimeChanged);
			endSS.addEventListener(Event.CHANGE, onEndTimeChanged);
			
			btReset.addEventListener(MouseEvent.CLICK, onResetClicked);
			btStart.addEventListener(MouseEvent.CLICK, onStartClicked);
			btStop.addEventListener(MouseEvent.CLICK, onStopClicked);
			
			// set initial param values for selected timer component
			var countMode:String = String(MMExecute(COUNTMODE));
trace("COUNTING: " + countMode);
			rbCountUp.selected = countMode == "up" ? true : false;
			rbCountDown.selected = countMode == "down" ? true : false;
			
			var startTime:Number = Number(MMExecute(STARTTIME));
			var endTime:Number = Number(MMExecute(STOPTIME));

trace("START TIME: " + startTime);
trace(" STOP TIME: " + endTime);
			
			startHH.value = startTime / (60 * 60 * 1000);
			startMM.value = (startTime % (60 * 60 * 1000)) / (60 * 1000);
			startSS.value = ((startTime % (60 * 60 * 1000)) % (60 * 1000)) / 1000;
			
			endHH.value = endTime / (60 * 60 * 1000);
			endMM.value = (endTime % (60 * 60 * 1000)) / (60 * 1000);
			endSS.value = ((endTime % (60 * 60 * 1000)) % (60 * 1000)) / 1000;
			
			var format:String = String(MMExecute(FORMAT));
			cbFormat.dataProvider = new DataProvider(availableFormats);
trace("FORMAT: " + format);

			for (var i:Number = 0; i < cbFormat.dataProvider.length; i++) 
			{
				if(cbFormat.dataProvider.getItemAt(i).data == format) {
					cbFormat.selectedIndex = i;
					break;
				}
			}
		}
		
		/* parameters change event handlers */
		
		private function onCountModeChanged(e:Event):void
		{
			if (e.target.selected) 
			{
				var countMode:String = (e.target == rbCountDown ? "down" : "up");

				MMExecute(COUNTMODE + ' = "' + countMode + '"');
trace(COUNTMODE + ' = "' + countMode + '"');

				updateTimerPreview();
			}
		}
		
		private function onStartTimeChanged(e:Event):void
		{
			var hours:Number = Number(startHH.value);
			var minutes:Number = Number(startMM.value);
			var seconds:Number = Number(startSS.value);

			// convert time to milliseconds
			MMExecute(STARTTIME + ' = ' + (hours * 60 * 60 * 1000 + minutes * 60 * 1000 + seconds * 1000));
trace(STARTTIME + ' = ' + (hours * 60 * 60 * 1000 + minutes * 60 * 1000 + seconds * 1000));

			updateTimerPreview();
		}
		
		private function onEndTimeChanged(e:Event):void
		{
			var hours:Number = Number(endHH.value);
			var minutes:Number = Number(endMM.value);
			var seconds:Number = Number(endSS.value);

			// convert time to milliseconds
			MMExecute(STOPTIME + ' = ' + (hours * 60 * 60 * 1000 + minutes * 60 * 1000 + seconds * 1000));
trace(STOPTIME + ' = ' + (hours * 60 * 60 * 1000 + minutes * 60 * 1000 + seconds * 1000));

			updateTimerPreview();
		}
		
		private function onFormatChanged(e:Event):void
		{
			var format:String = e.target.selectedItem.data;
			
			MMExecute(FORMAT + ' = "' + format + '"');
trace(FORMAT + ' = "' + format + '"');

			updateTimerPreview();
		}
		
		private function onResetClicked(e:MouseEvent):void
		{
trace("RESET CLICK");
			// TODO: call reset on timer component
			//MMExecute("fl.getDocumentDOM().selection[0].Reset");
		}

		private function onStartClicked(e:MouseEvent):void
		{
trace("START CLICK");
			// TODO: call start on timer component
			//MMExecute("fl.getDocumentDOM().selection[0].Start");
		}

		private function onStopClicked(e:MouseEvent):void
		{
trace("STOP CLICK");
			// TODO: call stop on timer component
			//MMExecute("fl.getDocumentDOM().selection[0].Stop");
		}
		
		private function updateTimerPreview():void 
		{
			var jsfl:String = "";
			jsfl += "var selectedArray = fl.getDocumentDOM().selection;";
			jsfl += "fl.getDocumentDOM().selectNone();";
			jsfl += "fl.getDocumentDOM().selection = selectedArray;";
			MMExecute(jsfl);
		}
	}
}