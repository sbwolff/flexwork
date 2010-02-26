package com.googlecode.flexwork.core.skins
{
	import flash.display.Graphics;
	import flash.display.LineScaleMode;
	import flash.display.CapsStyle;
	import mx.skins.ProgrammaticSkin;
	
	import mx.core.mx_internal;
	
	public class ViewMenuArrowPopUpIcon extends ProgrammaticSkin
	{

		public function ViewMenuArrowPopUpIcon()
		{
			super();
		}

		override public function get measuredWidth():Number
		{
			return 10;
		}

		override public function get measuredHeight():Number
		{
			return 14;
		}

		override protected function updateDisplayList(w:Number, h:Number):void
		{
			super.updateDisplayList(w, h);
	
	        var g:Graphics = graphics;
	       	g.clear();
	       	
        	g.lineStyle(1, 0x404040, 1, true, LineScaleMode.NORMAL, CapsStyle.SQUARE);        	
			g.moveTo(0, 0);
	        g.lineTo(9, 0);	        
	        g.moveTo(1, 1);
	        g.lineTo(8, 1);	        
	        g.moveTo(2, 2);
	        g.lineTo(7, 2);	        
	        g.moveTo(3, 3);
	        g.lineTo(6, 3);	        
	        g.moveTo(4, 4);
	        g.lineTo(5, 4);
	        
	        
	        g.lineStyle(1, 0xFFFFFF, 1, true, LineScaleMode.NORMAL, CapsStyle.SQUARE);
	        g.moveTo(2, 1);
	        g.lineTo(7, 1);	        
	        g.moveTo(3, 2);
	        g.lineTo(6, 2);
	        g.moveTo(4, 3);
	        g.lineTo(5, 3);
	        
		}

	}
}