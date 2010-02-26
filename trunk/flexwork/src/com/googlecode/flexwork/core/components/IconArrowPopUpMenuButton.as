package com.googlecode.flexwork.core.components
{

	import mx.controls.PopUpMenuButton;
	import mx.controls.ButtonPhase;
	import mx.core.IFlexDisplayObject;
	import mx.events.MoveEvent;

	import mx.core.IUIComponent;
	import mx.controls.Menu;
	import mx.core.mx_internal;

	import mx.core.IFlexDisplayObject;

	use namespace mx_internal;

	public class IconArrowPopUpMenuButton extends PopUpMenuButton
	{
		public var iconSet:Boolean=false;

		public function IconArrowPopUpMenuButton()
		{
			super();
			/** common */ /** effects */ /** events */
			this.openAlways=true;
			/** size */ /** styles */
			this.styleName="iconArrowPopUpMenuButton";
			/** other */
			this.label=null; //to set labelSet=true;
		}

		override public function setStyle(styleProp:String, newValue:*):void
		{
			if (!iconSet && "icon" == styleProp)
			{
				return; //donothing	    	
			}
			return super.setStyle(styleProp, newValue);
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

		override mx_internal function getPopUp():IUIComponent
		{
			var popUpComponent:IUIComponent=super.getPopUp();
			if (popUpComponent is Menu)
			{
				Menu(popUpComponent).variableRowHeight=true;
			}
			return popUpComponent;
		}
	}
}