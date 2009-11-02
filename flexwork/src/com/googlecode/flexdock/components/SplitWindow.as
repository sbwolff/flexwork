package com.googlecode.flexdock.components
{

	
import com.googlecode.flexdock.events.DockViewEvent;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;

import mx.containers.BoxDirection;
import mx.containers.DividedBox;
import mx.core.ScrollPolicy;
import mx.core.UIComponent;

	/** A window with a split pane that contains two child dock windows */
	public class SplitWindow extends DividedBox implements DockWindow
	{

		private static const DIVIDER_LOCATION:int=50;

		/** 0~100 precent of location */
		private var _dividerLocation:int=DIVIDER_LOCATION;

		public function SplitWindow()
		{
			super();

			/* common */ /* effects */ /* events */
			this.addEventListener(DockViewEvent.DOCKED, onViewDocked);
			this.addEventListener(DockViewEvent.REMOVED, onViewRemoved);
			//			this.addEventListener(ViewEvent.CHILD_REMOVE, onChildRemove);

			/* size */ /* styles */
			this.setStyle("verticalGap", 3);
			this.setStyle("horizontalGap", 3);
			this.setStyle("verticalAlign", "middle");


			this.setStyle("horizontalAlign", "center");
			this.setStyle("dividerAlpha", 0);
			//			this.setStyle("dividerColor", 0x000000);

			//this.styleName="splitWindow";
			//.splitWindow {
			//	verticalGap: 2;
			//	horizontalGap: 3;
			//	verticalAlign: "middle";
			//	horizontalAlign: "center";
			/*borderColor: #0000FF;
			   borderThickness: 2;
			 borderStyle: solid;*/
			//}
			/* other */


			this.percentWidth=100;

			this.percentHeight=100;




			this.liveDragging=true;

			this.resizeToContent=true;

			horizontalScrollPolicy=ScrollPolicy.OFF;
			verticalScrollPolicy=ScrollPolicy.OFF;

			//this.direction = BoxDirection.HORIZONTAL;
		}


		override public function initialize():void
		{
			super.initialize();
		}

		override protected function createChildren():void
		{
			super.createChildren();
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

		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			//			var idx:uint;
			//            var len:uint = this.numDividers;
			//            for (idx = 0; idx < len; idx++) {
			//                this.getDividerAt(idx).visible = false;
			//            }			
		}



		public function onViewRemoved(event:DockViewEvent):void
		{
			var splitWindowParent:DisplayObjectContainer=this.parent as DisplayObjectContainer;
			if (!(splitWindowParent is StageWindow))
			{
				if (this.numChildren < 2)
				{
					if (this.numChildren == 1)
					{
						//	var view:
						var displayObject:UIComponent=this.getChildAt(0) as UIComponent;
						displayObject.percentWidth=100;
						displayObject.percentHeight=100;
						splitWindowParent.addChildAt(displayObject, splitWindowParent.getChildIndex(this));
					}
					splitWindowParent.removeChild(this);
				}
			}

		}

//		public function addViewWindow(viewWindow:ViewWindow, borderLayoutPosition:BorderLayoutPosition):void {
//			if(null==borderLayoutPosition) {
//				this.add
//			} else {
//				
//			}
//		}


		public function set horizontal(horizontal:Boolean):void
		{
			if (horizontal)
			{
				this.direction=BoxDirection.HORIZONTAL;
			}
			else
			{
				this.direction=BoxDirection.VERTICAL;
			}
		}

		public function get horizontal():Boolean
		{
			if (BoxDirection.HORIZONTAL == direction)
			{
				return true;
			}
			return false;
		}


		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			//	    	var uiComponent:UIComponent = child as UIComponent;
			//	    	uiComponent.percentWidth = 100;
			//	    	uiComponent.percentHeight = 100;
			var displayObject:DisplayObject=super.addChildAt(child, index);
			return displayObject;
		}

		private function onViewDocked(event:DockViewEvent):void
		{
			if (this.numChildren == 1)
			{
				this.parent.addChild(this.getChildAt(0));
				this.parent.removeChild(this);
			}
		}

		private function onChildRemove(event:DockViewEvent):void
		{
			if (this.numChildren == 0)
			{
				this.parent.removeChild(this); //TODO Editor				
			}
			if (this.numChildren == 1)
			{
				this.parent.addChild(this.getChildAt(0));
				this.parent.removeChild(this);
			}
		}


		public function set dividerLocation(value:int):void
		{
			if (value < 0 || value > 100)
			{
				value=DIVIDER_LOCATION;
			}
			this._dividerLocation=value;
		}

		public function get dividerLocation():int
		{
			return this._dividerLocation;
		}

	}
}