package com.googlecode.flexwork.core.managers
{

	public interface ILogOutputTarget
	{
		function logError(message:String):void

		function logInfo(message:String):void

		function logDebug(message:String):void
	}
}