package com.googlecode.flexwork.core.skins
{

	import flash.display.Graphics;
	import mx.skins.halo.HaloBorder;

	public class ViewWindowBorder extends HaloBorder
	{

		public function ViewWindowBorder()
		{
			super();
		}

		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			graphics.clear();
			var borderWidth:int=2;
			graphics.lineStyle(borderWidth, 0xD4D0C8, 1, false);

			var x:Number=1;
			var y:Number=1;
			var width:Number=unscaledWidth - 1;
			var height:Number=unscaledHeight - 1;
			graphics.drawRect(x, y, width, height);
		}
	}

}
