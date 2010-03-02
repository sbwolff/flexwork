package com.googlecode.flexwork.core.components
{
	import flash.events.MouseEvent;

	import mx.controls.ProgressBar;
	import mx.controls.ProgressBarLabelPlacement;
	import mx.controls.ProgressBarMode;

	//			http://www.insideria.com/2009/03/flex-101-accessing-a-web-servi.html
	//			 http://www.degrafa.org/source/ButtonLoader/ButtonLoader.html
	//			 http://blog.flexexamples.com/2008/03/15/setting-a-complete-effect-on-a-progressbar-control-in-flex/ 
	public class StageProgressBar extends ProgressBar
	{
		public function StageProgressBar()
		{
			//trackHeight="20" width="120" indeterminate="true" mode="manual"
			//						labelPlacement="center" label="ProgressBar"
			super();
			this.setStyle("trackHeight", 20);			
						this.width=120;
			//this.percentWidth=100;
			this.labelPlacement=ProgressBarLabelPlacement.CENTER;
			this.label="";
			this.indeterminate=true;
			this.addEventListener(MouseEvent.CLICK, onMouseClick);
			stop();
		}

		private function onMouseClick(event:MouseEvent):void
		{
			if (this.mode == ProgressBarMode.EVENT)
			{
				this.mode=ProgressBarMode.MANUAL;
			}
			else
			{
				this.mode=ProgressBarMode.EVENT;
			}
		}

		public function start():void
		{
			this.mode=ProgressBarMode.EVENT;
		}

		public function stop():void
		{
			this.mode=ProgressBarMode.MANUAL;
		}
	}
}