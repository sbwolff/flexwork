package com.googlecode.flexwork.core.skins
{
	import mx.skins.halo.SliderThumbSkin;

	public class LoginSliderThumbSkin extends SliderThumbSkin
	{

		public function LoginSliderThumbSkin()
		{
			super();
		}

		/**
		 *  @private
		 */
		override public function get measuredHeight():Number
		{
			return 38;
		}


		/**
		 *  @private
		 */
		override public function get measuredWidth():Number
		{
			return 50;
		}
	}
}