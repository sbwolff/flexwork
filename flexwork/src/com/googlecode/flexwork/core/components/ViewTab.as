package com.googlecode.flexwork.core.components
{
	import com.googlecode.flexwork.core.events.DockingEvent;
	import com.googlecode.flexwork.core.components.DockingView;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.text.*;
	
	import mx.containers.*;
	import mx.controls.*;
	import mx.controls.tabBarClasses.Tab;
	import mx.core.*;
	import mx.events.*;
	import mx.managers.*;

	/**
	 *
	 */
	public class ViewTab extends Tab
	{
		public static const EVENT_DOCK:String="dock";

		public static const FORMAT:String="ViewTab";
		/**
		 * Static variables indicating the policy to show the close button.
		 *
		 * CLOSE_ALWAYS means the close button is always shown
		 * CLOSE_SELECTED means the close button is only shown on the currently selected tab
		 * CLOSE_ROLLOVER means the close button is show if the mouse rolls over a tab
		 */
		public static const CLOSE_BUTTON_VISIBLE_SELECTED:String="close_button_visible_selected";

		public static const CLOSE_BUTTON_VISIBLE_ROLLOVER:String="close_button_visible_rollover";

		private var _closeButtonVisiblePolicy:String=CLOSE_BUTTON_VISIBLE_SELECTED;
		/* rollover state */
		private var _rollingOver:Boolean=false;

		private var closeButton:Button;

		public function ViewTab()
		{
			super();

			/* common */

			/* effects */

			/* events */
			this.mouseChildren=true; // We need to enabled mouseChildren so our closeButton can receive mouse events.
			this.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);

			/* size */

			/* styles */
			//this.styleName="viewTab";

			this.setStyle("fillColors", [0xFFFFFF, 0xD4D0C8]);
			this.setStyle("fillAlphas", [1, 1]);
			this.setStyle("borderStyle", "solid");
			this.setStyle("cornerRadius", 10);
			
			this.setStyle("borderThickness", 1);
//			this.setStyle("borderColor", 0xACA899);
//			this.setStyle("backgroundColor", 0xD4D0C8);

		/* other */
		}

		override protected function createChildren():void
		{
			super.createChildren();

			if (!closeButton)
			{
				closeButton=new Button();
				closeButton.name="closeButton"

				closeButton.mouseEnabled=true;
				closeButton.focusEnabled=false;

				closeButton.width=closeButton.height=10;
				closeButton.styleName="closeButton";

				closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
				addChild(closeButton);
			}

		}

		override protected function measure():void
		{
			super.measure();

			//			var textWidth:Number=0;
			//			//var vm:EdgeMetrics = this.v
			//			if (label)
			//			{
			//				var lineMetrics:TextLineMetrics=measureText(label);
			//				textWidth=lineMetrics.width;
			//			}
			//
			//			var w:Number=textWidth;
			//			var h:Number=0;

			//        var tempCurrentIcon:IFlexDisplayObject = getCurrentIcon();  
			//        var iconWidth:Number = tempCurrentIcon ? tempCurrentIcon.width : 0;
			//        var iconHeight:Number = tempCurrentIcon ? tempCurrentIcon.height : 0;
			//        var w:Number = 0;
			//        var h:Number = 0;
			//
			//        if (labelPlacement == ButtonLabelPlacement.LEFT ||
			//            labelPlacement == ButtonLabelPlacement.RIGHT)
			//        {
			//            w = textWidth + iconWidth;
			//            if (textWidth && iconWidth)
			//                w += getStyle("horizontalGap");
			//            h = Math.max(textHeight, iconHeight);
			//        }
			//        else
			//        {
			//            w = Math.max(textWidth, iconWidth);
			//            h = textHeight + iconHeight;
			//            if (textHeight && iconHeight)
			//                h += getStyle("verticalGap");
			//        }
			//
			//        // Add padding. !!!Need a hack here to only add padding if we don't
			//        // have text or icon. This is required to make small buttons (like scroll
			//        // arrows and numeric stepper buttons) look correct.
			//        if (textWidth || iconWidth)
			//        {
			//            w += getStyle("paddingLeft") + getStyle("paddingRight");
			//            h += getStyle("paddingTop") + getStyle("paddingBottom");
			//        }
			//        
			//        var bm:EdgeMetrics = currentSkin &&
			//                             currentSkin is IBorder && !(currentSkin is IFlexAsset) ?
			//                             IBorder(currentSkin).borderMetrics :
			//                             null;
			//        
			//        if (bm)
			//        {
			//            w += bm.left + bm.right;
			//            h += bm.top + bm.bottom
			//        }
			//        
			//        // Use the larger of the measured sizes and the skin's preferred sizes.
			//        // Each skin should override measure() with their measuredWidth
			//        // and measuredHeight.
			//        if (currentSkin && (isNaN(skinMeasuredWidth) || isNaN(skinMeasuredHeight)))
			//        {
			//            skinMeasuredWidth = currentSkin.measuredWidth;
			//            skinMeasuredHeight = currentSkin.measuredHeight;
			//        }
			//
			//        if (!isNaN(skinMeasuredWidth))
			//            w = Math.max(skinMeasuredWidth, w);
			//
			//        if (!isNaN(skinMeasuredHeight))
			//            h = Math.max(skinMeasuredHeight, h);

			//			measuredMinWidth=measuredWidth=measuredMinWidth + textWidth + 10;
			//			
			//			if(!closeButton.includeInLayout) {
			//				this.measuredWidth -= closeButton.width;
			//			}
			if (this.selected)
			{
				measuredMinWidth=measuredWidth+=closeButton.width;
			}
			// measuredMinHeight = measuredHeight = h;
		}

		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);

			// We need to make sure that the closeButton and the indicator are
			// above all other display items for this button. Otherwise the button
			// skin or icon or text are placed over the closeButton and indicator.
			// That's no good because then we can't get clicks and it looks funky.
			setChildIndex(closeButton, numChildren - 1);
			//this.visible = false;			
			closeButton.visible=false;
			closeButton.includeInLayout=false;

			if (this.selected)
			{
				closeButton.visible=true;
				closeButton.enabled=true;
			}
			else
			{
				if (this._rollingOver && this._closeButtonVisiblePolicy == ViewTab.CLOSE_BUTTON_VISIBLE_ROLLOVER)
				{
					closeButton.visible=true;
					closeButton.enabled=true;
					closeButton.includeInLayout=true;
				}
				else
				{
					closeButton.visible=false;
					closeButton.enabled=false;
				}
			}

			if (closeButton.visible)
			{
				var gap:int=(unscaledHeight - closeButton.height) / 2;
				closeButton.x=unscaledWidth - closeButton.width - gap;
				closeButton.y=gap;
			}
		}

		/**
		 * A string representing when to show the close button for the tab.
		 * Possible values include: SuperTab.CLOSE_ALWAYS, SuperTab.CLOSE_SELECTED,
		 * SuperTab.CLOSE_ROLLOVER, SuperTab.CLOSE_NEVER
		 */
		public function get closeButtonVisiblePolicy():String
		{
			return _closeButtonVisiblePolicy;
		}

		public function set closeButtonVisiblePolicy(value:String):void
		{
			this._closeButtonVisiblePolicy=value;
			this.invalidateDisplayList();
		}

		/*
		 * We keep track of the rolled over state internally so we can set the
		 * closeButton to enabled or disabled depending on the state.
		 */
		override protected function rollOverHandler(event:MouseEvent):void
		{
			this._rollingOver=true;
			super.rollOverHandler(event);
		}

		override protected function rollOutHandler(event:MouseEvent):void
		{
			this._rollingOver=false;
			super.rollOutHandler(event);
		}

		/*
		 * The click handler for the close button.
		 * This makes the SuperTab dispatch a CLOSE_TAB_EVENT. This doesn't actually remove
		 * the tab. We don't want to remove the tab itself because that will happen
		 * when the SuperTabNavigator or SuperTabBar removes the child container. So within the SuperTab
		 * all we need to do is announce that a CLOSE_TAB_EVENT has happened, and we leave
		 * it up to someone else to ensure that the tab is actually removed.
		 */
		private function onCloseButtonClick(event:MouseEvent):void
		{
			event.stopPropagation();
			event.preventDefault();

			if (event.target is Button && "closeButton" == event.target.name)
			{
				var itemCloseEvent:ItemClickEvent=new ItemClickEvent(DockingEvent.CLOSED, true, true);
				itemCloseEvent.index=parent.getChildIndex(this);
				closeButton.removeEventListener(MouseEvent.CLICK, onCloseButtonClick);
				dispatchEvent(itemCloseEvent);
			}
		}

		[Embed(source="/assets/icon/16/viewDragImageClass.gif")]
		public var dragImageClass:Class;

		private function onMouseMove(event:MouseEvent):void
		{
			if (event.buttonDown == true && this.getStageWindow().docking)
			{
				var ds:DragSource=new DragSource();
				ds.addData(this, ViewTab.FORMAT);

				var dragImage:Image=new Image();
				dragImage.source=dragImageClass;
				dragImage.height=16;
				dragImage.width=16;

				DragManager.doDrag(Button(event.currentTarget), ds, event, dragImage, 10 - this.mouseX, 10 - this.mouseY, 0.8);
			}
		}

		private function onMouseUp(event:MouseEvent):void
		{
			this.getStageWindow().docking=false;
		}

		private function onMouseDown(event:MouseEvent):void
		{
			//if(event.target==this) {//TODO:local MouseDown
			this.getStageWindow().docking=true;
			//}
		}

		public function getStageWindow():StageWindow
		{
			var object:DisplayObject=this;
			while (!(object is StageWindow))
			{
				object=object.parent;
			}
			return StageWindow(object);
		}

		public function getViewWindow():ViewWindow
		{
			var object:DisplayObject=this;
			while (!(object is ViewWindow))
			{
				object=object.parent;
			}
			return ViewWindow(object);
		}

		public function getView():DockingView
		{
			var object:DisplayObject=this;
			while (!(object is DockingView))
			{
				object=object.parent;
			}
			return DockingView(object);
		}

	}
}