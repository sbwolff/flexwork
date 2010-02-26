package com.googlecode.flexwork.core.cursors
{

	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.LineScaleMode;
	import flash.display.CapsStyle;

	import flash.display.Shape;

	public class EastWestCursor extends BaseArrowCursor
	{

		override protected function draw():void
		{
			this.setWhiteLineStyle();

			g.moveTo(-6, -4);
			g.lineTo(-6, 4);

			g.moveTo(-7, -3);
			g.lineTo(-7, 3);

			g.moveTo(-8, -2);
			g.lineTo(-8, 2);

			g.moveTo(-9, -1);
			g.lineTo(-9, 1);

			g.moveTo(-10, 0);
			g.lineTo(-10, 0);


			//
			g.moveTo(6, -4);
			g.lineTo(6, 4);

			g.moveTo(7, -3);
			g.lineTo(7, 3);

			g.moveTo(8, -2);
			g.lineTo(8, 2);

			g.moveTo(9, -1);
			g.lineTo(9, 1);

			g.moveTo(-10, 0);
			g.lineTo(10, 0);

			g.moveTo(-4, -1);
			g.lineTo(4, -1);

			g.moveTo(-4, 1);
			g.lineTo(4, 1);

			g.moveTo(-5, -4);
			g.lineTo(-5, 4);

			g.moveTo(5, -4);
			g.lineTo(5, 4);

			///////////////

			this.setBlackLineStyle();

			g.moveTo(-6, -3);
			g.lineTo(-6, 3);
			g.moveTo(-7, -2);
			g.lineTo(-7, 2);
			g.moveTo(-8, -1);
			g.lineTo(-8, 1);
			g.moveTo(-9, 0);
			g.lineTo(-9, 0);

			g.moveTo(6, -3);
			g.lineTo(6, 3);
			g.moveTo(7, -2);
			g.lineTo(7, 2);
			g.moveTo(8, -1);
			g.lineTo(8, 1);

			g.moveTo(-9, 0);
			g.lineTo(9, 0);
		}

		public function EastWestCursor()
		{
			super();
		}
	}
}