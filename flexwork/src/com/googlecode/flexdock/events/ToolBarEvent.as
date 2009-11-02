package com.googlecode.flexdock.events
{
	import flash.display.InteractiveObject;
	import flash.events.Event;

	import mx.controls.Menu;

	public class ToolBarEvent extends Event
	{
		private static const PREFIX:String="toolBar.";
		
		public static const CLICK:String=PREFIX+"Click";

		public var name:String;

		public var menu:Menu;

		public var buttonIndex:int;

		public var menuIndex:int;

		public var relatedObject:InteractiveObject;
		/**
		 *  The specific item in the dataProvider.
		 */
		public var item:Object;

		public function ToolBarEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{

			super(type, bubbles, cancelable);

		}

	}
}