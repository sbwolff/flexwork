package com.googlecode.flexwork
{
	import com.googlecode.flexdock.views.DockView;
	
	import flash.display.GradientType;
	
	public class GraphicsDrawRoundRectView extends DockView
	{
		[Embed(source="assets/hand.png")]
		protected var iconHandClass:Class;
		
		
		public function GraphicsDrawRoundRectView()
		{
			super();
			this.icon=iconClass;
			this.label="iconHandClass";
			
			this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
		
		}


		drawRoundRect(0, 0, w, h, cr, [borderColor, borderColorDrk1], 1, verticalGradientMatrix(0, 0, w, h), GradientType.LINEAR, null, {x: 1, y: 1, w: w - 2, h: h - 2, r: cornerRadius - 1});

		private x:Number;
		private y:Number;
		private width:Number;
		private height:Number;
	    private cornerRadius:Object = null;
	    private color:Object = null;
	    private alpha:Object = null; 
	    private gradientMatrix:Object = null;
	    private gradientType:String = GradientType.LINEAR; 
	    private gradientRatios:Array = null;
	    private hole:Object = null;
	    
	    override protected function toolBarData():Array
		{
			return [ //
				{name: "doDraw", icon: iconHandClass, toolTip: "Do Draw"} //
			];
		}
		override public function onToolBarClick(event:ToolBarEvent):void
		{
			switch (event.name)
			{
				case "doDraw":
				{
					this.doDraw();
					break;
				}
			}
		}
	    
	    private function doDraw():void {
	    	drawRoundRect(0, 0, w, h, cr, [borderColor, borderColorDrk1], 1, verticalGradientMatrix(0, 0, w, h), GradientType.LINEAR, null, {x: 1, y: 1, w: w - 2, h: h - 2, r: cornerRadius - 1});		
	    }
		
		
		
	}
}