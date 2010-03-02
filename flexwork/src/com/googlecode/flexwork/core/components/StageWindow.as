package com.googlecode.flexwork.core.components
{
	import com.googlecode.flexwork.core.events.DockingEvent;
	import com.googlecode.flexwork.core.layout.BorderLayout;
	import com.googlecode.flexwork.core.layout.BorderLayoutPosition;
	import com.googlecode.flexwork.core.layout.RestoreValueObject;
	
	import flash.display.DisplayObject;
	
	import mx.containers.VBox;
	import mx.core.Container;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	import org.springextensions.actionscript.context.IApplicationContext;

	/**
	 *
	 */
	//TODO:this.focusManager.setFocus(consoleView);
	
	//use namespace mx_internal;
	
	public class StageWindow extends VBox //extends Canvas 
	{
		/**
		 *  @public
		 *  flag of be docking
		 */
		public var docking:Boolean=false;

		/**
		 *  @public
		 * 	reference to DockView being docked
		 */
		public var dockView:DisplayObject=null;

		public var maximizedViewWindow:ViewWindow=null;
		
		public var rootSplitWindow:SplitWindow=null;

		/**
		 *  @public
		 *  reference to FastViewBar
		 */
		public var stageWindowBar:StageWindowBar=null;

		/**
		 *  @private
		 *  reference to IApplicationContext
		 */
		private var _applicationContext:IApplicationContext=null;
		//private var _applicationContext:XMLApplicationContext=null;
		/**
		 *  @private
		 *  reference to SplitWindowPool
		 */
		private var _splitWindowPool:SplitWindowPool;

		/**
		 *  Constructor
		 */
		public function StageWindow()
		{
			super();
			/** common */

			/** effects */

			/** events */			
			this.addEventListener(DockingEvent.DOCKED, onDockingViewDock);
			this.addEventListener(DockingEvent.MAXIMIZE, onDockingViewMaximize);
			this.addEventListener(DockingEvent.MINIMIZE, onDockingViewMinimize);

			/** size */
			this.percentWidth=100;
			this.percentHeight=100;

			/** styles */
			this.styleName="stageWindow";
//			setStyle("borderColor", 0xD4D0C8); //0xACA899
//			setStyle("borderThickness", 2);
//			setStyle("borderStyle", "solid");
//			setStyle("backgroundColor", 0xD4D0C8);
			//setStyle("backgroundAlpha", 0.5);

		/** other */
			//_splitWindowPool=new SplitWindowPool();//TODO
		}

		public function isMaximized():Boolean
		{
			return (null!=this.maximizedViewWindow);	
		}	

		private function getRootSplitWindow():SplitWindow
		{
			return this.getChildAt(0) as SplitWindow; 
		}
		
		private function isRootSplitWindow(splitWindow:SplitWindow):Boolean
		{
			return getRootSplitWindow()==splitWindow; 
		}

		protected function onDockingViewMinimize(event:DockingEvent):void
		{			
			var minimizingViewWindow:ViewWindow=event.target as ViewWindow;
			
			if(this.isMaximized()) {
				doRestoreMaximizedViewWindow();
			} else {
				minimizingViewWindow.saveOriginalSize();
			}
			doMinimizeViewWindow(minimizingViewWindow);
		}

		protected function doMinimizeViewWindow(minimizingViewWindow:ViewWindow):void
		{
			var parentSplitWindow:SplitWindow=minimizingViewWindow.parent as SplitWindow;

			minimizingViewWindow.borderLayoutPosition=describeLayoutPosition(minimizingViewWindow);			

			this.stageWindowBar.addViewWindow(minimizingViewWindow, this);

			parentSplitWindow.removeChild(minimizingViewWindow);

			removeSplitWindow(parentSplitWindow);
		}

		protected function describeLayoutPosition(targetDisplayObject:DisplayObject, nextBorderLayoutPosition:BorderLayoutPosition=null):BorderLayoutPosition
		{
			if (targetDisplayObject.parent is SplitWindow)
			{
				var parentSplitWindow:SplitWindow=targetDisplayObject.parent as SplitWindow;
				var tempBorderLayout:String=null;
				if (parentSplitWindow.numChildren == 1)
				{
					tempBorderLayout=BorderLayout.CENTER;
				}
				else if (parentSplitWindow.numChildren == 2)
				{
					var childIndex:int=parentSplitWindow.getChildIndex(targetDisplayObject);
					if (true == parentSplitWindow.isHorizontal())
					{
						if (childIndex == 0)
						{
							tempBorderLayout=BorderLayout.WEST;
						}
						else if (childIndex == 1)
						{
							tempBorderLayout=BorderLayout.EAST;
						}
						else
						{
							//throw error 
						}
					}
					else
					{
						if (childIndex == 0)
						{
							tempBorderLayout=BorderLayout.NORTH;
						}
						else if (childIndex == 1)
						{
							tempBorderLayout=BorderLayout.SOUTH;
						}
						else
						{
							//throw error 
						}
					}
				}
				else
				{
					//throw error 
				}
				var borderLayoutPosition:BorderLayoutPosition=new BorderLayoutPosition();
				borderLayoutPosition.borderLayout=tempBorderLayout;
				borderLayoutPosition.nextBorderLayoutPosition=nextBorderLayoutPosition;
				return describeLayoutPosition(parentSplitWindow, borderLayoutPosition);
			}
			return nextBorderLayoutPosition;
		}
		
		private function onDockingViewMaximize(event:DockingEvent):void
		{
			var maximizingViewWindow:ViewWindow=event.target as ViewWindow;
			maximizingViewWindow.saveOriginalSize();
			
			minimizeViewWindowsForMaximization(this, maximizingViewWindow);
			
			//doMinimizeOthers();
			maximizingViewWindow.percentWidth=100;
			maximizingViewWindow.percentHeight=100;
			
			var splitWindow:SplitWindow = maximizingViewWindow.parent as SplitWindow;
			removeSplitWindow(splitWindow);
						
			maximizingViewWindow.borderLayoutPosition=describeLayoutPosition(maximizingViewWindow);			
			
			this.rootSplitWindow=this.getRootSplitWindow();
			this.removeAllChildren();
			this.addChild(maximizingViewWindow);									
			this.maximizedViewWindow=maximizingViewWindow;
						
			this.removeEventListener(DockingEvent.MAXIMIZE, onDockingViewMaximize);			
			this.addEventListener(DockingEvent.RESTORE, onDockingViewRestore);			
		}

		private function minimizeViewWindowsForMaximization(parentComponent:UIComponent, exceptViewWindow:ViewWindow):void
		{
			var n:int=parentComponent.numChildren;

			var displayObject:DisplayObject=null;

			for (var i:int=0; i < n; i++)
			{
				displayObject=parentComponent.getChildAt(i);
				if (displayObject is SplitWindow)
				{
					minimizeViewWindowsForMaximization(UIComponent(displayObject), exceptViewWindow);
				}
				else if (displayObject is ViewWindow && displayObject != exceptViewWindow)
				{
					if (null != this.stageWindowBar)
					{
						this.stageWindowBar.addViewWindow(ViewWindow(displayObject), this, true);
					}
				}
			}
		}
		
		private function clearViewWindowsForMaximization():void {
			this.stageWindowBar.clearViewWindowsForMaximization();
		}		

		private function removeViewWindowIfNecessery(viewWindow:ViewWindow, splitWindow:SplitWindow):void
		{
			if (0 == viewWindow.numChildren)
			{				
//				var splitWindow:SplitWindow=SplitWindow(viewWindow.parent);
//				splitWindow.removeChild(viewWindow);
				removeSplitWindow(splitWindow);
				viewWindow=null;
				splitWindow=null;
			}
		}
		
		private function removeSplitWindow(splitWindow:SplitWindow):void
		{
			if (1 == splitWindow.numChildren) /* definitlly == 1 */
			{
				var brotherComponent:UIComponent=splitWindow.getChildAt(0) as UIComponent; /*ViewWindow or SplitWindow*/

				if (this == splitWindow.parent && brotherComponent is ViewWindow)
				{
					//root splitWindow & do nothing
				}
				else
				{
					brotherComponent.width=splitWindow.width;
					brotherComponent.height=splitWindow.height;
					brotherComponent.percentWidth=splitWindow.percentWidth;
					brotherComponent.percentHeight=splitWindow.percentHeight;

					var parentContainer:UIComponent=splitWindow.parent as UIComponent;

					var childIndex:int=parentContainer.getChildIndex(splitWindow);

					parentContainer.removeChild(splitWindow);
					splitWindow=null;
					
					parentContainer.addChildAt(brotherComponent, childIndex);
					parentContainer=null;
					brotherComponent=null;
				}
			}
		}
		
		private function onDockingViewRestore(event:DockingEvent):void
		{			
			var restoringViewWindow:ViewWindow=event.target as ViewWindow;
			fireRestoreViewWindow(restoringViewWindow);
		}
		
		public function fireRestoreViewWindow(restoringViewWindow:ViewWindow):void
		{
			var isMaximizedViewWindowRestoring:Boolean = false;			
			
			if(this.isMaximized()) {
				isMaximizedViewWindowRestoring = (this.maximizedViewWindow==restoringViewWindow);				
				doRestoreMaximizedViewWindow();
			}
			if(!isMaximizedViewWindowRestoring) {
				doRestoreViewWindow(restoringViewWindow);
				restoringViewWindow.clearOriginalSize();
			}
		}	
		
		private function doRestoreMaximizedViewWindow():void
		{
			var restoringViewWindow:ViewWindow = this.maximizedViewWindow;
			//
			this.removeChild(this.maximizedViewWindow);
			this.maximizedViewWindow=null;
			this.addChild(this.rootSplitWindow);
			this.rootSplitWindow=null;
			//
			doRestoreViewWindow(restoringViewWindow);
			clearViewWindowsForMaximization();
			//
			this.addEventListener(DockingEvent.MAXIMIZE, onDockingViewMaximize);
			this.removeEventListener(DockingEvent.RESTORE, onDockingViewRestore);
		}
	
		private function addView(view:DisplayObject, borderLayout:String, targetViewWindow:ViewWindow):void
		{
			if (BorderLayout.CENTER == borderLayout)
			{
				var index:int=0;//TODO
				targetViewWindow.addChildAt(view, index);
			}
			else
			{
				var newViewWindow:ViewWindow=new ViewWindow();
				newViewWindow.addChild(view);				
				insertViewWindow(newViewWindow, borderLayout, targetViewWindow);
			}
		}
					
		private function doRestoreViewWindow(restoringViewWindow:ViewWindow):void
		{
			var borderLayoutPosition:BorderLayoutPosition=restoringViewWindow.borderLayoutPosition;
			if (borderLayoutPosition)
			{
				var splitWindow:SplitWindow=this.getRootSplitWindow();

				var restoreValueObject:RestoreValueObject=new RestoreValueObject();
				restoreValueObject.borderLayoutPosition=borderLayoutPosition;
				restoreValueObject.displayObject=splitWindow;
				//
				restoreValueObject=locateRestoreViewWindow(restoreValueObject);
				//
				borderLayoutPosition=restoreValueObject.borderLayoutPosition;
				while (borderLayoutPosition.nextBorderLayoutPosition)
				{
					borderLayoutPosition=borderLayoutPosition.nextBorderLayoutPosition;
				}
				
				var brotherComponent:UIComponent=restoreValueObject.displayObject as UIComponent;
				
				this.insertViewWindow(restoringViewWindow, borderLayoutPosition.borderLayout, brotherComponent);
				
				restoringViewWindow.fireRestore();
				
				borderLayoutPosition=null;
			}
			else
			{
				//throw error
			}
		}

		private function locateRestoreViewWindow(restoreValueObject:RestoreValueObject):RestoreValueObject
		{
			var borderLayoutPosition:BorderLayoutPosition=restoreValueObject.borderLayoutPosition;
			var displayObject:DisplayObject=restoreValueObject.displayObject;

			if (borderLayoutPosition && borderLayoutPosition.nextBorderLayoutPosition && displayObject is SplitWindow)
			{
				var splitWindow:SplitWindow=displayObject as SplitWindow;

				if ( //
					(borderLayoutPosition.isHorizontal() && splitWindow.isHorizontal()) || (borderLayoutPosition.isVertical() && splitWindow.isVertical()))
				{
//					trace(borderLayoutPosition.childIndex());
					restoreValueObject.displayObject=splitWindow.getChildAt(borderLayoutPosition.childIndex());
					restoreValueObject.borderLayoutPosition=borderLayoutPosition.nextBorderLayoutPosition;

					return locateRestoreViewWindow(restoreValueObject);
				}
			}
			return restoreValueObject;
		}

		private function onDockingViewDock(event:DockingEvent):void
		{
			//			if (event.dragSource.hasFormat(ViewTab.FORMAT)) {
			var viewTab:ViewTab=event.viewTab; //TODO: event.dragInitiator as ViewTab;
			var originalViewWindow:ViewWindow=viewTab.getViewWindow();
			var targetViewWindow:ViewWindow=event.viewWindow; //viewTab.getViewWindow();			
			var borderLayout:String=targetViewWindow.borderLayout;
			//var view:View = viewTab.getViewWindow()null;//TODO: event.dragInitiator as ViewTab;

			var originalSplitWindow:SplitWindow=SplitWindow(originalViewWindow.parent);
			var targetSplitWindow:SplitWindow=SplitWindow(targetViewWindow.parent);
			var view:DisplayObject=null;

			if (originalSplitWindow == targetSplitWindow)
			{
				if (originalViewWindow == targetViewWindow)
				{
					if (BorderLayout.CENTER == borderLayout)
					{
						/*do nothing: TODO:move view index */
					}
					else
					{
						view=originalViewWindow.removeChildAt(viewTab.parent.getChildIndex(viewTab));
						addView(DisplayObject(view), borderLayout, targetViewWindow);
					}
				}
				else /*originalViewWindow!=targetViewWindow */
				{
					view=originalViewWindow.removeChildAt(viewTab.parent.getChildIndex(viewTab));
					removeViewWindowIfNecessery(originalViewWindow, originalSplitWindow);
					addView(DisplayObject(view), borderLayout, targetViewWindow);
				}
			}
			else
			{
				view=originalViewWindow.removeChildAt(viewTab.parent.getChildIndex(viewTab));
				removeViewWindowIfNecessery(originalViewWindow, originalSplitWindow);
				addView(DisplayObject(view), borderLayout, targetViewWindow);
			}
			this.docking=false;
			event.stopImmediatePropagation();
			event=null;
		}

		//		public function openPerspective(perspectiveName:String):void
		//		{
		//			this.removeAllChildren(); //TODO release viewWindow(pool)
		//			var xmlList:XMLList=perspectives.perspective.(@name == perspectiveName);
		//			//var perspective:XML = xmlList;
		//			buildPerspective(xmlList, UIComponent(this));
		//		}

		public function openPerspective(perspectiveXml:XML):void
		{
			this.removeAllChildren(); //TODO release viewWindow(pool)			
			buildPerspective(perspectiveXml, UIComponent(this));
			this.stageWindowBar.clearViewWindows();
		}

		private function buildPerspective(parentXml:*, parentComponent:UIComponent):void
		{
			var xmlList:XMLList=parentXml.children();
			if (xmlList.length() > 0)
			{
				var displayComponent:UIComponent=null;
				//var xml:XML = null;
				//for(var i:int=0;i<xmlList.length();i++) {
				for each (var xml:XML in xmlList)
				{
					displayComponent=null;

					//xml = xmlList[i];
					if ("SplitWindow" == xml.name())
					{
						displayComponent=_splitWindowPool.checkOut(); //new SplitWindow();
						SplitWindow(displayComponent).setDirection(xml.@direction);
						
					}
					else if ("ViewWindow" == xml.name())
					{
						displayComponent=new ViewWindow();
					}
					else if ("View" == xml.name())
					{
						displayComponent=_applicationContext.getObject(xml.@id) as UIComponent;
					}
					if (null != displayComponent)
					{
						displayComponent.width=NaN;
						displayComponent.height=NaN;

						if (xml.hasOwnProperty("@width"))
						{
							var widthStr:String=xml.@width;
							if (widthStr.indexOf("%") == widthStr.length - 1)
							{
								displayComponent.percentWidth=new Number(widthStr.substr(0, widthStr.length - 1));
							}
							else
							{
								displayComponent.width=new Number(widthStr);
							}

						}
						if (xml.hasOwnProperty("@height"))
						{
							var heightStr:String=xml.@height;
							if (heightStr.indexOf("%") == heightStr.length - 1)
							{
								displayComponent.percentHeight=new Number(heightStr.substr(0, heightStr.length - 1));
							}
							else
							{
								displayComponent.height=new Number(heightStr);
							}

						}
						this.buildPerspective(xml, displayComponent); //do first?
						parentComponent.addChild(displayComponent);
					}
				}

			}
		}
		
		/**
		 * insert view window into binary tree
		 * targetViewWindow: the view window to be inserted
		 * targetBrotherComponent: the brother Component of targetViewWindow after insertion
		 */
		protected function insertViewWindow(targetViewWindow:ViewWindow, borderLayout:String, targetBrotherComponent:UIComponent):void
		{
			var splitWindow:SplitWindow=_splitWindowPool.checkOut(); //new SplitWindow();
			
			splitWindow.width=targetBrotherComponent.width;
			splitWindow.height=targetBrotherComponent.height;

			splitWindow.percentWidth=targetBrotherComponent.percentWidth;
			splitWindow.percentHeight=targetBrotherComponent.percentHeight;
			
			splitWindow.direction = BorderLayout.toDirection(borderLayout);
			
			var parentComponent:UIComponent=targetBrotherComponent.parent as UIComponent;
			var splitWindowIndex:int=parentComponent.getChildIndex(targetBrotherComponent);
			parentComponent.removeChild(targetBrotherComponent);
			
			parentComponent.addChildAt(splitWindow, splitWindowIndex);
			
			if (true == splitWindow.isHorizontal())
			{
				if(targetViewWindow.originalWidth>0) {
					targetViewWindow.width=(splitWindow.width > targetViewWindow.originalWidth) ? targetViewWindow.originalWidth : splitWindow.width / 2;
					targetViewWindow.percentWidth=(targetViewWindow.width/splitWindow.width) * 100;
					
					//targetBrotherComponent.width=splitWindow.width-targetViewWindow.width;
					targetBrotherComponent.percentWidth=100-targetViewWindow.percentWidth;
				} else {
					targetViewWindow.width=targetBrotherComponent.width=splitWindow.width / 2;
					targetViewWindow.percentWidth=targetBrotherComponent.percentWidth=50;	
				}
				
				targetViewWindow.height=targetBrotherComponent.height=splitWindow.height;
				targetViewWindow.percentHeight=targetBrotherComponent.percentHeight=100;
			}
			else
			{
				targetViewWindow.width=targetBrotherComponent.width=splitWindow.width;
				targetViewWindow.percentWidth=targetBrotherComponent.percentWidth=100;
				
				if(targetViewWindow.originalHeight>0) {
					targetViewWindow.height=(splitWindow.height > targetViewWindow.originalHeight) ? targetViewWindow.originalHeight : splitWindow.height / 2;
					targetViewWindow.percentHeight=(targetViewWindow.height/splitWindow.height)*100;
					
					//targetBrotherComponent.height=splitWindow.height-targetViewWindow.height;
					targetBrotherComponent.percentHeight=100-targetViewWindow.percentHeight;					
				} else {
					targetViewWindow.height=targetBrotherComponent.height=splitWindow.height / 2;
					targetViewWindow.percentHeight=targetBrotherComponent.percentHeight=50;
				}
			}
			splitWindow.addChild(targetBrotherComponent);
			splitWindow.addChildAt(targetViewWindow, BorderLayout.childIndex(borderLayout));			
		}

		public function set applicationContext(value:IApplicationContext):void
		{
			this._applicationContext=value;
		}

		public function set splitWindowPool(value:SplitWindowPool):void
		{
			this._splitWindowPool=value;
		}
		
		//		public function set perspectiveManager(value:PerspectiveManager):void
		//		{
		//			this._perspectiveManager=value;
		//		}
		//
		//		public function get perspectiveManager():PerspectiveManager
		//		{
		//			return this._perspectiveManager;
		//		}
	}
}