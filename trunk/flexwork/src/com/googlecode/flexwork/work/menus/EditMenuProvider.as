package com.googlecode.flexwork.work.menus
{
	import mx.events.MenuEvent;

	public class EditMenuProvider extends AbstractMenuProvider
	{


		public function EditMenuProvider()
		{
			super();
		}

		override public function appendMenuItem(root:Object):void
		{
			//			var menuItems:XML=<menuItem label="Edit">
			//					<menuItem label="Cut"/>
			//					<menuItem label="Copy"/>
			//					<menuItem label="Paste"/>
			//					<menuItem type="separator"/>
			//					<menuItem label="Select All"/>
			//					<menuItem type="separator"/>
			//					<menuItem label="Find"/>
			//				</menuItem>;
			var menuItems:Object={label: "Edit", //
					children: [{label: "Cut", listener: onMenuItemClick}, //
						{label: "Copy", listener: onMenuItemClick}, //
						{label: "Paste", listener: onMenuItemClick}, //
						{type: "separator", listener: onMenuItemClick}, //
						{label: "Select All", listener: onMenuItemClick}, //
						{type: "separator", listener: onMenuItemClick}, //
						{label: "Find", listener: onMenuItemClick} //
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