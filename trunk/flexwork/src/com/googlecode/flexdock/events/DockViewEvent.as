package com.googlecode.flexdock.events
{

	import com.googlecode.flexdock.components.ViewTab;
	import com.googlecode.flexdock.components.ViewWindow;

	import flash.events.Event;

	/**
	 *
	 */
	public class DockViewEvent extends Event
	{

		// prefix
		private static const PREFIX:String="view.";

		//
		public static const ADDING:String=PREFIX + "adding";

		public static const ADDED:String=PREFIX + "added";

		public static const REMOVING:String=PREFIX + "removing";

		public static const REMOVED:String=PREFIX + "removed";

		public static const CLOSING:String=PREFIX + "closing";

		public static const CLOSED:String=PREFIX + "closed";
		//
		//		public static const SELECTING:String=PREFIX + "selecting";
		//
		//		public static const SELECTED:String=PREFIX + "selected";
		//
		//		public static const DESELECTING:String=PREFIX + "deselecting";
		//
		//		public static const DESELECTED:String=PREFIX + "deselected";
		//
		public static const FOCUSING:String=PREFIX + "focusing";

		public static const FOCUSED:String=PREFIX + "focused";

		//blur
		public static const UNFOCUSING:String=PREFIX + "unfocusing";

		public static const UNFOCUSED:String=PREFIX + "unfocused";

		//
		public static const DOCKING:String=PREFIX + "docking";

		public static const DOCKED:String=PREFIX + "docked";

		//		public static const UNDOCKING:String=PREFIX + "undocking";
		//
		//		public static const UNDOCKED:String=PREFIX + "undocked";

		//
		public static const MINIMIZE:String=PREFIX + "minimize";

		public static const MAXIMIZE:String=PREFIX + "maximize";

		public static const RESTORE:String=PREFIX + "restore";

		//		public static const MINIMIZED:String=PREFIX + "minimized";

		//		public static const MAXIMIZED:String=PREFIX + "maximized";

		//		public static const RESTORED:String=PREFIX + "restored";

		/**
		 *
		 */
		private var _viewTab:ViewTab=null;

		/**
		 *
		 */
		private var _viewWindow:ViewWindow=null;

		/**
		 * Constructor
		 */
		public function DockViewEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}

		/**
		 *
		 */
		override public function clone():Event
		{
			return new DockViewEvent(type, bubbles, cancelable);
		}

		/**
		 *
		 */
		public function get viewTab():ViewTab
		{
			return this._viewTab;
		}

		/**
		 *
		 */
		public function set viewTab(value:ViewTab):void
		{
			this._viewTab=value;
		}

		/**
		 *
		 */
		public function get viewWindow():ViewWindow
		{
			return this._viewWindow;
		}

		/**
		 *
		 */
		public function set viewWindow(value:ViewWindow):void
		{
			this._viewWindow=value;
		}

	}
}
