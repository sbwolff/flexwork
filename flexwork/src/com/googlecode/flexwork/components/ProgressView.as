package com.googlecode.flexwork.components
{
import com.googlecode.flexdock.views.DockView;
	
	import flash.events.*;

	import mx.binding.utils.*;
	import mx.containers.*;
	import mx.controls.*;
	import mx.core.*;
	import mx.events.*;


	public class ProgressView extends DockView
	{

		[Embed(source="/assets/progress.gif")]
		private var iconClass:Class;

		private var textArea:TextArea;

		//		private var labelCtrl:Label;

		public function ProgressView()
		{
			super();
			this.icon=iconClass;
			this.label="Progress";
			this.setStyle("verticalGap", 0);
		}

		override protected function createChildren():void
		{
			super.createChildren();

			//			if (!labelCtrl)
			//			{
			//				labelCtrl=new Label();
			//				labelCtrl.text="Progress";
			//				labelCtrl.percentWidth=100;
			//				labelCtrl.height=18;
			//				this.addChild(labelCtrl);
			//			}

			if (!textArea)
			{
				textArea=new TextArea();
				//				textArea.name = "textArea";
				textArea.setStyle("borderThickness", 0);
				//				textArea.setStyle("borderStyle", "solid");
				//				textArea.setStyle("borderSides", "top");
				textArea.setStyle("focusAlpha", 0.0);
				textArea.percentWidth=100;
				textArea.percentHeight=100;
				textArea.focusEnabled=false;
				textArea.editable=false;
				textArea.verticalScrollPolicy=ScrollPolicy.AUTO;
				textArea.horizontalScrollPolicy=ScrollPolicy.AUTO;
				textArea.text="parent.width=" + this.width + "\nparent.height=" + this.height;
				this.addChild(textArea);
			}
		}

	}
}