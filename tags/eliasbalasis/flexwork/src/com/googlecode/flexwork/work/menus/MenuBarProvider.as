package com.googlecode.flexwork.work.menus
{
	import mx.events.MenuEvent;
//TODO:disable/enable menuitem 
				//:http://www.mslinn.com/blog/?p=121 
				//				ewMenu[0].subMenuItem[2].@enabled = true;
				//ewMenu.subMenuItem.(@eventName=="configSave").@enabled = true;
				
//				var menuItem:XML = menuBarDataProvider[8].menuItem.(hasOwnProperty("@label")&& @label=="Open Perspective")[0];			
				//			menuItem.menuItem+= <menuItem label="111File System" type="check"/>;
	public class MenuBarProvider extends AbstractMenuProvider
	{
		public var fileMenuProvider:IMenuProvider;

		public var editMenuProvider:IMenuProvider;

		public var sourceMenuProvider:IMenuProvider;

		public var navigateMenuProvider:IMenuProvider;

		public var searchMenuProvider:IMenuProvider;

		public var projectMenuProvider:IMenuProvider;

		public var dataMenuProvider:IMenuProvider;

		public var runMenuProvider:IMenuProvider;

		public var windowMenuProvider:IMenuProvider;

		public var helpMenuProvider:IMenuProvider;


		public function MenuBarProvider()
		{
			super();
		}

		override public function appendMenuItem(root:Object):void
		{
			fileMenuProvider.appendMenuItem(root);
			editMenuProvider.appendMenuItem(root);
			sourceMenuProvider.appendMenuItem(root);
			navigateMenuProvider.appendMenuItem(root);
			searchMenuProvider.appendMenuItem(root);
			projectMenuProvider.appendMenuItem(root);
			dataMenuProvider.appendMenuItem(root);
			runMenuProvider.appendMenuItem(root);
			windowMenuProvider.appendMenuItem(root);
			helpMenuProvider.appendMenuItem(root);
		}

		private function retrieveListenerFunction(item:Object):Function
		{
			if (null != item)
			{
				if (item[LISTENER] == "undefined")
				{
					//return retrieveListenerFunction(item.parent);
				}
				else
				{
					return item[LISTENER];
				}
			}
			return null;
		}

		override public function onMenuItemClick(event:MenuEvent):void
		{
			var fun:Function=retrieveListenerFunction(event.item);
			if (null != fun)
			{
				fun(event);
			}
			//			
			//			this.debug("MenuBar");
			//				this.debug(" event.currentTarget=" + event.currentTarget);
			//				this.debug(" event.target=" + event.target);
			//				this.debug(" event.label=" + event.label);
			//				this.debug(" event.index=" + event.index);
			//					
			//				this.debug(" event.item=" + event.item.valueOf().toString());
			//				var a:*=event.itemRenderer;
			//				var b:*=event.itemRenderer.data;	
			////				var c:*=event.itemRenderer.data.parent[LISTENER];			
			//				this.debug(" event.itemRenderer=" + event.itemRenderer);
			//				this.debug(" event.menu" + event.menu.toString());
			//				
			//			Alert.show(event+"");
			//				switch (event.item)
			//				{
			//					case "Preferences":
			//					{
			//						var preferenceWindow:PreferenceWindow=new PreferenceWindow();
			//						PopUpManager.addPopUp(preferenceWindow, this, false);
			//						break;
			//					}
			//					case "Login":
			//					{
			//						showLogin();
			//						break;
			//					}
			//				}
		}

	}
}