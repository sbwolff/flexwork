package com.googlecode.flexdock.components
{

	/*
	   viewWindow:ViewWindow
	   |
	   +--titleBar:ViewWindowTitleBar
	   |  |
	   |  +--tabBar:ViewTabBar
	   |  |
	   |  +--(viewActionBar)
	   |  |
	   |  +--minimizeButton:Button
	   |  |
	   |  +--maximizeButton:Button
	   |
	   +--viewActionBar:HBox
	   |  |
	   |  +--viewButtonBar:ViewButtonBar
	   |  |
	   |  +--viewMenuBar:ViewMenuBar

	 */

	import com.googlecode.flexdock.events.DockViewEvent;
	import com.googlecode.flexdock.utils.BorderLayout;
	import com.googlecode.flexdock.utils.BorderLayoutPosition;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.containers.Canvas;
	import mx.containers.HBox;
	import mx.containers.TabNavigator;
	import mx.controls.Button;
	import mx.core.EdgeMetrics;
	import mx.core.ScrollPolicy;
	import mx.events.DragEvent;
	import mx.events.IndexChangedEvent;
	import mx.events.ItemClickEvent;
	import mx.managers.DragManager;
	import mx.managers.PopUpManager;
	
	

	public class ViewWindow extends TabNavigator implements DockWindow
	{

		//		[Embed(source="/assets/minimize.gif")]
		//		public var minimizeClass:Class;


		//private static const HEIGHT_OFFSET:int=0; //for overclap bottom line of tabs

		protected var _maximized:Boolean=false;

		private var _dropEnabled:Boolean=true;

		private var _dragEnabled:Boolean=true;

		public var borderLayout:String=BorderLayout.CENTER;
		
		public var borderLayoutPosition:BorderLayoutPosition;

		/** child component */
		protected var titleBar:ViewWindowBar;

		protected var canvas:Canvas;

		protected var minimizeButton:Button;

		protected var maximizeButton:Button;

		protected var viewActionBar:HBox;

		protected var dockProxy:Canvas;

		public function ViewWindow()
		{
			super();

			/* common */

			/* events */
			addEventListener(DockViewEvent.CLOSED, onViewClosed);

			addEventListener(DragEvent.DRAG_OVER, onDragOver);
			addEventListener(DragEvent.DRAG_ENTER, onDragEnter);
			addEventListener(DragEvent.DRAG_EXIT, onDragExit);
			addEventListener(DragEvent.DRAG_DROP, onDragDrop);

			addEventListener(IndexChangedEvent.CHANGE, tabChangedEvent);
			addEventListener(DockViewEvent.REMOVING, onViewRemoving);

			/* size */
			percentWidth=percentHeight=100;

			/* styles */
			styleName="viewWindow";
			setStyle("paddingTop", 2);
			setStyle("paddingLeft", 2);
			setStyle("paddingRight", 2);
			setStyle("paddingBottom", 2);
			setStyle("borderColor", 0xACA899);
			setStyle("borderThickness", 1);
			setStyle("borderStyle", "solid");
			//setStyle("resizeEffect", Resize);			
			//setStyle("horizontalGap", 0);
			//setStyle("verticalGap", 0);
			setStyle("backgroundColor", 0xECE9D8);

			/* other */
			focusEnabled=true;
		}



		public function get dropEnabled():Boolean
		{
			if (tabBar)
			{
				return (tabBar as ViewTabBar).dropEnabled;
			}
			else
			{
				return _dropEnabled;
			}
		}

		public function set dropEnabled(value:Boolean):void
		{
			_dropEnabled=value;

			if (tabBar)
			{
				(tabBar as ViewTabBar).dropEnabled=value;
			}
		}

		override protected function createChildren():void
		{

			if (!tabBar)
			{
				// We're using our custom ViewTabBar class instead of TabBar
				tabBar=new ViewTabBar();
				tabBar.name="tabBar";
				tabBar.focusEnabled=false;
				tabBar.styleName=this;
				(tabBar as ViewTabBar).dragEnabled=this._dragEnabled;
				(tabBar as ViewTabBar).dropEnabled=this._dropEnabled;


				//				tabBar.setStyle("horizontalGap", 0);
				//	        	tabBar.setStyle("verticalGap", 0);

				tabBar.setStyle("borderStyle", "none");
				tabBar.setStyle("paddingTop", 0);
				tabBar.setStyle("paddingLeft", 0);
				tabBar.setStyle("paddingBottom", 0);
				tabBar.setStyle("paddingRight", 3);

				(tabBar as ViewTabBar).closeButtonVisiblePolicy=ViewTab.CLOSE_BUTTON_VISIBLE_ROLLOVER;
			}

			// We need to create our tabBar above BEFORE calling creteChildren
			// because otherwise it would get created in the super class.
			// Once we create it then the super class will skip it. It still hasn't
			// been added as a child however (this gets done below).
			super.createChildren();

			if (!titleBar)
			{
				// Why not just use HBox? Because in the future we might want
				// to use a VBox for vertical tabs. This lets a subclass simply
				// change the direction.
				titleBar=new ViewWindowBar();
				//titleBar.get

				titleBar.setStyle("horizontalGap", 0);
				titleBar.setStyle("verticalGap", 0);
				//
				titleBar.setStyle("paddingRight", 2);
				titleBar.setStyle("paddingTop", 0);
				titleBar.setStyle("paddingBottom", 0);
				//titleBar
				titleBar.horizontalScrollPolicy=ScrollPolicy.OFF;
				//titleBar.verticalScrollPolicy = ScrollPolicy.OFF;
				titleBar.setStyle("roundedBottomCorners", false);
				//titleBar.setStyle("borderStyle", "none");
				titleBar.setStyle("borderStyle", "solid");
				titleBar.setStyle("cornerRadius", 10);
				titleBar.setStyle("borderColor", 0xACA899);
				titleBar.setStyle("borderThickness", 1);

				rawChildren.addChild(titleBar);


			}

			if (null==canvas)
			{
				canvas=new Canvas();
				canvas.styleName=this;
				canvas.setStyle("borderStyle", "none");
				canvas.setStyle("backgroundAlpha", 0);
				canvas.setStyle("paddingTop", 0);
				canvas.setStyle("paddingBottom", 0);
				canvas.horizontalScrollPolicy=ScrollPolicy.OFF;
				canvas.verticalScrollPolicy=ScrollPolicy.OFF;
				//	        	canvas.startScrollingEvent = _startScrollingEvent;
				//	        	canvas.stopScrollingEvent = _stopScrollingEvent;
				//	        	canvas.scrollSpeed = _scrollSpeed;

				// So we can see our child heirarchy: 
				// titleBar (Box) -> canvas (ButtonScrollingCanvas) -> tabBar (ViewTabBar)
				canvas.addChild(tabBar);
				titleBar.addChild(canvas);
			}

			//	         if(!spacer) {
			//		        // Now we add a spacer that will take up the rest of the box width
			//		        spacer = new Spacer();
			//		        spacer.percentWidth = 100;
			//		        titleBar.addChild(spacer);
			//	        }

			if (!minimizeButton)
			{
				minimizeButton=new Button();
				minimizeButton.width=minimizeButton.height=18;
				minimizeButton.styleName="minimizeButton";
				minimizeButton.label="Minimize";

				//minimizeButton.addEventListener(MouseEvent.MOUSE_DOWN, onMinimize);
				minimizeButton.addEventListener(MouseEvent.CLICK, onMinimize);
				
				titleBar.addChild(minimizeButton);
			}

			if (!maximizeButton)
			{
				maximizeButton=new Button();
				maximizeButton.width=maximizeButton.height=18;
				maximizeButton.styleName="maximizeButton";
				maximizeButton.label="Maximize";
				maximizeButton.addEventListener(MouseEvent.CLICK, onMaximize);
				//maximizeButton.addEventListener(MouseEvent.MOUSE_DOWN, onMaximize);
				//	        	maximizeButton.setStyle("paddingTop", 3);
				//				maximizeButton.setStyle("paddingRight", 3);
				//popupButton.styleName = getStyle("popupButtonStyleName");

				titleBar.addChild(maximizeButton);
			}

			//	        tabBar.addEventListener(ChildExistenceChangedEvent.CHILD_ADD, tabsChanged);
			//	        tabBar.addEventListener(ChildExistenceChangedEvent.CHILD_REMOVE, tabsChanged);

			// This is a custom event that gets fired from ViewTabBar if the tabs are
			// dragged and reordered.
			tabBar.addEventListener(ViewTabBar.TABS_REORDERED, tabsReordered);

			titleBar.doubleClickEnabled=true;
			titleBar.addEventListener(MouseEvent.DOUBLE_CLICK, onMaximize);


			if (!dockProxy)
			{
				dockProxy=new Canvas();

				//dockProxy.styleName="dockProxy";

				//				dockProxy.setStyle("fontWeight", "normal");
				//				dockProxy.setStyle("textAlign", "left");
				dockProxy.setStyle("backgroundAlpha", 0.4);
				dockProxy.setStyle("backgroundColor", 0xECE9D8);
				dockProxy.setStyle("borderStyle", "solid");
				dockProxy.setStyle("borderThickness", 3);
				dockProxy.setStyle("borderColor", 0x58B299);

				dockProxy.visible=false;
				//				dragProxy.addEventListener(MouseEvent.MOUSE_OUT, handleTabMouseOut);
				//				dragProxy.addEventListener(MouseEvent.MOUSE_MOVE, handleTabMouseMove);
				//				dragProxy.addEventListener(MouseEvent.MOUSE_UP, handleTabMouseUp);
				//	            dragProxy.setStyle("borderColor", 0xACA899);
				//				dragProxy.setStyle("borderThickness", 1);
				//				dragProxy.setStyle("borderStyle", "solid");
				//				dragProxy.setStyle("backgroundColor", 0xEEEEEE);
				//
				//TODO:make sure it is topmost display object and show it
				this.rawChildren.addChild(dockProxy);
					//dragProxy.visible = false;
			}

			invalidateSize();
		}

		public function get closeButtonVisiblePolicy():String
		{
			return (tabBar as ViewTabBar).closeButtonVisiblePolicy;
		}

		public function set closeButtonVisiblePolicy(value:String):void
		{
			var old:String=(tabBar as ViewTabBar).closeButtonVisiblePolicy;
			(tabBar as ViewTabBar).closeButtonVisiblePolicy=value;
			if (old != value)
			{
				invalidateDisplayList();
			}
		}


		private function tabsReordered(event:Event):void
		{			// The relatedObject of our custom event is the ViewWindow component
			// where the tab originated. This is so we can properly move tabs from
			// one navigator to another.
			//	    	var sourceNav:ViewWindow = event.relatedObject as ViewWindow;
			//	    	
			//	    	// The oldIndex property of the event specifies the index of the tab
			//	    	// in the original navigator. Note that the tab might not be a child of
			//	    	// this current tab navigator that we're in (ie sourceNav might not == this).
			//	    	var child:DisplayObject = sourceNav.getChildAt(event.oldIndex);
			//	    	sourceNav.removeChildAt(event.oldIndex);
			//	    	
			//	    	// If we are moving a tab from this same navigator then we might need
			//	    	// to adjust the index that we're moving to
			//	    	if(this == sourceNav && event.oldIndex < event.newIndex) {
			//	    		event.newIndex--;
			//	    	}
			//	    	
			//	    	// We add the tab to ourself at the new index position
			//	    	this.addChildAt(child, event.newIndex);
			//	    	
			//	    	// Calling validateNow before calling selectedIndex makes sure we 
			//	    	// don't get a little display bug that tends to creep up
			//	    	this.validateNow();
			//	    	
			//	    	// If we just dropped a tab then we want to select it,
			//	    	// that just seems like the intuitive thing to do
			//	    	this.selectedIndex = event.newIndex;
			//	    	
			//	    	// We might be dragging from a different tab navigator. if so, we need
			//	    	// to update the drop-down menu to relfect the new tabs
			//	    	if(sourceNav != this) {
			//	    		sourceNav.reorderTabList();
			//	    		sourceNav.invalidateDisplayList();
			//	    	}
			//	    	
			//	    	// Now update the drop-down menu to show the newly ordered tabs
			//	    	reorderTabList();
			//	    	this.invalidateDisplayList();
		}

		private var forcedTabWidth:Number=-1;

		private var originalTabWidthStyle:Number=-1;

		private var _minTabWidth:Number=60;

		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{

			super.updateDisplayList(unscaledWidth, unscaledHeight);

			this.minimizeButton.includeInLayout=this.maximizeButton.includeInLayout=true;

			//spacer.includeInLayout = 
			//spacer.includeInLayout = popupButton.includeInLayout;

			var vm:EdgeMetrics=viewMetrics;
			var w:Number=unscaledWidth - vm.left - vm.right;

			var th:Number=tabBarHeight;
			var pw:Number=tabBar.getExplicitOrMeasuredWidth();

			// tabBarSpace is used tot ry to figure out how much space we 
			// need for the tabs, to figure out if we need to scroll them
			var tabBarSpace:Number=w;

			tabBarSpace-=maximizeButton.width;
			tabBarSpace-=minimizeButton.width;

			// The following code tries to determin if we need to force the tabs to be
			// smaller than their natural width. If we can squeeze them all in and keep
			// them larger than whatever minTabWidth is set to, then we should squeeze them.
			// If we can't squeeze them in then we need to scroll them.


			if (pw > tabBarSpace)
			{
				var numTabs:Number=tabBar.numChildren;
				var tabSizeNeeded:Number=Math.max((tabBarSpace - this.getStyle("horizontalGap") * (numTabs - 1)) / numTabs, _minTabWidth);

				if (forcedTabWidth != tabSizeNeeded)
				{
					if (originalTabWidthStyle == -1)
					{
						originalTabWidthStyle=this.getStyle("tabWidth");
					}

					forcedTabWidth=tabSizeNeeded;
					this.setStyle("tabWidth", forcedTabWidth);
					callLater(invalidateDisplayList);
					return;
				}
			}
			else
			{
				if (forcedTabWidth == -1 && this.getStyle("tabWidth") != originalTabWidthStyle && originalTabWidthStyle != -1)
				{

					if (this.getStyle("tabWidth") != undefined)
					{
						if (isNaN(originalTabWidthStyle))
						{
							this.clearStyle("tabWidth");
							tabBar.validateNow();
						}
						else
						{
							this.setStyle("tabWidth", originalTabWidthStyle);
						}

						callLater(invalidateDisplayList);
					}
				}
				forcedTabWidth=-1;
			}

			if (forcedTabWidth != -1)
			{
				pw=(forcedTabWidth * tabBar.numChildren) + (this.getStyle("horizontalGap") * (tabBar.numChildren - 1));
			}



			var canvasWidth:Number=unscaledWidth;


			canvasWidth-=maximizeButton.width;
			canvasWidth-=minimizeButton.width;

			canvasWidth-=3;

			canvas.width=canvasWidth;
			canvas.height=th;
			//canvas.explicitButtonHeight = th - 1;

			if (pw <= canvasWidth)
			{
				canvas.horizontalScrollPosition=0;
			}

			tabBar.move(0, 0);
			tabBar.setActualSize(pw, th);

			titleBar.move(0, 0);
			titleBar.setActualSize(unscaledWidth, th);

			/* we only care about horizontalAlign if we're not taking up too
			 much space already */
			if (pw < canvasWidth)
			{

				switch (getStyle("horizontalAlign"))
				{
					case "left":
						tabBar.move(0, tabBar.y);
						break;
					case "right":
						tabBar.move(unscaledWidth - tabBar.width, tabBar.y);
						break;
					case "center":
						tabBar.move((unscaledWidth - tabBar.width) / 2, tabBar.y);
				}
			}





		}


		/**
		 * tabBarHeight is the same as the same funtion in TabNavigator, but the
		 * one in TabNavigator was private, so we had to reproduce it here.
		 */
		protected function get tabBarHeight():Number
		{
			var tabHeight:Number=getStyle("tabHeight");

			if (isNaN(tabHeight))
				tabHeight=tabBar.getExplicitOrMeasuredHeight();

			return tabHeight;
		}

		/**
		 * The tabs can be changed any number of ways (via drop-down menu, via AS, etc)
		 * so this listener function will make sure that the tab that gets selected is
		 * visible.
		 */
		private function tabChangedEvent(event:IndexChangedEvent):void
		{
			//callLater(ensureTabIsVisible);
		}

		/**
		 * Check to make sure that the currently selected tab is viaible. This means
		 * that we might have to scroll the canvas component so the tab comes into view
		 */
		//	    private function ensureTabIsVisible():void {
		//	    	var tab:DisplayObject = this.tabBar.getChildAt(this.selectedIndex);
		//	    	
		//	    	var newHorizontalPosition:Number;
		//	    	
		//	    	if(tab.x + tab.width > this.canvas.horizontalScrollPosition + this.canvas.width) {
		//	    		newHorizontalPosition = tab.x  - canvas.width + tab.width + canvas.getStyle("buttonWidth");	
		//	    	}
		//	    	else if(this.canvas.horizontalScrollPosition > tab.x) {
		//	    		newHorizontalPosition = tab.x - canvas.getStyle("buttonWidth");
		//	    	}
		//	    	else {
		//	    		newHorizontalPosition = canvas.horizontalScrollPosition;
		//	    	}
		//	    	
		//	    	if(newHorizontalPosition) {
		//	    		// We tween the motion so it looks super sweet
		//	    		var tween:Tween = new Tween(this, canvas.horizontalScrollPosition, newHorizontalPosition, 500);
		//	    		
		//	    		// Alternatively if we didn't want to use the tweening we could just set the
		//	    		// horizontalScrollPosition right away (this is what I first did)
		//	    		//canvas.horizontalScrollPosition = newHorizontalPosition;
		//	    	}
		//	    }

		//	    public function onTweenUpdate(val:Object):void {
		//            canvas.horizontalScrollPosition = val as Number;
		//        }
		//        
		//        public function onTweenEnd(val:Object):void {
		//           canvas.horizontalScrollPosition = val as Number;
		//        }


		//	     override public function get borderMetrics():EdgeMetrics
		//    {
		//    	 var bm:EdgeMetrics = super.borderMetrics;
		//    	 bm.top-=1;
		//        return bm;
		//    }
		//	    override public function get viewMetrics():EdgeMetrics
		//	    {
		//	        var vm:EdgeMetrics = new EdgeMetrics(0, 0, 0, 0);
		//	        var o:EdgeMetrics = super.viewMetrics;
		//	        
		//	        var bt:Number = getStyle("borderThickness");
		//	        
		//	        vm.top = o.top - 1;
		//	        vm.left = o.left;
		//	        vm.right = o.right;
		//	       	vm.bottom = o.bottom;
		//	        return vm;
		//	    }




		private function handleTabMouseOut(event:MouseEvent):void
		{

			if (this.getStageWindow().docking)
			{
				PopUpManager.removePopUp(dockProxy);
			}
		}


		private function handleTabMouseUp(event:MouseEvent):void
		{
			if (this.getStageWindow().docking && null != this.getStageWindow().dockView)
			{

				var view:DisplayObject=this.getStageWindow().dockView as DisplayObject

				var oldIndex:int=view.parent.getChildIndex(view);
				var newIndex:int=0;

				ViewWindow(view.parent).removeChildAt(oldIndex);
				addChildAt(view, newIndex);

				//validate the visible items for the tab bar.
				//extended_TabBar(tabBar).validateVisibleTabs();					

				this.getStageWindow().docking=false;
				this.getStageWindow().dockView=null;
				PopUpManager.removePopUp(dockProxy);
			}
		}

		private function handleTabMouseMove(event:MouseEvent):void
		{

		}

		private function handleTabMouseDown(event:MouseEvent):void
		{

		}


		private function getRealRect():Rectangle
		{
			//var r:Rectangle = this.getRect(this.getStageWindow());//.getBounds(
			var rectangle:Rectangle=new Rectangle();
			rectangle.width=this.width;
			rectangle.height=this.height;

			var point:Point=new Point();
			point.x=0;
			point.y=0; //- this.viewMetrics.top;
			point=this.localToGlobal(point);
			rectangle.x=point.x;
			rectangle.y=point.y;
			rectangle.y=point.y;
			return rectangle;
		}

		private function handleDragEnter(event:DragEvent):void
		{
			if (event.dragSource.hasFormat(ViewTab.FORMAT))
			{
				var dropTarget:ViewWindow=ViewWindow(event.currentTarget);
				DragManager.acceptDragDrop(dropTarget);


					//make sure it is topmost display object and show it
					//               	rawChildren.setChildIndex(DisplayObject(tabDropIndicator), rawChildren.numChildren-1)
					//				tabDropIndicator.visible=true;	                


					//				
					//dockProxy.

			}
		}

		/**
		 * draw indicator to show user where the tab
		 * will be inserted
		 **/
		private function onDragOver(event:DragEvent):void
		{
			if (event.dragSource.hasFormat(ViewTab.FORMAT))
			{
				//TODO:make sure it is topmost display object and show it
				//rawChildren.setChildIndex(DisplayObject(dockProxy), rawChildren.numChildren - 1);
				//event.d

				//				var dragInitiator:Button=Button(event.currentTarget);
				//				
				//				var dockProxy:Canvas = new Canvas();
				//	            var mask = this;
				//	            dockProxy.alpha = 0.8;
				//	            dockProxy.setStyle("borderColor", 0xACA899);//ACA899
				//				dockProxy.setStyle("borderThickness", 1);
				//				dockProxy.setStyle("borderStyle", "solid");
				//				dockProxy.setStyle("backgroundColor", 0xCCCCCC);	
				//	            dockProxy.width = mask.width;
				//	            dockProxy.height = mask.height;
				//	                
				//	            DragManager.doDrag(dragInitiator, event.dragSource, event, dockProxy);



				//			var contactForm:ContactForm = new ContactForm();
				//                PopUpManager.addPopUp(contactForm, this, true);
	
				this.borderLayout=BorderLayout.CENTER;

				if (this.getStageWindow().docking)
				{
					//Alert.show('Text Copied!');

					var rectangle:Rectangle=getRealRect();
					//				dockProxy.width = rectangle.width;
					//				dockProxy.height = rectangle.height;
					var x:int=0;
					var y:int=0;


					var dockView:ViewTab=event.dragInitiator as ViewTab;
					var viewWindow:ViewWindow=dockView.getViewWindow();

					if (this == viewWindow && 1 == viewWindow.getChildren().length)
					{

					}
					else
					{
						if (event.localX < rectangle.width / 4)
						{
							this.borderLayout=BorderLayout.WEST;
							rectangle.width/=2;
						}
						else if (event.localX > rectangle.width * 3 / 4)
						{
							this.borderLayout=BorderLayout.EAST;
							x=rectangle.width / 2;
							rectangle.width/=2;
								//dockProxy.x += rectangle.width/2;
						}
						else
						{
							if (event.localY < rectangle.height / 4)
							{
								this.borderLayout=BorderLayout.NORTH;
								rectangle.height/=2;
							}
							else if (event.localY > rectangle.height * 3 / 4)
							{
								this.borderLayout=BorderLayout.SOUTH;
								y+=rectangle.height / 2;
								rectangle.height/=2;
							}
						}
					}

					dockProxy.width=rectangle.width;
					dockProxy.height=rectangle.height;
					dockProxy.move(x, y);

					//				if(!this.dockProxyPopUped) {
					////					this.dockProxyPopUped = true;
					////					PopUpManager.addPopUp(dockProxy, this, false);
					//				}
					if (!dockProxy.visible)
					{
						dockProxy.visible=true;
					}
				}
					//PopUpManager.addPopUp(dockProxy, this, false);		


			}
		}

		private function onDragEnter(event:DragEvent):void
		{
			if (event.dragSource.hasFormat(ViewTab.FORMAT))
			{
				//TODO:make sure it is topmost display object and show it
				//               	rawChildren.setChildIndex(DisplayObject(dockProxy), rawChildren.numChildren - 1);

				var dropTarget:ViewWindow=ViewWindow(event.currentTarget);
				DragManager.acceptDragDrop(dropTarget);

				//               	//make sure it is topmost display object and show it
				//               	rawChildren.setChildIndex(DisplayObject(tabDropIndicator),rawChildren.numChildren-1)
				//				tabDropIndicator.visible=true;	                



				//			var contactForm:ContactForm = new ContactForm();
				//                PopUpManager.addPopUp(contactForm, this, true);

				event.stopPropagation();
				event.preventDefault();
				//			Alert.show('Text Copied!');

				var rectangle:Rectangle=getRealRect();

				dockProxy.width=rectangle.width;
				dockProxy.height=rectangle.height;
				dockProxy.move(0, 0);
				dockProxy.visible=true;

				this.getStageWindow().docking=true;
				this.getStageWindow().dockView=event.target as DisplayObject;
					//				this.dockProxyPopUped = true;
					//PopUpManager.addPopUp(dockProxy, this, false);
			}
		}

		private function onViewDocked(event:DockViewEvent):void
		{
			if (this.numChildren == 0)
			{
				this.parent.removeChild(this);
			}
		}


		/**
		 * clean up the drag drop indicator
		 **/
		private function onDragExit(event:DragEvent):void
		{
			this.dockProxy.visible=false;
		}

		private function onDragDrop(event:DragEvent):void
		{
			this.dockProxy.visible=false;

			var dockEvent:DockViewEvent=new DockViewEvent(DockViewEvent.DOCKED);
			dockEvent.viewTab=ViewTab(event.dragInitiator);
			dockEvent.viewWindow=this;

			dispatchEvent(dockEvent);
			//dockEvent.targetViewWindow = this;
			//var targetViewWindow:ViewWindow=null; //viewTab.getViewWindow();			
			//var borderLayout:String=null;

		/*

		   //			if (event.dragSource.hasFormat(ViewTab.FORMAT)) {
		   var dockView:ViewTab=event.dragInitiator as ViewTab;
		   var viewWindow:ViewWindow=dockView.getViewWindow();

		   //			var obj:DisplayObject = extended_TabNavigator(event.dragInitiator.parent.parent).removeChildAt(oldIndex);
		   var view:DisplayObject=viewWindow.removeChildAt(dockView.parent.getChildIndex(dockView)); //??
		   //this.getStageWindow().dockView
		   //this.getStageWindow().dockView
		   this.percentWidth=100;
		   this.percentHeight=100;

		   if (BorderLayout.CENTER == this.borderLayout)
		   {
		   var index:int=0; //TODO
		   this.addChildAt(view, index);
		   }
		   else
		   {

		   //					var parentSplitWindow:SplitWindow = null;

		   var displayObjectContainer:DisplayObjectContainer=this.parent as SplitWindow;

		   var newSplitWindowIndex:int=displayObjectContainer.getChildIndex(this);

		   //					if(displayObjectContainer.contains(viewWindow)) {
		   //
		   //					} else {

		   var newSplitWindow:SplitWindow=_splitWindowPool.checkOut();//new SplitWindow();
		   //					newSplitWindow.width = this.width;
		   //					newSplitWindow.height = this.height;

		   //					newSplitWindow.percentWidth = this.percentWidth;
		   //					newSplitWindow.percentHeight = this.percentHeight;

		   if (BorderLayout.EAST == this.borderLayout || BorderLayout.WEST == this.borderLayout)
		   {
		   newSplitWindow.horizontal=true;
		   //this.percentHeight = 100;
		   }
		   else
		   {
		   newSplitWindow.horizontal=false;
		   //this.percentWidth = 100;
		   }
		   var newViewWindow:ViewWindow=new ViewWindow();

		   //					newViewWindow.width = this.dockProxy.width;
		   //					newViewWindow.height = this.dockProxy.height;

		   //					var newViewWindownIndex:int = 0;

		   //
		   displayObjectContainer.addChildAt(newSplitWindow, newSplitWindowIndex);

		   //


		   if (BorderLayout.EAST == this.borderLayout || BorderLayout.SOUTH == this.borderLayout)
		   {
		   //						newViewWindownIndex = 1;
		   newSplitWindow.addChild(this);
		   newSplitWindow.addChild(newViewWindow);
		   }
		   else
		   {
		   newSplitWindow.addChild(newViewWindow);
		   newSplitWindow.addChild(this);
		   }

		   newViewWindow.addChild(view);
		   //					Alert.show(""+viewWindow.numChildren );
		   //dispatchEvent viewWindowWith No numChildren close();


		   //					newViewWindow.percentWidth = 100;
		   //					newViewWindow.percentHeight = 100;
		   //					}
		   }


		   //				if(viewWindow.numChildren == 0) {
		   //					var splitWindow:SplitWindow = viewWindow.parent as SplitWindow;
		   //
		   //					var splitWindowParent:DisplayObjectContainer = splitWindow.parent as DisplayObjectContainer;
		   //
		   //					splitWindow.removeChild(viewWindow);
		   //
		   //					if(splitWindow.numChildren == 0) {
		   //					} else if(splitWindow.numChildren == 1) {
		   //						splitWindowParent.addChildAt(splitWindow.getChildAt(0), splitWindowParent.getChildIndex(splitWindow));
		   //					}
		   //					splitWindowParent.removeChild(splitWindow);
		   //				}

		   //				this.selectedIndex = 0;
		   dockProxy.visible=false;
		   this.getStageWindow().docking=false;
		   //			}
		   dispatchEvent(new DockEvent(DockEvent.DOCKED, true, true));
		   //			var ViewEvent:ViewEvent = new ViewEvent(ViewEvent.DOCKED, true, true);
		   //			ViewEvent.target = viewWindow;
		   //			dispatchEvent(ViewEvent);
		 */
		}


		/**
		 * when dragged (even between navigators) if the format is correct
		 * move the tab to the new parent and location if the target is the
		 * navigator then the new tab is inserted at location 0.
		 **/
		private function handleTabDragDrop(event:DragEvent):void
		{

			//			if(event.dragInitiator.parent.parent is extended_TabNavigator){		
			//				if (event.dragSource.hasFormat('tabButton')) {
			//					var oldIndex:int = event.dragInitiator.parent.getChildIndex(DisplayObject(event.dragInitiator));
			//    	        	var newIndex:int 
			//    	        	
			//    	        	if (event.target is extended_Tab){
			//    	        		newIndex= event.target.parent.getChildIndex(event.target);
			//    	        	}
			//    	        	else{
			//    	        		newIndex=0;
			//    	        		tabDropIndicator.visible=false;
			//    	        	}
			//	            	
			//	            	var obj:DisplayObject = extended_TabNavigator(event.dragInitiator.parent.parent).removeChildAt(oldIndex);
			//					addChildAt(obj,newIndex);
			//	            	
			//					//validate the visible items for the tab bar.
			//					extended_TabBar(tabBar).validateVisibleTabs();
			//					
			//				}
			//            }


		}


		private function onDock(event:ItemClickEvent):void
		{
			//			var contactForm:ContactForm = new ContactForm();
			//                PopUpManager.addPopUp(contactForm, this, true);

			event.stopPropagation();
			event.preventDefault();
			//			Alert.show('Text Copied!');




			var rectangle:Rectangle=getRealRect();

			dockProxy.width=rectangle.width;
			dockProxy.height=rectangle.height;
			dockProxy.move(rectangle.x, rectangle.y);
			this.getStageWindow().docking=true;
			this.getStageWindow().dockView=event.target as DisplayObject;
			//			this.dockProxyPopUped = true;
			//			PopUpManager.addPopUp(dockProxy, this, false);
		}


		private function onMinimize(event:MouseEvent):void
		{
			event.stopImmediatePropagation();

//			maximizeButton.styleName="restoreButton";
//			maximizeButton.removeEventListener(MouseEvent.MOUSE_DOWN, onMaximize);
//			maximizeButton.addEventListener(MouseEvent.MOUSE_DOWN, onRestore);
//
//			titleBar.removeEventListener(MouseEvent.DOUBLE_CLICK, onMaximize);
//			titleBar.addEventListener(MouseEvent.DOUBLE_CLICK, onRestore);

			var dockViewEvent:DockViewEvent=new DockViewEvent(DockViewEvent.MINIMIZE);
			dispatchEvent(dockViewEvent);			
		}

		private function onRestore(event:MouseEvent):void
		{
			maximizeButton.styleName="maximizeButton";
			maximizeButton.removeEventListener(MouseEvent.MOUSE_DOWN, onRestore);
			maximizeButton.addEventListener(MouseEvent.MOUSE_DOWN, onMaximize);


			titleBar.removeEventListener(MouseEvent.DOUBLE_CLICK, onRestore);
			titleBar.addEventListener(MouseEvent.DOUBLE_CLICK, onMaximize);

		}

		private function onMaximize(event:MouseEvent):void
		{

			//			event.stopImmediatePropagation();

			maximizeButton.styleName="restoreButton";
			maximizeButton.removeEventListener(MouseEvent.MOUSE_DOWN, onMaximize);
			maximizeButton.addEventListener(MouseEvent.MOUSE_DOWN, onRestore);

			titleBar.removeEventListener(MouseEvent.DOUBLE_CLICK, onMaximize);
			titleBar.addEventListener(MouseEvent.DOUBLE_CLICK, onRestore);

			var dockViewEvent:DockViewEvent=new DockViewEvent(DockViewEvent.MAXIMIZE);
			dispatchEvent(dockViewEvent);


			//   	 	dispatchEvent(new CollapsableTitleWindowEvent(CollapsableTitleWindowEvent.MAXIMIZE, true, true));		
		}

		private var boundsBeforeMaximize:Rectangle=new Rectangle();

		private function onViewClosed(event:ItemClickEvent):void
		{
			event.stopPropagation();
			event.preventDefault();

			//cleanup
			var object:DisplayObject=removeChildAt(event.index);
			object=null;

			//dispatch event so other actions can be taken
			var closeViewEvent:ItemClickEvent=new ItemClickEvent("CloseClick"); //TO extenSion
			closeViewEvent.index=event.index;
			closeViewEvent.item=event.item;
			closeViewEvent.label=event.label;
			closeViewEvent.relatedObject=event.relatedObject;
			dispatchEvent(closeViewEvent);
		}

		public function onViewRemoving(event:DockViewEvent):void
		{
			if (this.numChildren == 0)
			{
				this.parent.removeChild(this);
					//				var splitWindow:SplitWindow = this.parent as SplitWindow;
					//				
					//				var splitWindowParent:DisplayObjectContainer = splitWindow.parent as DisplayObjectContainer;
					//				
					//				splitWindow.removeChild(this);
					//				
					//				if(splitWindow.numChildren == 0) {	
					//				} else if(splitWindow.numChildren == 1) {
					//					splitWindowParent.addChildAt(splitWindow.getChildAt(0), splitWindowParent.getChildIndex(splitWindow));
					//				}
					//				splitWindowParent.removeChild(splitWindow);
					//				

			}

		}

		override public function removeChildAt(index:int):DisplayObject
		{
			//
			var object:DisplayObject=removeChild(getChildAt(index));

			dispatchEvent(new DockViewEvent(DockViewEvent.REMOVING, true, true));

			return object;

		/*

		   Shouldn't implement removeChildAt() in terms of removeChild().

		 */
		}

		override public function drawFocus(isFocused:Boolean):void
		{

			super.drawFocus(isFocused);

		}

		private function getStageWindow():StageWindow
		{
			var object:DisplayObject=this;
			while (!(object is StageWindow))
			{
				object=object.parent;
			}
			return StageWindow(object);
		}






		public function get dragEnabled():Boolean
		{
			if (tabBar)
			{
				return (tabBar as ViewTabBar).dragEnabled;
			}
			else
			{
				return _dragEnabled;
			}
		}

		public function set dragEnabled(value:Boolean):void
		{
			_dragEnabled=value;

			if (tabBar)
			{
				(tabBar as ViewTabBar).dragEnabled=value;
			}
		}


		public function doClose():void
		{

		}

		public function doMinimize():void
		{

		}

		public function doMaximize():void
		{

		}

		public function doRestore():void
		{

		}

		public function doDetached():void
		{

		}

		public function doDock():void
		{

		}


		//		private function onChildRemove(event:ChildExistenceChangedEvent):void
		//   		{
		//   			if(this.numChildren == 0) {
		//				this.parent.removeChild(this);//TODO Editor
		//				
		//			}
		//			dispatchEvent(new ViewEvent(ViewEvent.CHILD_REMOVE, true, true));
		//   		}
		//		private var _startScrollingEvent:String = MouseEvent.MOUSE_OVER;
		//		
		//		public function get startScrollingEvent():String {
		//			if(canvas) {
		//				return canvas.startScrollingEvent;
		//			}
		//			else {
		//				return _startScrollingEvent;
		//			}
		//		}
		//		
		//		public function set startScrollingEvent(value:String):void {
		//			_startScrollingEvent = value;
		//			if(canvas) {
		//				canvas.startScrollingEvent = value;
		//			}
		//		}
		//		
		//		private var _stopScrollingEvent:String = MouseEvent.MOUSE_OVER;
		//		
		//		public function get stopScrollingEvent():String {
		//			if(canvas) {
		//				return canvas.stopScrollingEvent;
		//			}
		//			else {
		//				return _stopScrollingEvent;
		//			}
		//		}
		//		
		//		public function set stopScrollingEvent(value:String):void {
		//			_stopScrollingEvent = value;
		//			canvas.stopScrollingEvent = value;
		//		}
		//		
		//		private var _scrollSpeed:Number = 100;
		//		
		//		public function set scrollSpeed(value:Number):void {
		//			if(canvas) {
		//				canvas.scrollSpeed = value;
		//			}
		//			_scrollSpeed = value;	
		//		}
		//		
		//		public function get scrollSpeed():Number {
		//			if(canvas) return canvas.scrollSpeed;
		//			return _scrollSpeed;
		//		}
	}

	//	
	//	class WindowButton extends Sprite
	//	{
	//		protected function WindowButton()
	//		{
	//			this.maximizeButton.useHandCursor = true;
	//			this.maximizeButton.buttonMode = true;
	//		}
	//	}
	//	
	//	class MinimizeButton extends WindowButton
	//	{
	//		
	//	}
	//	
	//	class MaximizeButton extends WindowButton
	//	{
	//		protected function drawOver(maximized:Boolean):void{
	//			
	//		}
	//		
	//		public function draw(maximized:Boolean):void{
	//   	 		
	//   	 		var col:Number;
	//   	 		
	//   	 		if(active == true){
	//   	 			col = buttonColor;
	//   	 		}else{
	//   	 			col = buttonInactiveColor;
	//   	 		}
	//   	 		
	//   	 		var g:Graphics = maximizeButton.graphics;
	//   	 		
	//   	 		g.clear();   	 		
	//   	 		g.lineStyle(1, col);
	//
	//			if(type == 0){
	//				g.drawRect(0,0,10,10);
	//				g.moveTo(0,1);
	//				g.lineTo(10,1);
	//			}else if(type == 1){
	//				g.drawRect(0,5,7,5);
	//				g.moveTo(0, 4);
	//				g.lineTo(8, 4);
	//				
	//				g.drawRect(3,2,7,5);
	//				g.moveTo(3, 1);
	//				g.lineTo(11, 1);
	//			}
	//			
	//			g.lineStyle();
	//			g.beginFill(0xFFFFFF, 0.01);
	//   	 		g.drawRect(0,0,10,10);
	//
	//   	 }
	//	}
}



