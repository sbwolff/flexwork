package com.googlecode.flexwork.work.components
{

	import flash.events.*;

	import mx.binding.utils.*;
	import mx.containers.*;
	import mx.controls.*;
	import mx.core.*;
	import mx.events.*;

	import com.googlecode.flexwork.core.components.DockingView

	public class ServiceMonitorView extends Box implements DockingView //integration with Cairgome
	{

		[Embed(source="/assets/console.gif")]
		private var iconClass:Class;

		private var textArea:TextArea;

		//		private var labelCtrl:Label;

		public function ServiceMonitorView()
		{
			this.icon=iconClass;
			this.label="Console";
			this.setStyle("verticalGap", 0);
		}

		override protected function createChildren():void
		{
			super.createChildren();
			//			if (!labelCtrl)
			//			{
			//				labelCtrl=new Label();
			//				labelCtrl.text="Console";
			//				labelCtrl.percentWidth=100;
			//				labelCtrl.height=18;
			//				this.addChild(labelCtrl);
			//			}

			if (!textArea)
			{
				textArea=new TextArea();
				//				textArea.name = "textArea";
				//				textArea.setStyle("borderThickness", 1);
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
				//				textArea.text = this.mouseX + this.mouseY;
				this.addChild(textArea);

				ChangeWatcher.watch(this, "width", watcherListener);
				ChangeWatcher.watch(this, "height", watcherListener);
			}
		}

		public function watcherListener(event:Event):void
		{
			textArea.text="parent.width=" + this.width + "\nparent.height=" + this.height;
		}

	}
}