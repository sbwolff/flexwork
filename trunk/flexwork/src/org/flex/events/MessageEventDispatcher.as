package org.flex.events
{

	import flash.events.EventDispatcher;

	/**
	 * MessageEventDispatcher.getInstance().addEventListener(LoginEvent.EVENT_TYPE, this.someFunction);
	 * MessageEventDispatcher.getInstance().dispatchEvent(new LoginEvent(LoginEvent.EVENT_TYPE, param));
	 */
	public class MessageEventDispatcher extends EventDispatcher
	{

		private static var _instance:MessageEventDispatcher;

		public function MessageEventDispatcher()
		{
			if (MessageEventDispatcher._instance != null)
			{
				throw new Error("Only one MessageEventDispatcher instance hould be instantiated");
			}
		}

		public static function getInstance():MessageEventDispatcher
		{
			if (_instance == null)
			{
				_instance=new MessageEventDispatcher();
			}
			return _instance;
		}

		public static function clear():void
		{
			_instance=null;
		}
	}
}
