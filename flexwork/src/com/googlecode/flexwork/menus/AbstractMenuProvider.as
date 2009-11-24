package com.googlecode.flexwork.menus
{
	import com.googlecode.flexwork.modules.SystemModule;

	import mx.events.MenuEvent;

	import org.springextensions.actionscript.ioc.factory.IInitializingObject;
	
	/**
	 * 
	 */	
	public class AbstractMenuProvider extends SystemModule implements IMenuProvider, IInitializingObject
	{
		public static const LISTENER:String="listener";

		public function AbstractMenuProvider()
		{

		}

		public function appendMenuItem(root:Object):void
		{

		}

		public function onMenuItemClick(event:MenuEvent):void
		{
			this.logDebug(this + " event.label=" + event.label + " event.item.listener" + event.item.listener);
			//				this.debug("MenuBar");
			//				this.debug(" event.currentTarget=" + event.currentTarget);
			//				this.debug(" event.target=" + event.target);
			//				this.debug(" event.label=" + event.label);
			//				this.debug(" event.index=" + event.index);
			////				var a:*=event.item.parent;				
			//				this.debug(" event.item=" + event.item.valueOf().toString());
			//				this.debug(" event.menu" + event.menu.toString());
			//				
			//				//			Alert.show(event+"");
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

		public function afterPropertiesSet():void
		{
			
		}


	}
}