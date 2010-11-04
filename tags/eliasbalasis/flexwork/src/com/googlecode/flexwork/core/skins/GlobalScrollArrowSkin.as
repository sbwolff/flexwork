package com.googlecode.flexwork.core.skins
{
	
	import flash.display.GradientType;
	import mx.skins.halo.ScrollArrowSkin;
	
	public class GlobalScrollArrowSkin extends ScrollArrowSkin
	{
		public function GlobalScrollArrowSkin()
		{
		}
		override protected function updateDisplayList(w:Number, h:Number):void
		{
			super.updateDisplayList(w,h);
			var borderColor:uint = getStyle("borderColor");
			
			var horizontal:Boolean = parent &&
								 parent.parent &&
								 parent.parent.rotation != 0;
			
			drawRoundRect(
					0, 0, w, h, 0,
					[borderColor, borderColor], 1,
					horizontal ?
					horizontalGradientMatrix(0, 0, w, h) :
					verticalGradientMatrix(0, 0, w, h),
					GradientType.LINEAR, null, 
					{ x: 1, y: 1, w: w - 2, h: h - 2, r: 0 });  

			
		}
	}
}