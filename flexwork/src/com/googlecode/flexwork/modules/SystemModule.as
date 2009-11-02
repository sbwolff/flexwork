package com.googlecode.flexwork.modules
{
	import com.googlecode.flexwork.events.IMessageEventBusManager;
	import com.googlecode.flexwork.managers.ILogManager;
	import com.googlecode.flexwork.managers.IModelManager;
	import com.googlecode.flexwork.managers.IThreadManager;

	import flash.events.Event;

	/**
	 *
	 */
	public class SystemModule implements ISystemModule
	{

		public var logManager:ILogManager=null;

		public var modelManager:IModelManager=null;

		public var threadManager:IThreadManager=null;

		public var messageEventBusManager:IMessageEventBusManager=null;

		public function SystemModule()
		{
		}

		public function error(message:String):void
		{
			logManager.error(message);
		}

		public function info(message:String):void
		{
			logManager.info(message);
		}

		public function debug(message:String):void
		{
			logManager.debug(message);
		}

		public function subscribe(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			messageEventBusManager.subscribe(type, listener, useCapture, priority, useWeakReference);
		}

		public function unsubscribe(type:String, listener:Function, useCapture:Boolean=false):void
		{
			messageEventBusManager.unsubscribe(type, listener, useCapture);
		}

		public function publish(event:Event):Boolean
		{
			return messageEventBusManager.publish(event);
		}

		//		//setter/getter
		//		public function set messageEventBusManager(value:IMessageEventBusManager):void
		//		{
		//			this._messageEventBusManager=value;
		//		}
		//
		//		public function get messageEventBusManager():IMessageEventBusManager
		//		{
		//			return this._messageEventBusManager;
		//		}
		//
		//		public function set threadManager(value:IThreadManager):void
		//		{
		//			this._threadManager=value;
		//		}
		//
		//		public function get threadManager():IThreadManager
		//		{
		//			return this._threadManager;
		//		}
		//
		//		public function set modelManager(value:IModelManager):void
		//		{
		//			this._modelManager=value;
		//		}
		//
		//		public function get modelManager():IModelManager
		//		{
		//			return this._modelManager;
		//		}
		//
		//		public function set logManager(value:ILogManager):void
		//		{
		//			this._logManager=value;
		//		}
		//
		//		public function get logManager():ILogManager
		//		{
		//			return this._logManager;
		//		}
	}
}