package com.googlecode.flexwork.managers
{

	public interface ILogOutputTarget
	{
		function error(message:String):void

		function info(message:String):void

		function debug(message:String):void
	}
}