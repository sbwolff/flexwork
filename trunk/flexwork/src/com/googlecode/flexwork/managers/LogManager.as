package com.googlecode.flexwork.managers
{

	import flash.events.*;

	import mx.binding.utils.*;
	import mx.containers.*;
	import mx.controls.*;
	import mx.core.*;
	import mx.events.*;

	import com.googlecode.flexdock.views.DockView

	public class LogManager implements ILogManager
	{
		private var _logOutputTarget:ILogOutputTarget=null;

		public function LogManager()
		{
			//this.icon = iconClass;
			//this.label = "Console";
			//this.setStyle("verticalGap", 0);
		}

		public function logError(message:String):void
		{
			_logOutputTarget.logError(message);
		}

		public function logInfo(message:String):void
		{
			_logOutputTarget.logInfo(message);
		}

		public function logDebug(message:String):void
		{
			_logOutputTarget.logDebug(message);
		}

		public function set logOutputTarget(value:ILogOutputTarget):void
		{
			this._logOutputTarget=value;
		}

		public function get logOutputTarget():ILogOutputTarget
		{
			return this._logOutputTarget;
		}
	}
}