package com.googlecode.flexwork.work.menus
{
	import mx.events.MenuEvent;

	public class SearchMenuProvider extends AbstractMenuProvider
	{

		public function SearchMenuProvider()
		{
			super();
		}

		override public function appendMenuItem(root:Object):void
		{

			var menuItems:Object={label: "Search", //
					children: [ //
					{label: "Search", icon: "documentIconClass", listener: onMenuItemClick}, //
						{label: "File", icon: "documentIconClass", listener: onMenuItemClick}, //
						{label: "Remote", icon: "documentIconClass", listener: onMenuItemClick}, //			
						{type: "separator"}, //
						{label: "Declarations", //
							children: [ //
							{label: "File", listener: onMenuItemClick}, //	
								{label: "Project", listener: onMenuItemClick}, //	
								{label: "Workspace", listener: onMenuItemClick} //	
							] //
						}, //
						{label: "References", //
							children: [ //
							{label: "File", listener: onMenuItemClick}, //	
								{label: "Project", listener: onMenuItemClick}, //	
								{label: "Workspace", listener: onMenuItemClick} //	
							] //
						}, //
						{label: "Text", //
							children: [ //
							{label: "Workspace", listener: onMenuItemClick}, //							
								{label: "Project", listener: onMenuItemClick}, //	
								{label: "File", listener: onMenuItemClick}, //	
								{label: "Working Set...", listener: onMenuItemClick} //	
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
