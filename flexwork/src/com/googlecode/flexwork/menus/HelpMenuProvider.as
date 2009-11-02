package com.googlecode.flexwork.menus
{
	import flash.events.Event;
	
	import mx.events.MenuEvent;

	public class HelpMenuProvider extends AbstractMenuProvider
	{

		public function HelpMenuProvider()
		{
			super();
		}

		override public function appendMenuItem(root:Object):void
		{

			var menuItems:Object={label: "Help", //
					children: [ //
					{label: "Welcome", icon: "documentIconClass", listener: onWelcome}, //

						{type: "separator"}, //
						{label: "Help Contents", listener: onMenuItemClick} //						
					] //
				};

			root.children.push(menuItems);

		}

		public function onWelcome(event:MenuEvent):void
		{
//			var loginWindow:IFlexDisplayObject=PopUpManager.createPopUp(null, LoginWindow, true);
//			PopUpManager.centerPopUp(loginWindow);
			this.publish(new Event("menuItem:Login"));
		}
		//		override public function onMenuItemClick(event:MenuEvent):void
		//		{
		//			this.debug(this.toString()+" "+event.label);
		//		}


	}
}
