package com.googlecode.flexwork.core.managers
{

	public class LogManager implements ILogManager
	{
		private var _logOutputTarget:ILogOutputTarget=null;

		public function LogManager()
		{
			
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