package com.googlecode.flexwork.modules
{
	import com.googlecode.flexwork.managers.ILogManager;
	import com.googlecode.flexwork.managers.IModelManager;
	import com.googlecode.flexwork.managers.IThreadManager;
	import com.googlecode.flexwork.events.IMessageEventBusManager;

	/**
	 *
	 */
	public interface ISystemModule extends IMessageEventBusManager, ILogManager, IModelManager, IThreadManager
	{

	}
}