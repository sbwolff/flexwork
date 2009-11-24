package com.googlecode.flexdock.components
{
	import com.googlecode.flexwork.modules.ISystemModule
	
	import flash.events.Event;
	
	import mx.containers.Box;
	
	/** 
	 * 
	 */
	public class BoxSystemModule extends Box implements ISystemModule
	{
		/** 
		 * delegate
		 */
		[Bindable]
		public var systemModule:ISystemModule=null;
		
		/** 
		 * 
		 */
		public function BoxSystemModule()
		{
		}

		public function logError(message:String):void
		{
			systemModule.logError(message);
		}

		public function logInfo(message:String):void
		{
			systemModule.logInfo(message);
		}

		public function logDebug(message:String):void
		{
			systemModule.logDebug(message);
		}

		public function subscribe(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			systemModule.subscribe(type, listener, useCapture, priority, useWeakReference);
		}

		public function unsubscribe(type:String, listener:Function, useCapture:Boolean=false):void
		{
			systemModule.unsubscribe(type, listener, useCapture);
		}

		public function publish(event:Event):Boolean
		{
			return systemModule.publish(event);
		}
		
		public function getModel(name:String):* 
		{
			return systemModule.getModel(name);
		}
//		//setter/getter
//		public function set module(value:IUnit):void
//		{
//			this._module=value;
//		}
//
//		public function get module():IUnit
//		{
//			return this._module;
//		}
	}
}