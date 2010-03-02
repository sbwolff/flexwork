package com.googlecode.flexwork.core.components
{
	import com.googlecode.flexwork.core.skins.ToolWindowDividerSkin;
	import com.googlecode.flexwork.core.components.toolWindowClasses.ToolWindowDivider;
	
	import com.googlecode.flexwork.core.components.dockableToolBarClasses.DockableToolBarDragStrip;
	
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	import mx.events.DragEvent;	
	import mx.containers.HDividedBox;
	import mx.core.ScrollPolicy;
	import mx.core.mx_internal;

	use namespace mx_internal;

	public class StageToolBar extends HDividedBox
	{
		private var HEIGHT:int=28;

		public function StageToolBar()
		{
			super();
			/** common */ /** effects */ /** events */

			//			this.addEventListener(DragEvent.DRAG_ENTER, onDragEnter);
			//this.addEventListener(DragEvent.DRAG_OVER, onDragOver);
			//this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			/** see also Container "childrenChanged" */
			this.addEventListener("toolBarRowChanged", onChildrenChanged);
			//this.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);			
			/** size */
			//this.height=HEIGHT;
			this.percentWidth=100;
			/** styles */

			//this.dividerClass = perspectiveDividedClass;
			//			this.percentWidth=100;
//			this.showRoot=false;
//			this.labelField="label";
//			this.iconField="icon";
//			this.styleName="menuBar";
//		
//			this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
//			this.addEventListener(FlexEvent.INITIALIZE, onInitialize);
//			this.addEventListener(MenuEvent.ITEM_CLICK, onMenuBarItemClick);
//			this.addEventListener(MenuEvent.MENU_SHOW, onMenuBarMenuShow);
		
			
			
			
//			this.setStyle("verticalAlign", "middle");
//			this.setStyle("verticalGap", 0);
//			this.setStyle("horizontalGap", 42);
//			this.setStyle("paddingTop", PADDING_TOP);
//			this.setStyle("paddingLeft", 2);
//			this.setStyle("paddingRight", 2);
//			this.setStyle("paddingBottom", 0);
//			this.setStyle("borderThickness", 0);
//			this.setStyle("backgroundColor", 0xD4D0C8);
			//			this.setStyle("backgroundColor", 0xFF0000);
			this.dividerClass = ToolWindowDivider;
			this.styleName = "toolWindow";
			
			/** other */
			this.horizontalScrollPolicy=ScrollPolicy.OFF;
			this.verticalScrollPolicy=ScrollPolicy.OFF;
			this.liveDragging=true;

			


		}
		private function onChildrenChanged(event:Event):void
		{
			if(this.numChildren>0) {
				this.height= rowNumber() * HEIGHT;
			}
		}
//		private function onMouseDown(event:MouseEvent):void
//		{
//			if(event.target is DockableToolBarDragStrip) {				
//				this.addEventListener(DragEvent.DRAG_OVER, onDragOver);
//			}
//		}
//		private function onDragOver(event:DragEvent):void
//		{
//			if (event.dragSource.hasFormat("dragStrip")){				
//			
//				//TODO this.removeEventListener(DragEvent.DRAG_OVER, onDragOver);
//			}			
//		}
		//private function onMouseMove(event:MouseEvent):void
		//{
			//Alert.show("ddd");
			//			
			//			if (event.dragSource.hasFormat("dragStrip"))
			//			{
			//				var dropTarget:ToolBox=ToolBox(event.currentTarget);
			//				var dockToolBar:ToolBar=UIComponent(event.dragSource.dataForFormat("dragStrip")).parent as ToolBar;
			//
			//				//this.height=dockToolBar.parent.parent.height;
			//			}
			
		//}
		
		private function rowNumber():int 
		{
			return ToolBox(getChildAt(0)).numChildren;
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