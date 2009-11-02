package com.googlecode.flexwork.menus
{
	import mx.events.MenuEvent;

	public class RunMenuProvider extends AbstractMenuProvider
	{

		public function RunMenuProvider()
		{
			super();
		}

		override public function appendMenuItem(root:Object):void
		{

			var menuItems:Object={label: "Run", //
					children: [ //
					{label: "Run", icon: "documentIconClass", listener: onMenuItemClick}, //
						{label: "Debug", icon: "documentIconClass", listener: onMenuItemClick}, //
						{label: "Profile", icon: "documentIconClass", listener: onMenuItemClick} //						
					] //
				};

			root.children.push(menuItems);
		}

		//		override public function onMenuItemClick(event:MenuEvent):void
		//		{
		//			this.debug(this.toString()+" "+event.label);
		//		}


	}
}
