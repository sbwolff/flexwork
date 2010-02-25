package com.googlecode.flexwork.core.components
{	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	
	import mx.containers.*;
	import mx.controls.*;
	import mx.core.*;
	import mx.effects.*;
	import mx.effects.easing.*;
	import mx.managers.*;
	import mx.states.*;

	use namespace mx_internal;
//	<!-- reference: http://www.wietseveenstra.nl/files/flex/SuperPanel/v1_5/srcview/index.html -->
//	<!-- reference: http://www.adobe.com/cfusion/exchange/index.cfm?event=extensionDetail&loc=en_us&extid=1207017 -->

    public class ResizableTitleWindow extends TitleWindow
    {
       
        public function ResizableTitleWindow()
        {
        	this.setStyle("headerColors", [0xCCDBF6,0x99BAF3]);
        	this.setStyle("borderColor", 0x99BAF3);
			isPopUp = true;
            doubleClickEnabled = true;
            setStyle("headerHeight", 27);
            setStyle("cornerRadius", 4);
            setStyle("borderAlpha", 1);
            setStyle("dropShadowEnabled", true);
            setStyle("resizeAffordance", 6);
            
        }

    }
}
