CasparTimer
===========

CasparCG Timer component for stopwatches or countdowns


Component parameters
-------------------

### CountMode
Sets if timer will count time up or down. A string value from the following list:
* up
* down

### StartTime
Sets the timer initial time in milliseconds

### StopTime
Sets the timer end time in milliseconds

### Format
A string value from the following list:
* hh:mm:ss
* mm:ss
* mm:ss.f (f stands for 1/10th second)
* ss.f (f stands for 1/10th second)

When this parameter is set, the FormatProvider is automatically assigned with a corresponding object instance.

### FormatProvider
An object reference to a class instance implementing the ITimerDisplayFormat interface. This can only be called from script with one of the provided classes or one created by you.

### Text Display Formatting parameters
The text used to display the system time can be formatted using the following parameters:
* Font
* TextColor
* Size
* Align
* Bold
* Italic


Component methods
-------------------

### Start
Starts the timer or resumes counting if previously stopped.

### Stop
Stops the timer

### Reset
Stops the timer and resets back to the Start Time.

### SetTime(milliseconds:Number)
Sets the timer's current time.


Controlling the timer
-------------------
The CasparTimer can be controlled by invoking the available component methods or by sending special command keywords using the template fields.
The available keywords are:
* countup
* countdown
* start
* stop
* reset
* set<00000>
* begin<00000>
* end<00000>

The "set", "begin" and "end" commands must specify a numeric value, representing the time intended in milliseconds.
You can specify more than one command at once by separating them with a space character in the field value.

Example:

* countup begin162000000 end324000000 start

	This would start a timer beginning at 45 minutes (45 * 60 * 60 * 1000) and ending at 90 minutes

* countdown begin30000 start

	This would start a 30 seconds countdown

		
Compiling .SWC file
-------------------
* Open CasparTimer.fla with Flash CS 4
* Press CTRL+ENTER to publish and test Flash
* Check there are no compilation errors
* In the Library, right-click the CasparTimer component
* Select Export SWC File...
* Name and save the SWC file


Using .SWC file
-------------------
* Copy the .SWC file to the Flash components folder:
	* On Windows 7, C:\\Users\\<username>\\AppData\\Local\\Adobe\\Flash CS4\\en\\Configuration\\Components
	* On Windows XP, C:\\Documents and Settings\\<username>\\Local Settings\\Application Data\\Adobe\\Adobe Flash CS4\\en\\Configuration\\Components