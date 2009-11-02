package com.googlecode.flexwork.menus
{
	import com.googlecode.flexwork.events.MessageEvent;
	
	import flash.events.Event;
	
	import mx.events.MenuEvent;

	public class WindowMenuProvider extends AbstractMenuProvider
	{

		public var perspectiveMenuProvider:IMenuProvider;

		public function WindowMenuProvider()
		{
			super();
		}

		override public function appendMenuItem(parent:Object):void
		{

			var menuItems:Object={label: "Window", //
					children: [ //
					{label: "New Window", listener: onMenuItemClick}, //
						{label: "New Editor", listener: onMenuItemClick},  //
						{type: "separator"}//
					//						{label: "Open Prespective...", //
					//							children: [ //
					//							{label: "Java", icon: "documentIconClass", listener: onMenuItemClick}, //
					//								{label: "Flex", icon: "documentIconClass", listener: onMenuItemClick}, //							
					//								{label: "CVS", icon: "documentIconClass", listener: onMenuItemClick}, //
					//								{type: "separator"}, //				
					//								{label: "Other", listener: onMenuItemClick} //
					//							] //
					//						}, //
					//						{label: "Open View...", //
					//							children: [ //
					//							{label: "Console", icon: "documentIconClass", listener: onMenuItemClick}, //
					//								{label: "Explorer", icon: "documentIconClass", listener: onMenuItemClick}, //							
					//								{label: "Outlines", icon: "documentIconClass", listener: onMenuItemClick}, //
					//								{type: "separator"}, //				
					//								{label: "Other", listener: onMenuItemClick} //
					//							] //
					//						}, //						
					//						{type: "separator"}, //
					//						{label: "Customize Prespective...", listener: onMenuItemClick}, //
					//						{label: "Save Prespective As...", listener: onMenuItemClick}, //
					//						{label: "Reset Prespective...", listener: onMenuItemClick}, //
					//						{label: "Close Prespective", listener: onMenuItemClick}, //
					//						{label: "Close All Prespectives", listener: onMenuItemClick}, //
					//						{type: "separator"}, //
					//						{label: "Navigation", //
					//							children: [ //
					//							{label: "Activate Editor", icon: "documentIconClass", listener: onMenuItemClick}, //
					//								{label: "Next Editor", icon: "documentIconClass", listener: onMenuItemClick}, //							
					//								{label: "Previous Editor", icon: "documentIconClass", listener: onMenuItemClick} //
					//							] //
					//						}, //
					//						{label: "Switch Source/Design Mode", listener: onMenuItemClick}, //						
					//						{label: "Preferences", icon: "documentIconClass", listener: onPreferences} //					
					] //
				};
			perspectiveMenuProvider.appendMenuItem(menuItems);			
			menuItems.children.push({type: "separator"}); //
			menuItems.children.push({label: "Preferences", icon:"iconPreferenceClass", listener: onPreferences}); //
			parent.children.push(menuItems);
		}

		public function onPreferences(event:MenuEvent):void
		{
			//			var loginWindow:IFlexDisplayObject=PopUpManager.createPopUp(null, LoginWindow, true);
			//			PopUpManager.centerPopUp(loginWindow);
			this.publish(new MessageEvent("menuItem:Preferences"));
		}

		//		override public function onMenuItemClick(event:MenuEvent):void
		//		{
		//			this.debug(this.toString()+" "+event.label);
		//		}


	}
}
