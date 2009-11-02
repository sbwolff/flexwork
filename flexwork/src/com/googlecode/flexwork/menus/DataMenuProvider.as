package com.googlecode.flexwork.menus
{
	import mx.events.MenuEvent;

	public class DataMenuProvider extends AbstractMenuProvider
	{

		public function DataMenuProvider()
		{
			super();
		}

		override public function appendMenuItem(root:Object):void
		{

			var menuItems:Object={label: "Data", //
					children: [ //
					{label: "Create Application From Database...", icon: "documentIconClass", listener: onMenuItemClick}, //
						{type: "separator"}, //
						{label: "Import Web Service (WSDL)...", icon: "documentIconClass", listener: onMenuItemClick}, //
						{label: "Manage Web Services", listener: onMenuItemClick} //					
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

