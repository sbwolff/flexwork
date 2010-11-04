package com.googlecode.flexwork.core.components
{
	import com.googlecode.flexwork.core.components.dockableToolBarClasses.DockableToolBarDragStrip;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.containers.HBox;
	import mx.core.DragSource;
	import mx.core.ScrollPolicy;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.managers.CursorManager;
	import mx.managers.DragManager;
	import com.googlecode.flexwork.core.cursors.SouthNorthCursor;
	import com.googlecode.flexwork.core.cursors.EastWestCursor;


	use namespace mx_internal;

	//http://developer.yahoo.com/flash/astra-flash/layout-containers/examples.html
	public class DockableToolBar extends HBox
	{

		public function DockableToolBar()
		{
			super();
			
			/** common */
			/** effects */
			/** events */
			/** size */
			/** styles */
			this.styleName="dockableToolBar";
			//this.setStyle("horizontalGap", 0);
			/** other */
			
			horizontalScrollPolicy=ScrollPolicy.OFF;
			verticalScrollPolicy=ScrollPolicy.OFF;
			
			//	layoutObject.target=this;
			//this.addEventListener(DragEvent.DRAG_ENTER, onDragEnter);
			
			
			
			
		}

		//var docker:String;//TODO

		private var dragStrip:UIComponent;


		/**
		 * Flag which indicates whether this ToolBar can be dragged by user.
		 */
		public var draggable:Boolean=true;

		//[Embed(source="assets/dragStripIcon.gif")]
		//private var dragStripClass:Class = DockableToolBarDragStrip;
		/**
		 * Flag which indicates whether this ToolBar can be dragged by user.
		 */
		public var locked:Boolean=false;

		private var estimatedWidth:Number;

		mx_internal var rowCount:int=-1;

		/**
		 *  @private
		 *  Horizontal location where the user pressed the mouse button
		 *  to start dragging
		 */
		private var regX:Number;

		/**
		 *  @private
		 *  Vertical location where the user pressed the mouse button
		 *  to start dragging
		 */
		private var regY:Number;

		//mx_internal var layoutObject:FlowLayout=new FlowLayout();

		override public function set height(newHeight:Number):void
		{
			//			layoutObject.explicitHeightSet=true;
			super.height=newHeight;
		}

		override protected function measure():void
		{
			super.measure();
			layoutObject.measure();
		}

		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
//			if (dragStrip && unscaledWidth < dragStrip.getExplicitOrMeasuredWidth())
//				return;
			//			layoutObject.rowCount=(isNaN(explicitWidth) ? 1 : rowCount)
			//			layoutObject.modifyTargetHeight=true;
			if(dragStrip) {
				dragStrip.x = 0;
				dragStrip.y = 0;
			}			
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			layoutObject.updateDisplayList(unscaledWidth, unscaledHeight);
		}

		override protected function createChildren():void
		{
			

			if (!locked)
			{
				if (null == dragStrip)
				{
					
					dragStrip = new DockableToolBarDragStrip();

//					dragStrip.toolTip="Drag to move the Toolbar";
					//					dragStrip.buttonMode = true;
					//					dragStrip.useHandCursor = true;
					//					dragStrip.mouseChildren = false;
					//TODO:this.rawChildren.addChildAt(dragStrip, 0);
					this.addChildAt(dragStrip, 0);
				}

				dragStrip.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
				dragStrip.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				

			}
			
			
			super.createChildren();
		}
		
		private var cursorId:int;
		protected function onRollOver(event:MouseEvent):void
		{
			if(!event.buttonDown) {
				dragStrip.removeEventListener(MouseEvent.ROLL_OVER, onRollOver);
				dragStrip.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
				cursorId = CursorManager.setCursor(EastWestCursor);
			}			
		}
 			protected function onRollOut(event:MouseEvent):void
		{
					if(!event.buttonDown) {
				dragStrip.removeEventListener(MouseEvent.ROLL_OUT, onRollOut);
				dragStrip.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
				CursorManager.removeCursor(cursorId);
			}
		}
		override public function getExplicitOrMeasuredWidth():Number
		{
			return Math.min(systemManager.screen.width, super.getExplicitOrMeasuredWidth());
		}

		protected function onMouseDown(event:MouseEvent):void
		{
			//
			//[Embed(source="assets/cursor4.png")]
			//            [Bindable]
			//			public var Cursor4:Class;  
			//CursorManager.setCursor(e.currentTarget.source);

			CursorManager.removeAllCursors();

			var point:Point=this.globalToLocal(new Point(event.stageX, event.stageY));
			regX=point.x;
			regY=point.y;

			dragStrip.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			//			systemManager.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			//			systemManager.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			//			systemManager.stage.addEventListener(Event.MOUSE_LEAVE, stopDragging);

			if (measuredWidth > 200 || !isNaN(percentWidth))
			{
				var area:int=measuredHeight * measuredWidth;
				estimatedWidth=Math.max(Math.sqrt(area) * 1.6, measuredMinWidth);
			}
			else
				estimatedWidth=measuredWidth;

			//event.stopPropagation();

			//dragStrip.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);

		}

		protected function onMouseMove(event:MouseEvent):void
		{

			if (event.buttonDown == true)
			{
				var ds:DragSource=new DragSource();
				ds.addData(event.target, "dragStrip");

				DragManager.doDrag(UIComponent(UIComponent(event.target).parent), ds, event, null, 0, 0, 0);
					//this.addEventListener(DragEvent.DRAG_OVER, onDragOver);
					//this.addEventListener(DragEvent.DRAG_ENTER, onDragEnter);
			}

			//			var overDockingArea:Boolean=docker.dragOver(this, event);
			//
			//			var g:Graphics=docker.dragProxy.graphics;
			//			g.lineStyle(1, 0x000000, 0.5);
			//			g.beginFill(0xFFFFFF, 0.45);
			//			var wrapFactor:Number=(_isDocked && !overDockingArea) ? measuredWidth / estimatedWidth : 1;
			//			var dragObject:UIComponent=UIComponent(_isDocked ? this : parent);
			//			g.drawRect(event.stageX - regX / wrapFactor, event.stageY - regY, dragObject.width / wrapFactor, dragObject.height * wrapFactor);
			//			g.endFill();
		}


		//		private function onDragEnter(event:DragEvent):void
		//		{
		//			if (event.dragSource.hasFormat("dragStrip"))
		//			{
		//				var dropTarget:DockToolBar=DockToolBar(event.currentTarget);
		//				DragManager.acceptDragDrop(dropTarget);
		//			}
		//		}

	}
}