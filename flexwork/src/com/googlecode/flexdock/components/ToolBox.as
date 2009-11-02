package com.googlecode.flexdock.components
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	import mx.containers.HBox;
	import mx.containers.VBox;
	import mx.containers.utilityClasses.Layout;
	import mx.core.ScrollPolicy;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.DragEvent;
	import mx.managers.DragManager;
	use namespace mx_internal;

	public class ToolBox extends VBox
	{

		public static const ROW_HEIGHT:int=28;

		public function ToolBox()
		{
			super();

			/** common */ /** effects */ /** events */ /** size */
			this.height=ROW_HEIGHT;
			/** styles */
			this.setStyle("verticalGap", 0);
			this.setStyle("horizontalGap", 0);
			this.setStyle("paddingTop", 0);
			this.setStyle("paddingLeft", 0);
			this.setStyle("paddingRight", 0);
			this.setStyle("paddingBottom", 0);
			this.setStyle("borderThickness", 0);
			this.setStyle("verticalAlign", "middle");
			//this.setStyle("backgroundColor", 0xFF0000);

			/** other */
			this.horizontalScrollPolicy=ScrollPolicy.OFF;
			this.verticalScrollPolicy=ScrollPolicy.OFF;

			this.addEventListener(DragEvent.DRAG_ENTER, onDragEnter);
			this.addEventListener(DragEvent.DRAG_OVER, onDragOver);
			//this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}




		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);

			for (var i:int=0; i < this.numChildren; i++)
			{
				wrapRow(HBox(this.getChildAt(i)), i);
			}
			//this.parent.parent.height = this.numChildren * ROW_HEIGHT + 1;
		}

		override public function addChild(child:DisplayObject):DisplayObject
		{
			if (child is DragToolBar)
			{
				return addDockToolBar(DragToolBar(child));
			}
			return super.addChild(child);
		}

		private function addDockToolBar(child:DragToolBar):DisplayObject
		{
			var row:HBox=null;
			if (!this.numChildren)
			{
				row=createRow();
				this.addChild(row);
			}

			row=HBox(this.getChildAt(this.numChildren - 1));
			row.addChild(child);
			//child.docker=this;
			return row;

		}

		private function createRow():HBox
		{
			var row:HBox=new HBox();
			row.setStyle("verticalGap", 0);
			row.setStyle("horizontalGap", 2);
			row.setStyle("paddingTop", 0);
			row.setStyle("paddingLeft", 0);
			row.setStyle("paddingRight", 0);
			row.setStyle("paddingBottom", 0);
			row.setStyle("borderThickness", 0);

			//row.setStyle("backgroundColor", 0x0000FF);

			row.percentWidth=100;
			row.height=ROW_HEIGHT;
			row.horizontalScrollPolicy=ScrollPolicy.OFF;

			var rowStyleName:String=getStyle("rowStyleName");
			row.styleName=rowStyleName ? rowStyleName : this;
			return row;
		}

		private function wrapRow(row:HBox, rowIndex:int):void
		{
			var totalW:int=0;
			var newRow:HBox;
			for (var j:int=0; j < row.numChildren; j++)
			{
				var ch:DragToolBar=DragToolBar(row.getChildAt(j));
				totalW+=ch.measuredWidth;
				if (totalW > this.width && j)
				{
					if (!newRow)
					{
						if (this.numChildren - 1 > rowIndex)
							newRow=HBox(this.getChildAt(rowIndex + 1));
						else
						{
							newRow=createRow();
							this.addChildAt(newRow, rowIndex + 1);
						}
					}
					ch.parent.removeChild(ch);
					newRow.addChild(ch);
				}
			}
			if (newRow)
				wrapRow(newRow, rowIndex + 1);
		}

		private function onDragEnter(event:DragEvent):void
		{
			if (event.dragSource.hasFormat("dragStrip"))
			{
				var dropTarget:ToolBox=ToolBox(event.currentTarget);
				DragManager.acceptDragDrop(dropTarget);

			}
		}


		private function onDragOver(event:DragEvent):void
		{

			if (event.dragSource.hasFormat("dragStrip"))
			{
				var dropTarget:ToolBox=ToolBox(event.currentTarget);
				DragManager.acceptDragDrop(dropTarget);
			}

			//Alert.show(event.dragSource.dataForFormat("dragStrip").toString());
			var dockToolBar:DragToolBar=UIComponent(event.dragSource.dataForFormat("dragStrip")).parent as DragToolBar;

			var originalRow:HBox=HBox(dockToolBar.parent);
			//this.mouseX, 
			//var originalRowIndex:int = originalRow.parent.getChildIndex(originalRow);
			/*event.stageX, event.stageY mouseDown*/
			//var pt:Point=new Point(event.localX, event.localY);
			var pt:Point=new Point(this.mouseX, this.mouseY);
			//pt=globalToLocal(pt);

			//			Alert.show(dockToolBar.x.toString()+" "+dockToolBar.y.toString()+"\n"
			//			+"\n"
			//			+pt.toString());

			//var point:Point = new Point();

			var row:HBox=null;
			var rowIndex:int=this.numChildren;
			//


			var newRowAdded:Boolean=false;
			row=HBox(this.getChildAt(0));
			if (pt.y <= row.y + row.height * 0.25)
			{
				row=createRow();
				this.addChildAt(row, 0);
				newRowAdded=true;
			}
			if (!newRowAdded)
			{
				row=HBox(this.getChildAt(this.numChildren - 1));
				if (pt.y >= row.y + row.height * 0.75)
				{
					row=createRow();
					this.addChild(row);
					newRowAdded=true;
				}
			}

			if (!newRowAdded)
			{
				for (var i:int=0; i <= this.numChildren; i++)
				{
					row=HBox(this.getChildAt(i));
					if (pt.y < row.y + row.height)
					{
						break;
					}
				}
			}

			if (originalRow == row)
			{

			}
			else
			{
				originalRow.removeChild(dockToolBar);
				row.addChild(dockToolBar);
				if (originalRow.numChildren == 0)
				{
					originalRow.parent.removeChild(originalRow);
				}
				this.invalidateDisplayList();
			}

		}
	}
}