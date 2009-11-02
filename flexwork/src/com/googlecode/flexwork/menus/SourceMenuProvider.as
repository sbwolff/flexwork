package com.googlecode.flexwork.menus
{
	import mx.events.MenuEvent;

	public class SourceMenuProvider extends AbstractMenuProvider
	{

		public function SourceMenuProvider()
		{
			super();
		}

		override public function appendMenuItem(root:Object):void
		{

			var menuItems:Object={label: "Source", //
					children: [ //
					{label: "Shift Right", icon: "documentIconClass", listener: onMenuItemClick}, //
						{label: "Shift Left", icon: "documentIconClass", listener: onMenuItemClick}, //						
						{type: "separator"}, //
						{label: "Toggle Comment", listener: onMenuItemClick}, //
						{label: "Toggle Block Comment", listener: onMenuItemClick}, //
						{label: "Add ASDoc Comment", listener: onMenuItemClick}, //
						{type: "separator"}, //
						{label: "Organize Imports", listener: onMenuItemClick}, //
						{type: "separator"}, //
						{label: "Refactor", //
							children: [ //
							{label: "Rename", listener: onMenuItemClick} //
							] //
						} //
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