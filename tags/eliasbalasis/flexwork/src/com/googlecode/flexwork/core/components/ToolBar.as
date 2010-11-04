package com.googlecode.flexwork.core.components
{
	import com.googlecode.flexwork.core.events.ToolBarEvent;

	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;

	import mx.controls.Button;
	import mx.controls.ButtonBar;
	import mx.controls.Menu;
	import mx.controls.PopUpMenuButton;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.core.ClassFactory;
	import mx.core.IFlexDisplayObject;
	import mx.core.mx_internal;
	import mx.events.ListEvent;
	import mx.events.MenuEvent;

	use namespace mx_internal;

	[Event(name="click", type="com.googlecode.flexwork.core.events.ToolBarEvent")]

//<!-- http://examples.adobe.com/flex2/exchange/Docker/MultipleToolBars/MultipleToolBars.html -->
//		<!-- //flow layout: http://www.adobe.com/cfusion/exchange/index.cfm?event=extensionDetail&loc=en_us&extid=1229023
//			 //http://examples.adobe.com/flex2/exchange/Docker/MultipleToolBars/MultipleToolBars.html
//			 http://examples.adobe.com/flex2/exchange/Docker/FlowContainerSample/FlowContainerSample.html-->
//
//		<!-- http://code.google.com/p/flexlib/wiki/ComponentList- flowBox
//			 http://flexlib.googlecode.com/svn/trunk/examples/DockingToolBar/MultipleDockingToolBars_Sample.swf -->
	//http://developer.yahoo.com/flash/astra-flash/layout-containers/examples.html
	public class ToolBar extends ButtonBar
	{
		//
		public static const FIELD_TYPE:String="type";

		public static const FIELD_CHILDREN:String="children";

		public static const FIELD_DISPLAY_OBJECT:String="displayObject";

		public static const FIELD_OPEN_ALWAYS:String="openAlways";

		//
		public static const TYPE_VIEW_MENU:String="viewMenu";

		public static const TYPE_DISPLAY_OBJECT:String="displayObject";

		public function ToolBar()
		{
			super();
			/** common */ /** effects */
			this.focusEnabled=false;
			/** events */ /** size */
			this.height=22;
			/** styles */
			this.styleName="toolBar";
			this.setStyle("paddingTop", 0);
			this.setStyle("paddingBottom", 0);
			//this.setStyle("buttonWidth", 23);
			this.setStyle("buttonHeight", 22);
			this.setStyle("horizontalGap", 1);
			this.setStyle("verticalGap", 0);
			//this.setStyle("borderThickness", 0);
			/** other */

			//TODO: borderStyle="solid" 
			navItemFactory=new ClassFactory(IconButton);
			tabChildren=true;
			//			if (this.stage)
			//			{
			//				this.stage.scaleMode=StageScaleMode.NO_SCALE;
			//				this.stage.align=StageAlign.TOP_LEFT;
			//			}
			//			this.setStyle("horizontalGap", 0);
		}

		//http://stackoverflow.com/questions/59196/how-can-i-tab-accross-a-buttonbar-component-in-flex
		//		override protected function createNavItem(label:String, icon:Class=null):IFlexDisplayObject
		//		{
		//			var btn:Button=Button(super.createNavItem(label, icon));
		//			btn.focusEnabled=true;
		//			return btn;
		//		}
		public function getItemChildren(node:Object):*
		{
			var children:*;
			if (node is XML)
			{
				//trace("getChildren", node.toXMLString());
				children=node.*;
			}
			else if (node is Object)
			{
				try
				{
					children=node[FIELD_CHILDREN];
				}
				catch (e:Error)
				{
				}
			}
			return children;
		}

		public function itemToType(data:Object):String
		{
			if (data is XML)
			{
				try
				{
					if (data[FIELD_TYPE].length() != 0)
						data=data[FIELD_TYPE];
				}
				catch (e:Error)
				{
				}
			}
			else if (data is Object)
			{
				try
				{
					if (data[FIELD_TYPE] != null)
						data=data[FIELD_TYPE];
				}
				catch (e:Error)
				{
				}
			}

			if (data is String)
				return String(data);

			if (data is Number)
				return data.toString();

			return "";
		}


		override protected function createNavItem(label:String, icon:Class=null):IFlexDisplayObject
		{
			var newButton:Button=null;
			//
			var n:int=numChildren;
			var item:Object=dataProvider.getItemAt(n);
			var children:*=getItemChildren(item);
			//
//			var iconArrowPopUpMenuButtonStyleName:String=getStyle(iconArrowPopUpMenuButtonStyleNameProp);
//			iconArrowPopUpMenuButtonStyleName=(iconArrowPopUpMenuButtonStyleName) ? iconArrowPopUpMenuButtonStyleName : "iconArrowPopUpMenuButton";
//
//			var arrowPopUpMenuButtonStyleName:String=getStyle(arrowPopUpMenuButtonStyleNameProp);
//			arrowPopUpMenuButtonStyleName=(arrowPopUpMenuButtonStyleName) ? arrowPopUpMenuButtonStyleName : "arrowPopUpMenuButton";
//
//			var buttonStyleName:String=getStyle(buttonStyleNameProp);
//			buttonStyleName=(buttonStyleName) ? buttonStyleName : "iconButton";

			//
			//
			if (itemToType(item) == TYPE_DISPLAY_OBJECT)
			{
				var object:*=item[FIELD_DISPLAY_OBJECT];
				newButton=Button(object);
//				newButton.styleName=(newButton is PopUpMenuButton) ? iconArrowPopUpMenuButtonStyleName : buttonStyleName;
			}
			else
			{
				if (null != children)
				{
					var popUpMenuButton:PopUpMenuButton=null;
					if (itemToType(item) == TYPE_VIEW_MENU)
					{
						popUpMenuButton=new ArrowPopUpMenuButton();
//						popUpMenuButton.styleName=arrowPopUpMenuButtonStyleName;
						//popUpMenuButton.setStyle("icon", null);
						popUpMenuButton.openAlways=true;
						popUpMenuButton.setStyle("arrowButtonWidth", 18);
					}
					else
					{
						popUpMenuButton=new IconArrowPopUpMenuButton();
//						popUpMenuButton.styleName=iconArrowPopUpMenuButtonStyleName;
						IconArrowPopUpMenuButton(popUpMenuButton).iconSet=true;
						popUpMenuButton.setStyle("icon", icon);
						IconArrowPopUpMenuButton(popUpMenuButton).iconSet=false;
						if (item[FIELD_OPEN_ALWAYS] == true)
						{
							popUpMenuButton.openAlways=true;
						}
						else
						{
							popUpMenuButton.addEventListener(MouseEvent.CLICK, onMouseClick);
						}
					}
					popUpMenuButton.addEventListener(MenuEvent.ITEM_CLICK, onMenuItemClick);
					//popUpMenuButton.labelField="@label"
					newButton=Button(popUpMenuButton);

					var childrenEmpty:Boolean=false;
					if (children is Array)
					{
						var array:Array=children as Array;
						if (array.length == 0)
						{
							childrenEmpty=true;
						}
					}
					else if (children is XMLList)
					{
						var xmlList:XMLList=XMLList(children);
						if (xmlList.length() == 0)
						{
							childrenEmpty=true;
						}
					}

					if (!childrenEmpty)
					{
						popUpMenuButton.dataProvider=children;
					}
				}
				else
				{
					var iconButton:IconButton=new IconButton();
//					iconButton.styleName=buttonStyleName;
					iconButton.addEventListener(MouseEvent.CLICK, onMouseClick);
					iconButton.setStyle("icon", icon);
					newButton=Button(iconButton);
				}
			}

			newButton.label=null;
			// Set tabEnabled to false so individual buttons don't get focus.
			newButton.focusEnabled=true;
			addChild(newButton);

			return newButton;
		}

		public static const iconArrowPopUpMenuButtonStyleNameProp:String="iconArrowPopUpMenuButtonStyleName";

		public static const arrowPopUpMenuButtonStyleNameProp:String="arrowPopUpMenuButtonStyleName";

		override public function styleChanged(styleProp:String):void
		{
			var allStyles:Boolean=styleProp == null || styleProp == "styleName";

			if (allStyles || styleProp == buttonStyleNameProp || styleProp == iconArrowPopUpMenuButtonStyleNameProp || styleProp == arrowPopUpMenuButtonStyleNameProp)
			{
				resetNavItems();
			}
			else
			{
				super.styleChanged(styleProp);
			}

		}

		override protected function resetNavItems():void
		{
			var iconArrowPopUpMenuButtonStyleName:String=getStyle(iconArrowPopUpMenuButtonStyleNameProp);
			iconArrowPopUpMenuButtonStyleName=(iconArrowPopUpMenuButtonStyleName) ? iconArrowPopUpMenuButtonStyleName : "iconArrowPopUpMenuButton";

			var arrowPopUpMenuButtonStyleName:String=getStyle(arrowPopUpMenuButtonStyleNameProp);
			arrowPopUpMenuButtonStyleName=(arrowPopUpMenuButtonStyleName) ? arrowPopUpMenuButtonStyleName : "arrowPopUpMenuButton";

			var buttonStyleName:String=getStyle(buttonStyleNameProp);
			buttonStyleName=(buttonStyleName) ? buttonStyleName : "iconButton";

			var n:int=numChildren;
			for (var i:int=0; i < n; i++)
			{
				var button:Button=Button(getChildAt(i));
				var item:Object=dataProvider.getItemAt(i);

				if (button is PopUpMenuButton)
				{
					if (itemToType(item) == TYPE_VIEW_MENU)
					{
						button.styleName=arrowPopUpMenuButtonStyleName;
					}
					else
					{
						button.styleName=iconArrowPopUpMenuButtonStyleName;
					}
				}
				else
				{
					button.styleName=buttonStyleName;
				}
				button.changeSkins();
				button.invalidateDisplayList();
			}
			invalidateDisplayList();
		}

		protected function onMouseClick(event:MouseEvent):void
		{
			var toolBarEvent:ToolBarEvent=new ToolBarEvent(ToolBarEvent.CLICK)
			//			focusedIndex = getChildIndex(DisplayObject(event.currentTarget));
			//		      //TODO:     drawButtonFocus(focusedIndex, true);
			//		    }

			var index:int=getChildIndex(DisplayObject(event.currentTarget));
//			if (targetStack)
//				targetStack.selectedIndex=index;
//
//			selectedIndex=index;

			//var newEvent:ItemClickEvent=new ItemClickEvent(ItemClickEvent.ITEM_CLICK);
			//			toolBarEvent.name=Button(event.currentTarget).label;
			toolBarEvent.buttonIndex=index;
			toolBarEvent.relatedObject=InteractiveObject(event.currentTarget);
			toolBarEvent.item=dataProvider ? dataProvider.getItemAt(index) : null;
			toolBarEvent.name=toolBarEvent.item.name;
			dispatchEvent(toolBarEvent);

			event.stopImmediatePropagation();
		}

		protected function onMenuItemClick(event:MenuEvent):void
		{
			var toolBarEvent:ToolBarEvent=new ToolBarEvent(ToolBarEvent.CLICK)

			//
			//			 var menuEvent:MenuEvent = new MenuEvent(MenuEvent.ITEM_ROLL_OUT);
			var item:IListItemRenderer=ListEvent(event).itemRenderer;
			var menu:Menu=event.menu;

			var owner:Object=menu.owner;
			//	toolBarEvent.menu=event.menu;
			var index:int=getChildIndex(DisplayObject(owner));
			toolBarEvent.buttonIndex=index;
			toolBarEvent.name=event.item.name;
			//toolBarEvent.menuBar=sourceMenuBar;
			//toolBarEvent.label=event.menu.itemToLabel(item.data);
			//toolBarEvent.item=item.data;
			//toolBarEvent.itemRenderer=item;

			dispatchEvent(toolBarEvent); //getRootMenu().dispatchEvent(menuEvent);
			event.stopImmediatePropagation();
		}
	}
}