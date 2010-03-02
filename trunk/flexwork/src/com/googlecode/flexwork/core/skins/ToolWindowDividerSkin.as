package com.googlecode.flexwork.core.skins
{
	import flash.display.Graphics;

	import mx.skins.ProgrammaticSkin;

// http://www.javaeye.com/topic/460676 DividedBoxDemo.rar

	public class ToolWindowDividerSkin extends ProgrammaticSkin
	{


		public function ToolWindowDividerSkin()
		{
			super();
		}

		override protected function updateDisplayList(w:Number, h:Number):void
		{
			var bezierLength:Number=w / 4;

			var g:Graphics=graphics;
			g.clear();

			g.beginFill(getStyle("backgroundColor"), 0);
			g.drawRect(0, 0, w, h);
			g.endFill();

			// leftBottom point 
			var x1:Number=0;
			var y1:Number=h;

			// rightTop point
			var x2:Number=w;
			var y2:Number=0;


			// center point
			var xc:Number=(x2 - x1) / 2 + x1;
			var yc:Number=(y2 - y1) / 2 + y1;

			// leftBottom ctrl point 
			var bx1:Number=x1 + bezierLength;
			var by1:Number=y1;

			// rightTop ctrl point 
			var bx2:Number=x2 - bezierLength;
			var by2:Number=y2;

			g.lineStyle(1, 0xFFFFFF);
			g.moveTo(x1, y1);
			g.curveTo(bx1, by1, xc, yc);
			g.curveTo(bx2, by2, x2, y2);
			
		}

//		override protected function updateDisplayList(w:Number, h:Number):void  
//        {  
//            var g:Graphics = graphics;  
//            var matrix:Matrix = new Matrix();  
//            if (isNaN(w) || isNaN(h))  
//                return;   
//            g.clear();  
//            g.lineStyle(1, 0x6593CF, 1);  
//            g.beginFill(0xFFFFFF, 0);  
//            g.drawRect(0, 0, w - 1, h - 1);  
//            g.endFill();  
//            matrix.createGradientBox(w - 2, h - 2, Math.PI / 2, 0, 0);  
//            g.lineStyle(0, 0x000000, 0);  
//            g.beginGradientFill(GradientType.LINEAR,   
//                    [0xFFFFFF, 0xF8FBFF, 0xF0F7FF, 0xE5F1FF, 0xDAEBFF, 0xD0E5FF],   
//                    [1, 1, 1, 1, 1, 1],   
//                    [0, 51, 102, 153, 204, 255],   
//                    matrix,   
//                    SpreadMethod.PAD,   
//                    InterpolationMethod.LINEAR_RGB,   
//                    0);  
//            g.drawRect(1, 1, w - 2, h - 2);  
//            g.endFill();  
//        }  

//		override public function get measuredWidth():Number
//		{
//			return 42;
//		}
	}

}
