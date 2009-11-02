package com.googlecode.flexdock.components
{
	import mx.containers.HDividedBox;
	import mx.core.ScrollPolicy;
	import mx.core.mx_internal;
	import mx.events.DragEvent;
	import flash.events.MouseEvent;
	import com.googlecode.flexdock.skins.PerspectiveDividedBoxSkin;
	import mx.controls.Alert;
	import mx.core.UIComponent;

	use namespace mx_internal;

	public class ToolWindow extends HDividedBox
	{
		[Embed("/assets/perspectiveDividedBox.gif")]
		private var perspectiveDividedClass:Class;
		private var PADDING_TOP:int=1;

		public function ToolWindow()
		{
			super();
			/** common */ /** effects */ /** events */

			//			this.addEventListener(DragEvent.DRAG_ENTER, onDragEnter);
			//this.addEventListener(DragEvent.DRAG_OVER, onDragOver);
			//this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			this.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			/** size */
			this.percentWidth=100;
			/** styles */

			//this.dividerClass = perspectiveDividedClass;
			this.setStyle("dividerSkin", perspectiveDividedClass);
			//TODO:this.setStyle("dividerSkin", PerspectiveDividedBoxSkin);
			//this.styleName = "toolWindow";
			this.setStyle("verticalAlign", "middle");
			this.setStyle("verticalGap", 0);
			this.setStyle("horizontalGap", 42);
			this.setStyle("paddingTop", PADDING_TOP);
			this.setStyle("paddingLeft", 2);
			this.setStyle("paddingRight", 2);
			this.setStyle("paddingBottom", 0);
			this.setStyle("borderThickness", 0);
			this.setStyle("backgroundColor", 0xECE9D8);

			//			this.setStyle("backgroundColor", 0xFF0000);
			/** other */
			this.horizontalScrollPolicy=ScrollPolicy.OFF;
			this.verticalScrollPolicy=ScrollPolicy.OFF;
			this.liveDragging=true;




		}

		private function onMouseMove(event:MouseEvent):void
		{
			//Alert.show("ddd");
			//			
			//			if (event.dragSource.hasFormat("dragStrip"))
			//			{
			//				var dropTarget:ToolBox=ToolBox(event.currentTarget);
			//				var dockToolBar:ToolBar=UIComponent(event.dragSource.dataForFormat("dragStrip")).parent as ToolBar;
			//
			//				//this.height=dockToolBar.parent.parent.height;
			//			}
			this.height=ToolBox(getChildAt(0)).numChildren * 28 + PADDING_TOP;
		}

		override protected function measure():void
		{
			super.measure();
			//layoutObject.measure();
			//this.measuredHeight = this.numChildren * ROW_HEIGHT + 1;
			//this.measuredHeight=ToolBox(getChildAt(0)).numChildren * 28 + PADDING_TOP;
		}
	}
}