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
		private const ENDTIME:String = "fl.getDocumentDOM().selection[0].parameters.EndTime.value";

		public function CasparTimerParametersPanel() 
		{
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			init();
		}

		private function init():void 
		{
			//CountModeGroup.addEventListener(Event.CHANGE, onCountModeChanged);
			cbFormat.addEventListener(Event.CHANGE, onFormatChanged);
			
			var startTime:String = MMExecute(STARTTIME);
			var endTime:String = MMExecute(ENDTIME);
			
			/*
			startHH.text = MMExecute(STARTHH);
			startMM.text = MMExecute(STARTHH);
			startSS.text = MMExecute(STARTHH);

			endHH.text = MMExecute(START);
			endMM.text = MMExecute(STARTMM);
			endSS.text = MMExecute(STARTSS);
			*/
			
			//MMExecute('fl.getDocumentDOM().selection[0].parameters.cssString["value"] = "'+String(loadedCSS)+'"');
		}
		
		private function onCountModeChanged(event:Event):void
		{
		}
		
		private function onFormatChanged(event:Event):void
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