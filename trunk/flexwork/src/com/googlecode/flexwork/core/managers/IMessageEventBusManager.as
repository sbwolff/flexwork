package com.googlecode.flexwork.core.managers
{
	import flash.events.Event;

	public interface IMessageEventBusManager
	{
		function subscribe(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void

		function publish(event:Event):Boolean

		function unsubscribe(type:String, listener:Function, useCapture:Boolean=false):void
	}
}
