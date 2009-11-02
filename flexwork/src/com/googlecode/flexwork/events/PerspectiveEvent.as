package com.googlecode.flexwork.events
{

	public class PerspectiveEvent extends MessageEvent
	{
		public static const OPEN:String = "open";
		public static const OPENED:String = "opened";
		
		public var perspectiveName:String;

		public function PerspectiveEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public static function createOpenEvent(perspectiveNameValue:String):PerspectiveEvent
		{
			var perspectiveEvent:PerspectiveEvent = new PerspectiveEvent(OPEN);
			perspectiveEvent.perspectiveName=perspectiveNameValue;
			return perspectiveEvent;
		}
		
		
		public static function createOpenedEvent(perspectiveNameValue:String):PerspectiveEvent
		{
			var perspectiveEvent:PerspectiveEvent = new PerspectiveEvent(OPENED);
			perspectiveEvent.perspectiveName=perspectiveNameValue;
			return perspectiveEvent;
		}
	}
}