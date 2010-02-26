package com.googlecode.flexwork.core.cursors
{

	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.LineScaleMode;
	import flash.display.CapsStyle;

	import flash.display.Shape;

	public class SouthNorthCursor extends BaseArrowCursor
	{


		override protected function draw():void
		{
			this.setWhiteLineStyle();

			g.moveTo(-4, -6);
			g.lineTo(4, -6);

			g.moveTo(-3, -7);
			g.lineTo(3, -7);

			g.moveTo(-2, -8);
			g.lineTo(2, -8);

			g.moveTo(-1, -9);
			g.lineTo(1, -9);

			g.moveTo(0, -10);
			g.lineTo(0, -10);


			//
			g.moveTo(-4, 6);
			g.lineTo(4, 6);

			g.moveTo(-3, 7);
			g.lineTo(3, 7);

			g.moveTo(-2, 8);
			g.lineTo(2, 8);

			g.moveTo(-1, 9);
			g.lineTo(1, 9);

			g.moveTo(0, -10);
			g.lineTo(0, 10);

			g.moveTo(-1, -4);
			g.lineTo(-1, 4);

			g.moveTo(1, -4);
			g.lineTo(1, 4);

			g.moveTo(-4, -5);
			g.lineTo(4, -5);

			g.moveTo(-4, 5);
			g.lineTo(4, 5);

			///////////////

			this.setBlackLineStyle();
			g.moveTo(-3, -6);
			g.lineTo(3, -6);
			g.moveTo(-2, -7);
			g.lineTo(2, -7);
			g.moveTo(-1, -8);
			g.lineTo(1, -8);
			g.moveTo(0, -9);
			g.lineTo(0, -9);

			g.moveTo(-3, 6);
			g.lineTo(3, 6);
			g.moveTo(-2, 7);
			g.lineTo(2, 7);
			g.moveTo(-1, 8);
			g.lineTo(1, 8);

			g.moveTo(0, -9);
			g.lineTo(0, 9);
		}

		public function SouthNorthCursor()
		{

			super();

		}


	}
}