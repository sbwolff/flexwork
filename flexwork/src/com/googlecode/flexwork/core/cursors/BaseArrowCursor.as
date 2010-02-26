package com.googlecode.flexwork.core.cursors
{

	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.LineScaleMode;
	import flash.display.CapsStyle;

	import flash.display.Shape;

	public class BaseArrowCursor extends Sprite
	{
		private var shape:Shape=null;

		protected var g:Graphics=null;

		public function BaseArrowCursor()
		{

			super();

			shape=new Shape();

			g=shape.graphics;

			draw();

			this.addChild(shape);

		}

		protected function setBlackLineStyle():void
		{
			g.lineStyle(1, 0x000000, 1, true, LineScaleMode.NORMAL, CapsStyle.SQUARE);
		}

		protected function setWhiteLineStyle():void
		{
			g.lineStyle(1, 0xFFFFFF, 1, true, LineScaleMode.NORMAL, CapsStyle.SQUARE);
		}

		protected function draw():void
		{

		}


	}
}