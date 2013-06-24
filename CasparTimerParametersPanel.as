package
{
	import flash.events.Event;
	import fl.data.DataProvider;
	import flash.display.StageScaleMode;
	import adobe.utils.MMExecute;
	import fl.controls.ComboBox;
	import fl.controls.TextInput;
	import flash.display.Sprite;

	public class CasparTimerParametersPanel extends Sprite 
	{
		private const COUNTMODE:String = "fl.getDocumentDOM().selection[0].parameters.CountMode.value";
		private const STARTTIME:String = "fl.getDocumentDOM().selection[0].parameters.StartTime.value";
		private const STOPTIME:String = "fl.getDocumentDOM().selection[0].parameters.StopTime.value";
		
		public function CasparTimerParametersPanel() 
		{
			//this.stage.scaleMode = StageScaleMode.NO_SCALE;
			init();
		}

		private function init():void 
		{
trace("executing init...");
			// TODO: need to find a better way to initialize 
			// numericsteppers values
			this.addEventListener(Event.ACTIVATE, onActivate);

			rbCountUp.addEventListener(Event.CHANGE, onCountModeChanged);
			rbCountDown.addEventListener(Event.CHANGE, onCountModeChanged);
			cbFormat.addEventListener(Event.CHANGE, onFormatChanged);
			
			startHH.addEventListener(Event.CHANGE, onStartTimeChanged);
			startMM.addEventListener(Event.CHANGE, onStartTimeChanged);
			startSS.addEventListener(Event.CHANGE, onStartTimeChanged);
			
			endHH.addEventListener(Event.CHANGE, onEndTimeChanged);
			endMM.addEventListener(Event.CHANGE, onEndTimeChanged);
			endSS.addEventListener(Event.CHANGE, onEndTimeChanged);

			var countMode:String = String(MMExecute(COUNTMODE));
			
	trace("COUNTING: " + countMode);
			rbCountUp.selected = countMode == "up" ? true : false;
			rbCountDown.selected = countMode == "down" ? true : false;
			/*
			var startTime:Number = Number(MMExecute(STARTTIME));
			var endTime:Number = Number(MMExecute(STOPTIME));
			
			startHH.value = startTime / (60 * 60 * 1000);
			startMM.value = (startTime % (60 * 60 * 1000)) / (60 * 1000);
			startSS.value = ((startTime % (60 * 60 * 1000)) % (60 * 1000)) / 1000;
			
			startTimeText.text = String(startTime);
			*/
		}
		
		private function onActivate(e:Event):void
		{
			var startTime:Number = Number(MMExecute(STARTTIME));
			var endTime:Number = Number(MMExecute(STOPTIME));
			
			startHH.value = startTime / (60 * 60 * 1000);
			startMM.value = (startTime % (60 * 60 * 1000)) / (60 * 1000);
			startSS.value = ((startTime % (60 * 60 * 1000)) % (60 * 1000)) / 1000;
			
			endHH.value = endTime / (60 * 60 * 1000);
			endMM.value = (endTime % (60 * 60 * 1000)) / (60 * 1000);
			endSS.value = ((endTime % (60 * 60 * 1000)) % (60 * 1000)) / 1000;
		}

		
		private function onCountModeChanged(e:Event):void
		{
			// TODO: fix radio button value change
trace("NAME: " + e.target.name);
			if (e.target.selected) 
			{
				var countMode:String = (e.target == rbCountDown ? "down" : "up");

				MMExecute(COUNTMODE + ' = "' + countMode + '"');
trace(COUNTMODE + ' = "' + countMode + '"');
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
		}
		
		private function onEndTimeChanged(e:Event):void
		{
			var hours:Number = Number(endHH.value);
			var minutes:Number = Number(endMM.value);
			var seconds:Number = Number(endSS.value);

			// convert time to milliseconds
			MMExecute(STOPTIME + ' = ' + (hours * 60 * 60 * 1000 + minutes * 60 * 1000 + seconds * 1000));
trace(STOPTIME + ' = ' + (hours * 60 * 60 * 1000 + minutes * 60 * 1000 + seconds * 1000));
		}
		
		private function onFormatChanged(e:Event):void
		{
		}
		
		private function updateTimerPreview():void 
		{
		/*
			// update the visibleText value in the component SWF
			MMExecute('fl.getDocumentDOM().selection[0].parameters.visibleXMLText["value"] = "'+escape(newText)+'";');
			placeholder_ti.htmlText = newText;
			var jsfl:String = "";
			jsfl += "var selectedArray = fl.getDocumentDOM().selection;";
			jsfl += "fl.getDocumentDOM().selectNone();";
			jsfl += "fl.getDocumentDOM().selection = selectedArray;";
			MMExecute(jsfl);
			*/
		}
	}
}