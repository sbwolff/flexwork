package com.googlecode.flexwork.work.menus
{
	import mx.events.MenuEvent;

	public class FileMenuProvider extends AbstractMenuProvider
	{

		public function FileMenuProvider()
		{
			super();
		}

		override public function appendMenuItem(root:Object):void
		{
			//			var menuItems:XML= <menuItem label="File" icon="documentIconClass">
			//					<menuItem label="New" icon="documentIconClass">						
			//					</menuItem>
			//					<menuItem label="Open..." icon="documentIconClass"/>
			//					<menuItem type="separator"/>
			//					<menuItem label="Close"/>
			//					<menuItem type="separator"/>
			//					<menuItem label="Save"/>
			//					<menuItem label="Save as..."/>
			//					<menuItem type="separator"/>
			//					<menuItem label="Import..."/>
			//					<menuItem label="Export..."/>
			//					<menuItem type="separator"/>
			//					<menuItem label="Exit"/>
			//				</menuItem>;

			var menuItems:Object={label: "File", keyEquivalent: "F", altKey: true, //
					children: [{label: "New", icon: "iconDocumentClass", listener: onMenuItemClick}, //
						{label: "Open", icon: "iconDocumentClass", listener: onMenuItemClick}, //						
						{type: "separator"}, //
						{label: "Close", listener: onMenuItemClick}, //
						{type: "separator"}, //
						{label: "Save", listener: onMenuItemClick}, //
						{label: "Save as...", listener: onMenuItemClick}, //
						{type: "separator"}, //
						{label: "Import...", listener: onMenuItemClick}, //
						{label: "Export...", listener: onMenuItemClick}, //
						{type: "separator"}, //
						{label: "Exit", listener: onMenuItemClick} //
					] //
				};

			root.children.push(menuItems);
		}
		//
		//		override public function onMenuItemClick(event:MenuEvent):void
		//		{
		//			this.debug(this.toString()+" "+event.label);
		//		}


	}
}