package com.googlecode.flexwork.core.skins
{

import flash.display.GradientType;
import mx.core.FlexVersion;
import mx.skins.Border;
import mx.styles.StyleManager;
import mx.utils.ColorUtil;
import mx.skins.halo.ScrollTrackSkin;

public class GlobalScrollTrackSkin extends ScrollTrackSkin
{
	
	public function GlobalScrollTrackSkin()
	{
		super(); 
	}
    
	override protected function updateDisplayList(w:Number, h:Number):void
	{
		super.updateDisplayList(w, h);

		
		var fillColors:Array = getStyle("trackColors");
		StyleManager.getColorNames(fillColors);
		
		var borderColor:uint =getStyle("borderColor");
		
		graphics.clear();
		
		var fillAlpha:Number = 1;
		
		if (name == "trackDisabledSkin" && FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0)
			fillAlpha = .2;
		
		// border
		drawRoundRect(
			0, 0, w, h, 0,
			[ borderColor, borderColor ], fillAlpha,
			verticalGradientMatrix(0, 0, w, h),
			GradientType.LINEAR, null,
			{ x: 1, y: 1, w: w - 2, h: h - 2, r: 0 }); 

		// fill
		drawRoundRect(
			1, 1, w - 2, h - 2, 0,
			fillColors, fillAlpha, 
			horizontalGradientMatrix(1, 1, w / 3 * 2, h - 2)); 
	}
}

}
