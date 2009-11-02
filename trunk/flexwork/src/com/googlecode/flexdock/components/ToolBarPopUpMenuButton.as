package com.googlecode.flexdock.components
{
	import mx.controls.PopUpMenuButton;
	import mx.controls.ButtonPhase;
	import mx.core.IFlexDisplayObject;
	import mx.events.MoveEvent;

	public class ToolBarPopUpMenuButton extends PopUpMenuButton
	{


		public function ToolBarPopUpMenuButton()
		{
			super();
			//			this.setStyle("icon", iconLayoutClass);
			this.openAlways=true;

			//			this.styleName="toolBarPopUpViewMenuButton";
			//			this.width=33;

		}

		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			//TODO move icon by (+1,-1)
			//			if (phase == ButtonPhase.DOWN)
			//			{
			//				var moveEvent:MoveEvent=new MoveEvent(MoveEvent.MOVE);
			//				moveEvent.oldX=this.currentIcon.x;
			//				moveEvent.oldY=currentIcon.y;
			//
			//				currentIcon.x+=1;
			//				currentIcon.y-=1;
			//				currentIcon.dispatchEvent(moveEvent);
			//			}
		}
	}
}