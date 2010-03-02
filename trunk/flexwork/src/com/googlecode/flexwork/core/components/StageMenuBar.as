package com.googlecode.flexwork.core.components
{
	import com.googlecode.flexwork.work.menus.MenuBarProvider;
	
	import mx.controls.Label;
	import mx.controls.Menu;
	import mx.controls.MenuBar;
	import mx.events.FlexEvent;
	import mx.events.MenuEvent;

//<!-- mx:XML id="menuBarDataProvider">
//		 <xml />
//		 </mx:XML>
//		 <mx:XMLList id="menuBarDataProvider">
//		 <menuItem label="File">
//		 <menuItem label="New" icon="documentIconClass"/>
//		 <menuItem label="Open..." icon="documentIconClass"/>
//		 <menuItem type="separator"/>
//		 <menuItem label="Close"/>
//		 
//
//		 labelFunction="menuBarLabelFunction"
// 
//	-->



	//	variableRowHeight menubar
	//		 http://www.nabble.com/How-to-set-variableRowHeight-%3D-true-in-MenuBar-td20790140.html
	//		 //method 1
	//		 private function onMenuBarInitialize():void {
	//		 var menu:Menu;
	//		 for (var i:int = 0; i < menuBar.menus.length; i++) {
	//		 menu = menuBar.menus[i];
	//		 menu.variableRowHeight = true;
	//		 }
	//		 }
	//
	//		 //method 2
	//		 private function onMenuShow(event:MenuEvent):void {
	//		 var t:MenuBar = event.currentTarget as MenuBar;
	//		 event.menu.variableRowHeight = true;
	//		 }

	//<mx:MenuBar id="menuBar" width="100%" showRoot="false" labelField="label" iconField="icon"
	//				creationComplete="//onMenuBarInitialize()" initialize="//onMenuBarInitialize()"
	//				styleName="menuBar" itemClick="onMenuBarItemClick(event)"
	//				menuShow="onMenuBarMenuShow(event)" dataProvider="{menuBarDataProvider}">
	//
	//	</mx:MenuBar>
	public class StageMenuBar extends MenuBar
	{
		public var menuBarProvider:MenuBarProvider;

		public function StageMenuBar()
		{
			this.percentWidth=100;
			this.showRoot=false;
			this.labelField="label";
			this.iconField="icon";
			this.styleName="stageMenuBar";
		
			this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
			this.addEventListener(MenuEvent.ITEM_CLICK, onMenuBarItemClick);
		}
		override public function getMenuAt(index:int):Menu
    	{
    		var menu:Menu = super.getMenuAt(index);
    		menu.variableRowHeight = true;
			//TODO: menu.setStyle("backgroundAlpha", 0.5);
			//menu.setStyle("backgroundColor", 0xFF0000);
    		return menu; 
    	}

		private function onCreationComplete(event:FlexEvent):void
		{
						
		}
		
		private var welcomeLabel:Label;
		
		override protected function createChildren():void		
		{
			super.createChildren();
			
//			if(null==welcomeLabel) {
//				welcomeLabel = new Label();
//				welcomeLabel.text = "Welcome: ${userName}";
//				this.addChild(welcomeLabel);
//			}
		}
		
		private function onMenuBarItemClick(event:MenuEvent):void
		{
			this.menuBarProvider.onMenuItemClick(event);
			//				this.menuProvider.onMenuItemClick(event);
			//important: menuItem = e.menu.dataProvider.source.(@data=='Cut');
			//				this.debug("MenuBar");
			//				this.debug(" event.currentTarget=" + event.currentTarget);
			//				this.debug(" event.target=" + event.target);
			//				this.debug(" event.label=" + event.label);
			//				this.debug(" event.index=" + event.index);
			//				var a:*=event.item.parent;				
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
			//             	addView();
			//            }
			//            }
			//            else if (event.label == "AddView") {
			//            	addView();
			//            }
			//            else if (event.label == "Focus") {
			//            	this.focusManager.setFocus(consoleView);
			//            }

		}
		//			public function  menuBarLabelFunction(item:Object):String {
			//				return item.label+"_11" +item["parent"];// item["listener"];
			//			}
	}
}