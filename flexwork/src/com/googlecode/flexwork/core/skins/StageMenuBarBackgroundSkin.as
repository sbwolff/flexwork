package com.googlecode.flexwork.core.skins
{
	import mx.skins.ProgrammaticSkin;


	public class StageMenuBarBackgroundSkin extends ProgrammaticSkin
	{

		public function StageMenuBarBackgroundSkin()
		{
			super();
		}


		override protected function updateDisplayList(w:Number, h:Number):void
		{
			switch (name)
			{
				case "itemDown":
				case "ititemOver":
				{
					var backgroundAlpha:Number=getStyle("backgroundAlpha");
					var rollOverColor:uint=getStyle("rollOverColor");
					graphics.clear();
					drawRoundRect(0, 0, w, h, 5, rollOverColor, backgroundAlpha);
				}

			}
		}
	}

}
