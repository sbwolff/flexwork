package com.googlecode.flexwork.work.menus
{
	import mx.events.MenuEvent;

	public class NavigateMenuProvider extends AbstractMenuProvider
	{

		public function NavigateMenuProvider()
		{
			super();
		}

		override public function appendMenuItem(root:Object):void
		{

			var menuItems:Object={label: "Navigate", //
					children: [ //
					{label: "Go Into", icon: "documentIconClass", listener: onMenuItemClick}, //
						{label: "Go To", //
							children: [ //
							{label: "Back", listener: onMenuItemClick}, //
								{label: "Forward", listener: onMenuItemClick}, //							
								{label: "Up One Level", listener: onMenuItemClick}, //
								{type: "separator"}, //				
								{label: "Resource", icon: "documentIconClass", listener: onMenuItemClick} //
							] //
						}, //						
						{type: "separator"}, //
						{label: "Go to Definition", listener: onMenuItemClick}, //
						{label: "Quick Outline", listener: onMenuItemClick}, //
						{type: "separator"}, //
						{label: "Open Type...", listener: onMenuItemClick}, //
						{label: "Open Resource...", listener: onMenuItemClick}, //
						{type: "separator"}, //
						{label: "Open Task...", icon: "documentIconClass", listener: onMenuItemClick}, //
						{label: "Activate Task...", icon: "documentIconClass", listener: onMenuItemClick}, //
						{label: "Deactivate Task...", icon: "documentIconClass", listener: onMenuItemClick}, //
						{type: "separator"}, //
						{label: "Show In", listener: onMenuItemClick}, //
						{label: "Quick Context View", listener: onMenuItemClick}, //
						{type: "separator"}, //
						{label: "Next Annotation", icon: "documentIconClass", listener: onMenuItemClick}, //
						{label: "Previous Annotation", icon: "documentIconClass", listener: onMenuItemClick}, //
						{type: "separator"}, //
						{label: "Last Edit Location", icon: "documentIconClass", listener: onMenuItemClick}, //
						{label: "Go to Line...", listener: onMenuItemClick}, //
						{type: "separator"}, //
						{label: "Back", icon: "documentIconClass", listener: onMenuItemClick}, //
						{label: "Forward", icon: "documentIconClass", listener: onMenuItemClick} //						
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
