package com.googlecode.flexwork.events
{

	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * MessageEventBusManager.getInstance().subscribe(LoginEvent.EVENT_TYPE, someFunction);
	 * MessageEventBusManager.getInstance().publish(new LoginEvent(LoginEvent.EVENT_TYPE, param));
	 */
	public class MessageEventBusManager extends EventDispatcher implements IMessageEventBusManager
	{
		private static var _instance:MessageEventBusManager;

		public function subscribe(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			this.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		public function unsubscribe(type:String, listener:Function, useCapture:Boolean=false):void
		{
			this.removeEventListener(type, listener, useCapture);
		}

		public function publish(event:Event):Boolean
		{
			return this.dispatchEvent(event);
		}

		public function MessageEventBusManager()
		{
			if (null != MessageEventBusManager._instance)
			{
				throw new Error("Only one MessageEventBusManager instance hould be instantiated");
			}
		}

		public static function getInstance():MessageEventBusManager
		{
			if (null == _instance)
			{
				_instance=new MessageEventBusManager();
			}
			return _instance;
		}

		public static function clear():void
		{
			_instance=null;
		}
	}
}
