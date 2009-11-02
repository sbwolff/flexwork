package com.googlecode.flexwork.components.loginClasses
{
	import mx.controls.sliderClasses.SliderThumb;
	import mx.core.mx_internal;

	use namespace mx_internal;

	public class LoginSliderThumb extends SliderThumb
	{
		public function LoginSliderThumb()
		{
			super();

		}

		override protected function measure():void
		{
			super.measure();
			measuredWidth=currentSkin.measuredWidth;
			measuredHeight=currentSkin.measuredHeight;
		}
	}
}