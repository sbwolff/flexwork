package com.googlecode.flexwork.work.menus
{
	import mx.events.MenuEvent;

	public class ProjectMenuProvider extends AbstractMenuProvider
	{

		public function ProjectMenuProvider()
		{
			super();
		}

		override public function appendMenuItem(root:Object):void
		{

			var menuItems:Object={label: "Project", //
					children: [ //
					{label: "Open Project", listener: onMenuItemClick}, //
						{label: "Close Project", listener: onMenuItemClick}, //
						{type: "separator"}, //
						{label: "Build All", icon: "documentIconClass", listener: onMenuItemClick}, //
						{label: "Build Project", listener: onMenuItemClick}, //
						{label: "Build Working Set...", //
							children: [ //
							{label: "Select Working Set...", listener: onMenuItemClick} //
							] //
						}, //				
						{label: "Clean", listener: onMenuItemClick}, //	
						{label: "Build Automatically", type:"check", toggled:true, listener: onMenuItemClick}, //		
						{type: "separator"}, //
						{label: "Convert to a Dynamic Web Project...", listener: onMenuItemClick}, //
						{label: "Export Release Build...", listener: onMenuItemClick}, //						
						{type: "separator"}, //
						{label: "Properties", listener: onMenuItemClick} //					
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
