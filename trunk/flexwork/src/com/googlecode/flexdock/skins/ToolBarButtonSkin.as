package com.googlecode.flexdock.skins
{

	import flash.display.Graphics;
	import mx.skins.Border;
	import mx.skins.ProgrammaticSkin;
	import mx.styles.StyleManager;
	import flash.display.GradientType;
	import mx.utils.ColorUtil;

	public class ToolBarButtonSkin extends ProgrammaticSkin
	{



		public function ToolBarButtonSkin()
		{

		}


		override protected function updateDisplayList(w:Number, h:Number):void
		{

			// User-defined styles.
			var borderColor:uint=getStyle("borderColor");
			var cornerRadius:Number=getStyle("cornerRadius");
			var fillAlphas:Array=getStyle("fillAlphas");
			var fillColors:Array=getStyle("fillColors");
			StyleManager.getColorNames(fillColors);
			var highlightAlphas:Array=getStyle("highlightAlphas");
			var themeColor:uint=getStyle("themeColor");

			var backgroundColor:uint=getStyle("backgroundColor");

			//			var themeColorDrk1:Number =
			//			ColorUtil.adjustBrightness2(themeColor, -25);


			//		var borderColorDrk1:Number =
			//			ColorUtil.adjustBrightness2(borderColor, -50);

			var cr:Number=3; //Math.max(0, cornerRadius);
			var cr1:Number=cr - 1; //Math.max(0, cornerRadius - 1);


			var g:Graphics=graphics;

			g.clear();
			switch (name)

			{
				case "selectedUpSkin":

				{
					break;
				}
				case "upSkin":
				{
					drawRoundRect(0, 0, w, h, [backgroundColor, backgroundColor], 1);
					break;
				}
				case "selectedOverSkin":
				case "overSkin":
				{


					// button border/edge
					drawRoundRect(0, 0, w, h, cr, [borderColor, borderColor], 1, verticalGradientMatrix(0, 0, w, h), GradientType.LINEAR, null, {x: 1, y: 1, w: w - 2, h: h - 2, r: cr - 1});

					// button fill
					drawRoundRect(1, 1, w - 2, h - 2, cr1, fillColors, fillAlphas, verticalGradientMatrix(1, 1, w - 2, h - 2));

					// top highlight
					drawRoundRect(1, 1, w - 2, (h - 2) / 2, {tl: cr1, tr: cr1, bl: 0, br: 0}, [0xFFFFFF, 0xFFFFFF], highlightAlphas, verticalGradientMatrix(1, 1, w - 2, (h - 2) / 2));

					break;
				}
				case "downSkin":
				case "selectedDownSkin":
				{

				}
			}
		}



	}
}