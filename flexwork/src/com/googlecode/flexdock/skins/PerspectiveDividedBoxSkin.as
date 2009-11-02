package com.googlecode.flexdock.skins
{
	import flash.display.Graphics;
	import mx.skins.ProgrammaticSkin;
	import mx.skins.Border;

	public class PerspectiveDividedBoxSkin extends ProgrammaticSkin
	{

		public function PerspectiveDividedBoxSkin()
		{
			super();
		}

		override protected function updateDisplayList(width:Number, height:Number):void
		{
			var g:Graphics=graphics;
			g.clear();

			var x0:Number=0; //(width-height)/2;
			var y0:Number=0; //x0;

			var w:Number=height;
			var h:Number=width;
			g.beginFill(this.getStyle("backgroundColor"), 0);
			g.lineStyle(1, 0xFFFFFF);
			g.drawRect(x0, y0, w, h);
			g.endFill();

			g.moveTo(x0, h + y0);
			g.lineTo(w + x0, y0);
		}

		override public function get measuredHeight():Number
		{
			return this.parent.height;
		}

		override public function get measuredWidth():Number
		{
			return 42;
		}
	}

}
