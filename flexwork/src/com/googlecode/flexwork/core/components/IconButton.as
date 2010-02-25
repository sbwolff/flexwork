package com.googlecode.flexwork.core.components
{
	import mx.controls.Button;
	import mx.controls.ButtonPhase;
	import mx.core.mx_internal;

	import mx.events.MoveEvent;

	use namespace mx_internal;

	public class IconButton extends Button
	{
		public static const BUTTON_HEIGHT:Number=22;

		public static const BUTTON_WIDTH:Number=24;

		public function IconButton()
		{
			super();
			/** common */ /** effects */ /** events */ /** size */ /** styles */
			this.styleName="iconButton";
		/** other */


		}

		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);

			if (phase == ButtonPhase.DOWN && currentIcon)
			{
//				var moveEvent:MoveEvent=new MoveEvent(MoveEvent.MOVE);
//				moveEvent.oldX=currentIcon.x;
//				moveEvent.oldY=currentIcon.y;

				currentIcon.x+=1;
				currentIcon.y+=1;
					//currentIcon.dispatchEvent(moveEvent);
			}
		}
	}
}