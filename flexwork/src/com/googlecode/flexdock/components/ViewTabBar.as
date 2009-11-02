package com.googlecode.flexdock.components
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.containers.ViewStack;
	import mx.controls.Button;
	import mx.controls.Menu;
	import mx.controls.PopUpButton;
	import mx.controls.TabBar;
	import mx.core.ClassFactory;
	import mx.core.IFlexDisplayObject;
	import mx.core.mx_internal;
	import mx.events.ChildExistenceChangedEvent;
	import mx.events.DragEvent;
	import mx.events.MenuEvent;
	import mx.managers.DragManager;

	//to access navItemFactory
	use namespace mx_internal;

	/*
	   viewTabBar:ViewTabBar
	   |
	   +--popupButton:PopupButton
	   |  |
	   |  +--menu:Menu

	 */
	public class ViewTabBar extends TabBar
	{


		public static var HEIGHT:int=25;
		/**
		 * Static variables indicating the policy to show the popUpMenuButton on
		 * the right side of the tabs.
		 *
		 * POPUPPOLICY_AUTO means the PopUpMenuButton will be shown if there is
		 * more thjan one tab.
		 * POPUPPOLICY_ON means the PopUpMenutButton will always be shown, even if
		 * there is only a single tab.
		 * POPUPPOLICY_OFF means the buttons will never be shown.
		 */
		public static var POPUPPOLICY_AUTO:String="auto";

		public static var POPUPPOLICY_ON:String="on";

		public static var POPUPPOLICY_OFF:String="off";

		protected var popupButton:PopUpButton;
		/**
		 * Our internal variable to keep track of the policy to show the PopUpMenuButton
		 */
		private var _popUpButtonPolicy:String=POPUPPOLICY_AUTO;

		protected var menu:Menu;

		//store an internal array of tabs to work with 
		private var _menuItem:Array=[];

		private function set menuItem(value:Array):void
		{
			_menuItem=value;
		}

		private function get menuItem():Array
		{
			return _menuItem
		}

		public static const TABS_REORDERED:String="tabsReordered";

		private var _closeButtonVisiblePolicy:String=ViewTab.CLOSE_BUTTON_VISIBLE_ROLLOVER;

		private var _dragEnabled:Boolean=true;

		public function ViewTabBar()
		{

			super();

			this.height=HEIGHT;

			navItemFactory=new ClassFactory(ViewTab);
			addEventListener("creationComplete", handleCreationComplete);
		}

		override protected function createChildren():void
		{

			super.createChildren();



			// We create the menu once. This doesn't get shown until we click
			// the PopUpMenuButton. But it can get created here so we don't have
			// to create it every time.
			//	        if(!menu) {
			//	        	menu = new ScrollableArrowMenu();
			//	        	// If we wanted to change the scroll policy for the scrolling menu we
			//	        	// could modify the following two lines. For example, turning 
			//	        	// verticalScrollPolicy to OFF will remove the side scrollbars and leave
			//	        	// just the arrow buttons on top and bottom.
			//	        	menu.verticalScrollPolicy = ScrollPolicy.AUTO;
			//	        	menu.arrowScrollPolicy = ScrollPolicy.AUTO;
			//	        	
			//	        	menu.addEventListener(MenuEvent.ITEM_CLICK, changeTabs);
			//	        }

			if (!menu)
			{
				menu=new Menu();
				menu.variableRowHeight=true; //TODO narrow separator
				// If we wanted to change the scroll policy for the scrolling menu we
				// could modify the following two lines. For example, turning 
				// verticalScrollPolicy to OFF will remove the side scrollbars and leave
				// just the arrow buttons on top and bottom.
				//	        	menu.verticalScrollPolicy = ScrollPolicy.AUTO;
				//	        	menu.arrowScrollPolicy = ScrollPolicy.AUTO;
				menu.addEventListener(MenuEvent.ITEM_CLICK, handleMenuItemClick);
					// menu.addEventListener(MenuEvent.ITEM_CLICK, changeTabs);
			}

			if (null==popupButton)
			{
				popupButton=new PopUpButton();
				popupButton.width=27;
				popupButton.toolTip="Show List";
				popupButton.setStyle("paddingTop", 5);
				//TODO:popupButton.setStyle("paddingLeft", 5);
				popupButton.setStyle("paddingRight", 0);
				//TODO:popupButton.setStyle("textAlign", "right");
				popupButton.height=18;
				popupButton.openAlways=true;				
				popupButton.styleName="viewTabBarPopUpButton";

				popupButton.popUp=menu;
				//
				popupButton.setStyle("arrowButtonWidth", 0);
				//popupButton.setStyle("cornerRadius", 2);
				//popupButton.setStyle("borderColor", 0xACA899);
				//popupButton.setStyle("borderThickness", 1);
				//popupButton.setStyle("borderThickness", 1);

				//popupButton.setStyle("backgroundColor", 0x0000FF);

				rawChildren.addChild(popupButton);

					//popupButton.addEventListener(MenuEvent.ITEM_CLICK,handleMenuItemClick);	        	
			}



		}

		//update the item data array
		private function buildMenuItem():void
		{

			menuItem=[];
			//menuItem.push({label:child.label, icon: child.getStyle("icon")})	
			for (var i:int=0; i < numChildren; i++)
			{
				var child:Button=Button(getChildAt(i));
				menuItem.push({label: child.label, icon: child.getStyle("icon")})
			}

			menu.dataProvider=menuItem;
		}

		override public function setChildIndex(child:DisplayObject, newIndex:int):void
		{
			super.setChildIndex(child, newIndex);
			buildMenuItem();
		}

		override public function removeChildAt(index:int):DisplayObject
		{

			menuItem.splice(index, 1);
			menu.dataProvider=menuItem;
			//			Alert.show("removeChildAt");



			return super.removeChildAt(index);


		}

		override protected function createNavItem(label:String, icon:Class=null):IFlexDisplayObject
		{

			var tab:ViewTab=super.createNavItem(label, icon) as ViewTab;
			this.buildMenuItem();
			//			tab.closePolicy = this.closePolicy;
			//			if(dragEnabled) {
			//				addDragListeners(tab);
			//			}
			//			
			//			if(dropEnabled) {
			//				addDropListeners(tab);
			//			}
			//			tab.addEventListener(ViewTab.CLOSE_TAB_EVENT, onCloseTabClicked, false, 0, true);

			return tab;
		}


		private function handleCreationComplete(event:Event):void
		{
			//make sure we get informed on the parent resize for the 
			//popup positioning
			parent.addEventListener("resize", handleParentResize);
			addEventListener(ChildExistenceChangedEvent.CHILD_ADD, handleChildExistenceChanged);
			addEventListener(ChildExistenceChangedEvent.CHILD_REMOVE, handleChildExistenceChanged);

		}


		private function handleParentResize(event:Event):void
		{
			invalidateDisplayList();
		}

		/**
		 * Listener that gets caled when a tab is added or removed.
		 */
		private function handleChildExistenceChanged(event:ChildExistenceChangedEvent):void
		{
			callLater(reorderTabList);
			invalidateDisplayList();
		}

		public function reorderTabList():void
		{
			var popupMenuArray:ArrayCollection=new ArrayCollection();

			for (var i:int=0; i < numChildren; i++)
			{
				var child:Button=Button(getChildAt(i));
				//				var label:String = "Untitled Tab";
				//				if(child is ViewTab && (child as ViewTab).label != "") {
				//					label = (child as ViewTab).label;
				//				}

				popupMenuArray.addItem({label: child.label, icon: child.getStyle("icon")})
					//popupMenuArray.addItem(label);
			}

			menu.dataProvider=popupMenuArray;
		}

		//on the menu click update both the tab bar and the parent (when tab not visible)
		private function handleMenuItemClick(event:MenuEvent):void
		{

			var viewWindow:ViewWindow=getViewWindow();



			if (getChildAt(event.index).visible)
			{
				this.selectedIndex=viewWindow.selectedIndex=event.index;
			}
			else
			{
				//this.selectedIndex = viewWindow.selectedIndex = 0;
				//callLater(ensureTabIsVisible,[event]);



				setChildIndex(getChildAt(event.index), 0);
				this.selectedIndex=0;

				viewWindow.setChildIndex(viewWindow.getChildAt(event.index), 0);
				viewWindow.selectedIndex=0;

				this.invalidateDisplayList();

					//				if (owner is extended_TabNavigator){
					//					extended_TabNavigator(owner).setChildIndex(owner.getChildAt(event.index),0);
					//					extended_TabNavigator(owner).selectedIndex = 0;
					//				}							
			}

		}




		private function getViewWindow():ViewWindow
		{

			var object:DisplayObject=this;
			while (!(object is ViewWindow))
			{
				object=object.parent;
			}
			return ViewWindow(object);
		}

		public function get popUpButtonPolicy():String
		{
			return _popUpButtonPolicy;
		}

		public function set popUpButtonPolicy(value:String):void
		{
			var old:String=this._popUpButtonPolicy;
			this._popUpButtonPolicy=value;

			if (old != value)
			{
				this.invalidateDisplayList();
			}
		}

		override protected function commitProperties():void
		{
			super.commitProperties();

		}

		override protected function measure():void
		{
			super.measure();

		}

		override protected function layoutChrome(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.layoutChrome(unscaledWidth, unscaledHeight);
		}

		protected function invalidateDisplayTabs():void
		{
			var gap:int=(this.height - popupButton.height) / 2;
			var popupButtonX:int=gap;

			var restUnscaledWidth:int=parent.width - gap - popupButton.width; //[while parent is canvas in ViewWindow 
			//popupButton.move(unscaledWidth + gap, 0);
			//popupButton.height = height;
			var hiddenCount:int=0;
			for (var i:int=0; i < numChildren; i++)
			{
				var currTab:Button=Button(getChildAt(i));
				if ((currTab.x + currTab.width) >= restUnscaledWidth)
				{
					currTab.visible=false;
					popupButton.visible=true;
					popupButton.enabled=true;
					hiddenCount++;
				}
				else
				{
					currTab.visible=true;
					popupButton.close();
					popupButton.visible=false;
					popupButton.enabled=false;
					popupButtonX=currTab.x + currTab.width + gap;
				}
			}
			if (popupButton.visible)
			{
				popupButton.move(popupButtonX, gap);
				popupButton.label=String(hiddenCount);
			}
		}

		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);

			invalidateDisplayTabs();

			// Are we supposed to be showing the PopUpMenuButton?
			//	        if(_popUpButtonPolicy == ViewWindow.POPUPPOLICY_AUTO) {
			//	        	popupButton.includeInLayout = popupButton.visible = this.numChildren > 1;
			//	        } else if(_popUpButtonPolicy == ViewWindow.POPUPPOLICY_ON) {
			//	        	popupButton.includeInLayout = popupButton.visible = true;
			//	        } else if(_popUpButtonPolicy == ViewWindow.POPUPPOLICY_OFF) {
			//	        	popupButton.includeInLayout = popupButton.visible = false;
			//	        }


			//			if(popupButton.includeInLayout) {
			//				tabBarSpace -= popupButton.width;
			//			}
			//			
			//			if(popupButton.includeInLayout) {
			//				canvasWidth -= popupButton.width;
			//			}



			//			if(this.numChildren >0) {
			//				
			//				var restUnscaledWidth:int = unscaledWidth;
			//				var child:ViewTab = null;
			//				var n:int = numChildren;
			//				var i:int = 0
			//			    for (; i < n; i++)
			//			    {
			//			    	child = ViewTab(getChildAt(i));
			//			    	
			//			    	if(restUnscaledWidth > child.width) {
			//			    		restUnscaledWidth -= child.width;
			//			    		child.visible = true;
			//			    	} else {
			//			    		break;
			//			    	}
			//			    }
			//			    i++;
			//			    for (; i < n; i++)
			//			    {
			//			    	child = ViewTab(getChildAt(i));
			//			    	
			//			    	child.visible = false;
			//			    }
			//			}
		}

























		public function get dragEnabled():Boolean
		{
			return _dragEnabled;
		}

		public function set dragEnabled(value:Boolean):void
		{
			this._dragEnabled=value;

			var n:int=numChildren;
			for (var i:int=0; i < n; i++)
			{
				var child:ViewTab=ViewTab(getChildAt(i));

				if (value)
				{
					addDragListeners(child);
				}
				else
				{
					removeDragListeners(child);
				}
			}
		}

		private var _dropEnabled:Boolean=true;

		public function get dropEnabled():Boolean
		{
			return _dropEnabled;
		}

		public function set dropEnabled(value:Boolean):void
		{
			this._dropEnabled=value;

			var n:int=numChildren;
			for (var i:int=0; i < n; i++)
			{
				var child:ViewTab=ViewTab(getChildAt(i));

				if (value)
				{
					addDropListeners(child);
				}
				else
				{
					removeDropListeners(child);
				}
			}
		}


		public function onCloseTabClicked(event:Event):void
		{
			var index:int=getChildIndex(DisplayObject(event.currentTarget));
			if (dataProvider is IList)
			{
				dataProvider.removeItemAt(index);
			}
			else if (dataProvider is ViewStack)
			{
				dataProvider.removeChildAt(index);
			}
		}



		public function get closeButtonVisiblePolicy():String
		{
			return _closeButtonVisiblePolicy;
		}

		public function set closeButtonVisiblePolicy(value:String):void
		{
			this._closeButtonVisiblePolicy=value;
			this.invalidateDisplayList();

			var n:int=numChildren;
			for (var i:int=0; i < n; i++)
			{
				var child:ViewTab=ViewTab(getChildAt(i));
				child.closeButtonVisiblePolicy=value;
			}
		}
































		private function addDragListeners(tab:ViewTab):void
		{
			tab.addEventListener(MouseEvent.MOUSE_DOWN, tryDrag, false, 0, true);
			tab.addEventListener(MouseEvent.MOUSE_UP, removeDrag, false, 0, true);
		}

		private function removeDragListeners(tab:ViewTab):void
		{
			tab.removeEventListener(MouseEvent.MOUSE_DOWN, tryDrag);
			tab.removeEventListener(MouseEvent.MOUSE_UP, removeDrag);
		}

		private function addDropListeners(tab:ViewTab):void
		{
			tab.addEventListener(DragEvent.DRAG_ENTER, tabDragEnter, false, 0, true);
			tab.addEventListener(DragEvent.DRAG_OVER, tabDragOver, false, 0, true);
			tab.addEventListener(DragEvent.DRAG_DROP, tabDragDrop, false, 0, true);
			tab.addEventListener(DragEvent.DRAG_EXIT, tabDragExit, false, 0, true);
		}

		private function removeDropListeners(tab:ViewTab):void
		{
			tab.removeEventListener(DragEvent.DRAG_ENTER, tabDragEnter);
			tab.removeEventListener(DragEvent.DRAG_OVER, tabDragOver);
			tab.removeEventListener(DragEvent.DRAG_DROP, tabDragDrop);
			tab.removeEventListener(DragEvent.DRAG_EXIT, tabDragExit);
		}

		private function tryDrag(e:MouseEvent):void
		{
			e.target.addEventListener(MouseEvent.MOUSE_MOVE, doDrag);
		}

		private function removeDrag(e:MouseEvent):void
		{			e.target.removeEventListener(MouseEvent.MOUSE_MOVE, doDrag);
		}


		private function doDrag(event:MouseEvent):void
		{
			//				if(IUIComponent(event.target) is ViewTab || (IUIComponent(event.target).parent is ViewTab && !(IUIComponent(event.target) is Button))) {
			//					
			//					var tab:ViewTab;
			//					
			//					if(IUIComponent(event.target) is ViewTab) {
			//						tab = IUIComponent(event.target) as ViewTab;
			//					}
			//					
			//					if(IUIComponent(event.target).parent is ViewTab) {
			//						tab = IUIComponent(event.target).parent as ViewTab;
			//					}
			//					
			//					var ds:DragSource = new DragSource();
			//					ds.addData(event.currentTarget,'tabDrag');
			//					
			//					var bmapData:BitmapData = new BitmapData(tab.width, tab.height, true, 0x00000000);
			//					bmapData.draw(tab);
			//					var dragProxy:Bitmap = new Bitmap(bmapData); 
			//					
			//					var obj:UIComponent = new UIComponent();
			//					obj.addChild(dragProxy);
			//					
			//					//DragManager.doDrag(IUIComponent(event.target),ds,event,obj);	
			//				}					
		}



		private function tabDragEnter(event:DragEvent):void
		{
			if (event.dragSource.hasFormat('tabDrag') && event.draggedItem != event.dragInitiator)
			{

				//DragManager.acceptDragDrop(IUIComponent(event.target));
			}
		}

		private function tabDragOver(event:DragEvent):void
		{
			if (event.dragSource.hasFormat('tabDrag') && event.dragInitiator != event.currentTarget)
			{


				var dropTab:ViewTab=(event.currentTarget as ViewTab);
				var dropIndex:Number=this.getChildIndex(dropTab);

				var gap:Number=0;

				var left:Boolean=event.localX < dropTab.width / 2;

				if ((left && dropIndex > 0) || (dropIndex < this.numChildren - 1))
				{
					gap=this.getStyle("horizontalGap") / 2;
				}

				if (left)
				{
					gap=-gap;
				}
				else
				{
					gap=dropTab.width + gap;
				}

				//dropTab.showIndicatorAt(gap);

				DragManager.showFeedback(DragManager.LINK);
			}
		}

		private function tabDragExit(event:DragEvent):void
		{
			var dropTab:ViewTab=(event.currentTarget as ViewTab);
			//dropTab.showIndicator = false;

		}

		private function tabDragDrop(event:DragEvent):void
		{
			if (event.dragSource.hasFormat('tabDrag') && event.draggedItem != event.dragInitiator)
			{

				var dropTab:ViewTab=(event.currentTarget as ViewTab);
				var dragTab:ViewTab=(event.dragInitiator as ViewTab);

				var left:Boolean=event.localX < dropTab.width / 2;

				//var parentNavigator:ViewTabNavigator;
				var parentBar:ViewTabBar;

				var object:*=event.dragInitiator;
				while (object && object.parent)
				{
					object=object.parent;

					if (object is ViewTab)
					{
						dragTab=object;
						break;
					}
				}

				object=dragTab;
				while (object && object.parent)
				{
					object=object.parent;

					if (object is ViewTabBar)
					{
						parentBar=object;
					}
						//					if(object is ViewTabNavigator) {
						//						parentNavigator = object as ViewTabNavigator;
						//						break;
						//					}
				}



				//dropTab.showIndicator = false;

				var oldIndex:Number=parentBar.getChildIndex(dragTab);


				var newIndex:Number=this.getChildIndex(dropTab);
				if (!left)
				{
					newIndex+=1;
				}

					//this.dispatchEvent(new TabReorderEvent(ViewTabBar.TABS_REORDERED, false, false, parentNavigator, oldIndex, newIndex));
			}
		}
	}

}