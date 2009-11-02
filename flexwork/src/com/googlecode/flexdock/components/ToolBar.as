package com.googlecode.flexdock.components
{
	import com.googlecode.flexdock.events.ToolBarEvent;
	
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	
	import mx.controls.Button;
	import mx.controls.ButtonBar;
	import mx.controls.Menu;
	import mx.controls.PopUpButton;
	import mx.controls.PopUpMenuButton;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.core.ClassFactory;
	import mx.core.IFlexDisplayObject;
	import mx.core.mx_internal;
	import mx.events.ListEvent;
	import mx.events.MenuEvent;
	
	use namespace mx_internal;

	[Event(name="click",type="com.googlecode.flexdock.events.ToolBarEvent")]
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
		private static const WIDTH_BUTTON:Number=23;

		private static const WIDTH_POPUP_MENU_BUTTON:Number=34;

		private static const WIDTH_VIEW_MENU_BUTTON:Number=18;

		//
		public static const FIELD_TYPE:String="type";

		public static const FIELD_CHILDREN:String="children";

		public static const FIELD_DISPLAY_OBJECT:String="displayObject";

		public static const FIELD_OPEN_ALWAYS:String="openAlways";

		//
		public static const TYPE_VIEW_MENU:String="viewMenu";

		public static const TYPE_DISPLAY_OBJECT:String="displayObject";

		//
		mx_internal var popUpMenuButtonStyleNameProp:String="popUpMenuButtonStyleName";

		mx_internal var popUpViewMenuButtonStyleNameProp:String="popUpViewMenuButtonStyleName";

		public function ToolBar()
		{
			super();
			this.focusEnabled=false;
			this.styleName="toolBar";
			//this.setStyle("borderThickness", 0);
			this.height=22;
			this.setStyle("paddingTop", 0);
			this.setStyle("paddingBottom", 0);
			//this.setStyle("buttonWidth", 23);
			this.setStyle("buttonHeight", 22);
			this.setStyle("horizontalGap", 1);
			this.setStyle("verticalGap", 0);
			//TODO: borderStyle="solid" 
			navItemFactory=new ClassFactory(ToolBarButton); //never use
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


			var popUpViewMenuButtonStyleName:String=getStyle(popUpViewMenuButtonStyleNameProp);
			if (!popUpViewMenuButtonStyleName)
			{
				popUpViewMenuButtonStyleName="PopUpButtonSkin";
			}

			var popUpMenuButtonStyleName:String=getStyle(popUpMenuButtonStyleNameProp);
			if (!popUpMenuButtonStyleName)
			{
				popUpMenuButtonStyleName="PopUpButtonSkin";
			}

			var buttonStyleName:String=getStyle(buttonStyleNameProp);
			if (!buttonStyleName)
			{
				buttonStyleName="PopUpButtonSkin";
			}
			
			//
			//
			if (itemToType(item) == TYPE_DISPLAY_OBJECT)
			{
				var object:*=item[FIELD_DISPLAY_OBJECT];
				newButton=Button(object);

				if (newButton is PopUpButton)
				{
					newButton.width=WIDTH_POPUP_MENU_BUTTON;
					newButton.styleName=popUpMenuButtonStyleName;
						//
						//Menu(PopUpButton(newButton).popUp).variableRowHeight=true;
				}
				else
				{
					newButton.width=WIDTH_BUTTON;
					newButton.styleName=buttonStyleName;
				}
			}
			else
			{

				if (null != children)
				{

					//					viewMenu=Menu.createMenu(null, children, true);
					//					viewMenu.addEventListener(MenuEvent.ITEM_CLICK, onMenuItemClick);
					//					//					menu.labelField = "@label";
					//					//                	menu.showRoot = false;
					//					viewMenu.variableRowHeight=true;
					//					//
					//					var viewMenuButton:ToolBarButton=new ToolBarButton();
					//					//
					////					viewMenuButton.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void
					////						{
					////							viewMenu.show(event.target.x, event.target.y + event.target.height);
					////						});
					//
					//					//
					//					viewMenuButton.setStyle("icon", iconViewMenuClass);
					//					viewMenuButton.width=VIEW_MENU_BUTTON_WIDTH;
					//					//
					//					var viewMenuButtonStyleName:String=getStyle(buttonStyleNameProp);
					//					if (!viewMenuButtonStyleName)
					//					{
					//						viewMenuButtonStyleName="PopUpButtonSkin";
					//					}
					//					viewMenuButton.styleName=viewMenuButtonStyleName;
					//					//	
					//					newButton=Button(viewMenuButton);


					var popUpMenuButton:PopUpMenuButton=new PopUpMenuButton();
					//
					popUpMenuButton.addEventListener(MenuEvent.ITEM_CLICK, onMenuItemClick);

					//

					//popUpMenuButton.labelField="@label"
					//
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
						if (popUpMenuButton.popUp is Menu)
						{
							Menu(popUpMenuButton.popUp).variableRowHeight=true;
						}
					}


					if (itemToType(item) == TYPE_VIEW_MENU)
					{
						popUpMenuButton.openAlways=true;
						//
						popUpMenuButton.setStyle("icon", null);
						popUpMenuButton.width=WIDTH_VIEW_MENU_BUTTON;
						popUpMenuButton.styleName=popUpViewMenuButtonStyleName;
					}
					else
					{
						if (item[FIELD_OPEN_ALWAYS] == true)
						{
							popUpMenuButton.openAlways=true;
						} else {
							popUpMenuButton.addEventListener(MouseEvent.CLICK, onMouseClick);
						}
						//
						popUpMenuButton.setStyle("icon", icon);
						popUpMenuButton.width=WIDTH_POPUP_MENU_BUTTON;
						popUpMenuButton.styleName=popUpMenuButtonStyleName;

					}


					//
					newButton=Button(popUpMenuButton);

				}
				else
				{
					var toolBarButton:ToolBarButton=new ToolBarButton();
					toolBarButton.addEventListener(MouseEvent.CLICK, onMouseClick);
					//
					toolBarButton.setStyle("icon", icon);
					toolBarButton.width=WIDTH_BUTTON;
					toolBarButton.styleName=buttonStyleName;
					//
					newButton=Button(toolBarButton);
				}
					// Set tabEnabled to false so individual buttons don't get focus.
					//newButton.focusEnabled=false;


					//


					//recalcButtonWidths=recalcButtonHeights=true;
			}
			//			newButton.label=label;
			newButton.label=null;
			newButton.focusEnabled=true;
			addChild(newButton);
			return newButton;
		}


		override public function styleChanged(styleProp:String):void
		{
			var allStyles:Boolean=styleProp == null || styleProp == "styleName";

			super.styleChanged(styleProp);

			if (allStyles || styleProp == buttonStyleNameProp || styleProp == popUpMenuButtonStyleName)
			{
				var popUpViewMenuButtonStyleName:String=getStyle(popUpViewMenuButtonStyleNameProp);
				if (!popUpViewMenuButtonStyleName)
				{
					popUpViewMenuButtonStyleName="PopUpButtonSkin";
				}

				var popUpMenuButtonStyleName:String=getStyle(popUpMenuButtonStyleNameProp);
				if (!popUpMenuButtonStyleName)
				{
					popUpMenuButtonStyleName="PopUpButtonSkin";
				}

				var buttonStyleName:String=getStyle(buttonStyleNameProp);
				if (!buttonStyleName)
				{
					buttonStyleName="ButtonBarButton";
				}

				var n:int=numChildren;
				for (var i:int=0; i < n; i++)
				{
					var button:Button=Button(getChildAt(i));
					var item:Object=dataProvider.getItemAt(i);
					//					if (itemToType(item) == TYPE_VIEW_ITEM)
					//					{
					//
					//					}
					//					else
					//					{
					if (button is PopUpButton)
					{

						if (itemToType(item) == TYPE_VIEW_MENU)
						{
							button.setStyle("icon", null);
							button.width=WIDTH_VIEW_MENU_BUTTON;
							button.styleName=popUpViewMenuButtonStyleName;

						}
						else
						{
							button.width=WIDTH_POPUP_MENU_BUTTON;
							button.styleName=popUpMenuButtonStyleName;

						}
					}
					else
					{
						button.width=WIDTH_BUTTON;
						button.styleName=buttonStyleName;

					}
						//					}


				}
			}
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