package com.googlecode.flexwork.core.components.dockableToolBarClasses
{
	import flash.display.Graphics;
	
	import mx.core.UIComponent;

	public class DockableToolBarDragStrip extends UIComponent
	{

		public function DockableToolBarDragStrip()
		{
			super();
		}

		override public function get measuredWidth():Number
		{
			return 3;
		}

		override public function get measuredHeight():Number
		{
			return 18;
		}

		override protected function updateDisplayList(w:Number, h:Number):void
		{
//			var amount:Number = 4;
						
			var g:Graphics=this.graphics;
			g.clear();
			
			g.lineStyle(0, 0x000000, 0);
			
			var i:int=0;
			
			g.beginFill(0x808080, 1);
//			for (i=0; i < amount; i++)
//			{
				g.drawRect(0, 0, w, h);
//			}
			g.endFill();
			g.beginFill(0xFFFFFF, 1);
//			for (i=0; i < amount; i++)
//			{
				g.drawRect(0, 0, w-1, h-1);
//			}
			g.endFill();
			g.beginFill(0xD4D0C8, 1);
//			for (i=0; i < amount; i++)
//			{
				g.drawRect(1, 1, w-2, h-2);
//			}
			g.endFill();
		}

	}
}