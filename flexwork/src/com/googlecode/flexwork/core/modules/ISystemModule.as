package com.googlecode.flexwork.core.modules
{
	import com.googlecode.flexwork.core.managers.IMessageEventBusManager;
	import com.googlecode.flexwork.core.managers.ILogManager;
	import com.googlecode.flexwork.core.managers.IModelManager;
	import com.googlecode.flexwork.core.managers.IThreadManager;

	/**
	 *
	 */
	public interface ISystemModule extends IMessageEventBusManager, ILogManager, IModelManager, IThreadManager
	{

	}
}