package com.googlecode.flexdock.components
{
	import mx.controls.Button;
	import mx.controls.ButtonPhase;
	import mx.core.IFlexDisplayObject;
	import mx.events.MoveEvent;
	import mx.core.mx_internal;
	use namespace mx_internal;

	//http://blog.flexexamples.com/2008/08/20/changing-the-default-skins-on-a-button-control-in-flex/
	public class ToolBarButton extends Button
	{


		public function ToolBarButton()
		{
			super();
		}

		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			if (phase == ButtonPhase.DOWN)
			{
				var moveEvent:MoveEvent=new MoveEvent(MoveEvent.MOVE);
				moveEvent.oldX=currentIcon.x;
				moveEvent.oldY=currentIcon.y;

				currentIcon.x+=1;
				currentIcon.y-=1;
				currentIcon.dispatchEvent(moveEvent);
			}
		}
	}
}