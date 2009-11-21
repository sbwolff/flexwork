package com.googlecode.flexdock.components
{
	import com.googlecode.flexdock.events.DockViewEvent;
	import com.googlecode.flexdock.utils.BorderLayout;
	import com.googlecode.flexdock.utils.BorderLayoutPosition;
	import com.googlecode.flexdock.views.DockView;
	
	import flash.display.DisplayObject;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.containers.BoxDirection;
	import mx.containers.VBox;
	import mx.core.Container;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	import org.springextensions.actionscript.context.IApplicationContext;

	/**
	 *
	 */
	 //TODO:this.focusManager.setFocus(consoleView);
	public class StageWindow extends VBox
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

		/**
		 *  @public
		 *  reference to FastViewBar
		 */
		public var fastViewBar:FastViewBar=null;

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
			this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
			this.addEventListener(DockViewEvent.DOCKED, onDockViewDocked);
			this.addEventListener(DockViewEvent.MAXIMIZE, onDockViewMaximize);
			this.addEventListener(DockViewEvent.MINIMIZE, onDockViewMinimize);

			/** size */
			this.percentWidth=100;
			this.percentHeight=100;

			/** styles */
			//this.styleName="stageWindow";
			setStyle("borderColor", 0xECE9D8); //0xACA899
			setStyle("borderThickness", 2);
			setStyle("borderStyle", "solid");
			setStyle("backgroundColor", 0xECE9D8);
			//setStyle("backgroundAlpha", 0.5);

			/** other */
			//_splitWindowPool=new SplitWindowPool();//TODO
		}

		private function onDockViewMinimize(event:DockViewEvent):void
		{
			var minimizingViewWindow:ViewWindow=event.target as ViewWindow;

			var parentSplitWindow:SplitWindow=minimizingViewWindow.parent as SplitWindow;
			
			var borderLayoutPosition:BorderLayoutPosition = describeLayoutPosition(minimizingViewWindow, null);
			
			minimizingViewWindow.borderLayoutPosition=borderLayoutPosition;
			
			this.fastViewBar.addViewWindow(minimizingViewWindow, this);

			parentSplitWindow.removeChild(minimizingViewWindow);

			removeOriginalSplitWindow(parentSplitWindow);
		}
		
		public function addViewWindow(viewWindow:ViewWindow, borderLayoutPosition:BorderLayoutPosition):void {
			var rootSplitWindow: SplitWindow =this.getChildAt(0) as SplitWindow;
//			rootSplitWindow.addViewWindow(viewWindow, borderLayoutPosition);
			var nextBorderLayoutPosition:BorderLayoutPosition=borderLayoutPosition;
			var nextSplitWindow:SplitWindow=rootSplitWindow;			
			while(null!=nextBorderLayoutPosition) {
				
				if(nextSplitWindow.numChildren==2) {
					
					if(//
					(nextSplitWindow.horizontal && nextBorderLayoutPosition.horizontal())//
					||//
					(!nextSplitWindow.horizontal && nextBorderLayoutPosition.vertical())//
					) {
						var nextChildWindow:DisplayObject= nextSplitWindow.getChildAt(nextBorderLayoutPosition.childIndex());
						if(nextChildWindow is SplitWindow) {
							nextBorderLayoutPosition = nextBorderLayoutPosition.nextBorderLayoutPosition;
							nextSplitWindow = nextChildWindow as SplitWindow;
							continue;
						}
					}
				}
				break;
			}
			//
			var borderLayout:String = BorderLayout.EAST;
			if(null!=nextBorderLayoutPosition) {
				borderLayout=nextBorderLayoutPosition.borderLayout;
			}
//			this.addViewWindow(
//			nextSplitWindow.			
		}
		
		private function describeLayoutPosition(targetDisplayObject:DisplayObject, nextBorderLayoutPosition:BorderLayoutPosition=null):BorderLayoutPosition {
			if(targetDisplayObject.parent is SplitWindow) {
				var parentSplitWindow:SplitWindow = targetDisplayObject.parent as SplitWindow;
				var tempBorderLayout:String = BorderLayout.CENTER;
				if(parentSplitWindow.numChildren==1) {
					tempBorderLayout=BorderLayout.CENTER;
				} else if(parentSplitWindow.numChildren==2) {				
					var childIndex:int = parentSplitWindow.getChildIndex(targetDisplayObject);
					if(true==parentSplitWindow.horizontal) {
						if(childIndex==0) {
							tempBorderLayout=BorderLayout.WEST;
						} else if(childIndex==1) {
							tempBorderLayout=BorderLayout.EAST;
						} else {
							//throw error 
						}
					} else {
						if(childIndex==0) {
							tempBorderLayout=BorderLayout.NORTH;
						} else if(childIndex==1) {
							tempBorderLayout=BorderLayout.SOUTH;
						} else {
							//throw error 
						}
					}
				} else {
					//throw error 
				}
				var borderLayoutPosition:BorderLayoutPosition =new BorderLayoutPosition();
				borderLayoutPosition.borderLayout=tempBorderLayout;
				borderLayoutPosition.nextBorderLayoutPosition=nextBorderLayoutPosition;
				return describeLayoutPosition(parentSplitWindow, borderLayoutPosition);
			}			
			return nextBorderLayoutPosition;
		}
		
		private var restoreLayoutAfterMaximize:XML;
	
		private function onDockViewMaximize(event:DockViewEvent):void
		{
			//
			restoreLayoutAfterMaximize = describeLayout();
			trace(restoreLayoutAfterMaximize.toXMLString());
			//
			var maximizingViewWindow:ViewWindow=event.target as ViewWindow;
			minimizeViewWindow(false, this, maximizingViewWindow);
			this.removeAllChildren();
			//doMinimizeOthers();
			maximizingViewWindow.percentWidth=100;
			maximizingViewWindow.percentHeight=100;
			this.addChildAt(maximizingViewWindow, 0);

			//			this.visible=true;
			//			this.getStageWindow().addChild(this);
			//			//   	 		this.isPopUp = true;
			//			//   	 				
			//			//   	 		setMaximizeActive(true, 1);   	 		
			//			//   	 		setResizeActive(false);
			//			//   	 		setDragDropActive(false);
			//			//   	 		
			//			boundsBeforeMaximize.x=x;
			//			boundsBeforeMaximize.y=y;
			//			boundsBeforeMaximize.width=width;
			//			boundsBeforeMaximize.height=height;
			//
			//			x=0;
			//			y=0;
			//			width=getStageWindow().width - 4;
			//			height=getStageWindow().height - 4;
			//			visible=true;
			//			//this.isPopUp = true;
			//			_maximized=true;

		}


		private function minimizeViewWindow(visiableValue:Boolean, parentWindow:UIComponent, target:ViewWindow):void
		{
			var n:int=parentWindow.numChildren;

			var displayObject:DisplayObject=null;

			for (var i:int=0; i < n; i++)
			{
				displayObject=parentWindow.getChildAt(i);
				if (displayObject is SplitWindow)
				{
					minimizeViewWindow(visiableValue, UIComponent(displayObject), target);
				}
				else if (displayObject is ViewWindow && displayObject != target)
				{
					if (null != this.fastViewBar)
					{
						this.fastViewBar.addViewWindow(ViewWindow(displayObject), this);
					}
				}
			}
		}

		private function onCreationComplete(event:FlexEvent):void
		{

		}

		private function removeOriginalSplitWindow(originalSplitWindow:SplitWindow):void
		{

			if (1 == originalSplitWindow.numChildren) /* definitlly == 1 */
			{
				var brotherWindow:Container=originalSplitWindow.getChildAt(0) as Container; /*ViewWindow or SplitWindow*/
				//

				if (this == originalSplitWindow.parent && brotherWindow is ViewWindow)
				{
					//do nothing
				}
				else
				{

					brotherWindow.width=originalSplitWindow.width;
					brotherWindow.height=originalSplitWindow.height;
					brotherWindow.percentWidth=originalSplitWindow.percentWidth;
					brotherWindow.percentHeight=originalSplitWindow.percentHeight;

					var tempParent:UIComponent=originalSplitWindow.parent as UIComponent;

					var index:int=tempParent.getChildIndex(originalSplitWindow);

					tempParent.removeChild(originalSplitWindow);
					originalSplitWindow=null;
					//					

					tempParent.addChildAt(brotherWindow, index);
					tempParent=null;
				}


			}
		}

		private function removeOriginalSplitWindowIfNecessery(originalSplitWindow:SplitWindow, originalViewWindow:ViewWindow):void
		{
			if (0 == originalViewWindow.numChildren)
			{
				//originalSplitWindow.removeChild(originalViewWindow);/*??*/
				originalViewWindow=null;

				removeOriginalSplitWindow(originalSplitWindow);
			}	
		}
		
		
		public function describeLayout():XML
		{
			var layoutXml:XML = <layout />;
			
			describeWindowLayout(layoutXml, this.getChildren());
						
			return layoutXml;
		}

		public function describeWindowLayout(parentXml:XML, children:Array):void
		{
			if(null!=children) {
				var object:UIComponent;
				var xml:XML;
				for(var i:int=0;i<children.length;i++) {				
					object=children[i] as UIComponent;
					
					if(object is SplitWindow) {
						var tempSplitWindow:SplitWindow=object as SplitWindow;
						//
						xml=<SplitWindow />;
						xml.@width = tempSplitWindow.percentWidth+"%";
						xml.@height = tempSplitWindow.percentHeight+"%";
						if(true==tempSplitWindow.horizontal) {
							xml.@direction = tempSplitWindow.direction;
						}
						//
						describeWindowLayout(xml, tempSplitWindow.getChildren());
					}	else if (object is ViewWindow) {
						var tempViewWindow:ViewWindow=object as ViewWindow;
						//
						xml=<ViewWindow />;						
						xml.@width = tempViewWindow.percentWidth+"%";
						xml.@height = tempViewWindow.percentHeight+"%";
						//
						describeWindowLayout(xml, tempViewWindow.getChildren());
					} else if(object is DockView) {
						xml=<View />;						
						var clazz:Class=Class(getDefinitionByName(getQualifiedClassName(object)));
						var objectNames:Array=this._applicationContext.getObjectNamesForType(clazz);
						for(var j:int=0;j<objectNames.length;j++) {
							var objectName:String = objectNames[j];
							if(object==this._applicationContext.getObject(objectName)){
								xml.@id =objectName ;
							}
						}
					}
					parentXml.appendChild(xml);
				}
			
			}
		}


		public function set applicationContext(value:IApplicationContext):void
		{
			this._applicationContext=value;
		}
		
		public function set splitWindowPool(value:SplitWindowPool):void
		{
			this._splitWindowPool=value;
		}

		private function addViewInNewSplitWindow(view:DisplayObject, //
			borderLayout:String, //
			targetViewWindow:ViewWindow):void
		{
			if (BorderLayout.CENTER == borderLayout)
			{
				var index:int=0;
				targetViewWindow.addChildAt(view, index);
			}
			else
			{
				var newSplitWindow:SplitWindow=_splitWindowPool.checkOut();//new SplitWindow();

				newSplitWindow.width=targetViewWindow.width;
				newSplitWindow.height=targetViewWindow.height;

				newSplitWindow.percentWidth=targetViewWindow.percentWidth;
				newSplitWindow.percentHeight=targetViewWindow.percentHeight;

				newSplitWindow.horizontal=(BorderLayout.EAST == borderLayout || BorderLayout.WEST == borderLayout) ? true : false;

				var newViewWindow:ViewWindow=new ViewWindow();
				newViewWindow.addChild(view);

				var displayObjectContainer:UIComponent=targetViewWindow.parent as UIComponent;
				var newSplitWindowIndex:int=displayObjectContainer.getChildIndex(targetViewWindow); //Alert(newSplitWindowIndex);		
				displayObjectContainer.removeChild(targetViewWindow);

				displayObjectContainer.addChildAt(newSplitWindow, newSplitWindowIndex);

				if ((SplitWindow(newSplitWindow.parent)).horizontal)
				{
					//				newSplitWindow.percentWidth =  50;	
					//				newSplitWindow.percentHeight = 100;
					//				} else {
					//						newSplitWindow.percentWidth =  100;	
					//				newSplitWindow.percentHeight = 50;			
				}





				if (true == newSplitWindow.horizontal)
				{
					newViewWindow.width=targetViewWindow.width=newSplitWindow.width / 2;
					newViewWindow.height=targetViewWindow.height=newSplitWindow.height;

					newViewWindow.percentWidth=targetViewWindow.percentWidth=50;

					newViewWindow.percentHeight=targetViewWindow.percentHeight=100;

				}
				else
				{
					newViewWindow.width=targetViewWindow.width=newSplitWindow.width;
					newViewWindow.height=targetViewWindow.height=newSplitWindow.height / 2;

					newViewWindow.percentWidth=targetViewWindow.percentWidth=100;

					newViewWindow.percentHeight=targetViewWindow.percentHeight=50;

				}


				if (BorderLayout.EAST == borderLayout || BorderLayout.SOUTH == borderLayout)
				{
					newSplitWindow.addChild(targetViewWindow);
					newSplitWindow.addChild(newViewWindow);
				}
				else
				{
					newSplitWindow.addChild(newViewWindow);
					newSplitWindow.addChild(targetViewWindow);
				}

			}



		}


		private function onDockViewDocked(event:DockViewEvent):void
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

						addViewInNewSplitWindow(DisplayObject(view), borderLayout, targetViewWindow);

					}


				}
				else /*originalViewWindow!=targetViewWindow */
				{
					view=originalViewWindow.removeChildAt(viewTab.parent.getChildIndex(viewTab));

					removeOriginalSplitWindowIfNecessery(originalSplitWindow, originalViewWindow);

					addViewInNewSplitWindow(DisplayObject(view), borderLayout, targetViewWindow);




				}

			}
			else
			{
				view=originalViewWindow.removeChildAt(viewTab.parent.getChildIndex(viewTab));

				removeOriginalSplitWindowIfNecessery(originalSplitWindow, originalViewWindow);

				addViewInNewSplitWindow(DisplayObject(view), borderLayout, targetViewWindow);
			}




			this.docking=false;
			//			}
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
						displayComponent=_splitWindowPool.checkOut();//new SplitWindow();
						SplitWindow(displayComponent).horizontal=(BoxDirection.HORIZONTAL == xml.@direction);
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
		//
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