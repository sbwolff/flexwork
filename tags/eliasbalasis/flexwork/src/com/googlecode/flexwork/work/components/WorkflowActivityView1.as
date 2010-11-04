package com.googlecode.flexwork.work.components
{
	import com.googlecode.flexwork.core.events.ToolBarEvent;
	import com.googlecode.flexwork.core.components.DockingView;
	import com.googlecode.flexwork.managers.ILogOutputTarget;
	
	import flash.events.*;
	
	import mx.binding.utils.*;
	import mx.containers.*;
	import mx.controls.*;
	import mx.core.*;
	import mx.events.*;

	
	public class WorkflowActivityView1 extends DockingView
	{

		[Embed(source="/assets/workflowActivityView.gif")]
		private var iconClass:Class;
		
		public function WorkflowActivityView1()
		{
			super();
			this.icon=iconClass;
			this.label="WorkflowActivity";
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
				textArea.setStyle("borderThickness", 0);
				//				textArea.setStyle("borderStyle", "solid");
				//				textArea.setStyle("borderSides", "top");
				textArea.setStyle("focusAlpha", 0.0);
				textArea.setStyle("backgroundColor", 0xFFFDDD);
				textArea.percentWidth=100;
				textArea.percentHeight=100;
				textArea.focusEnabled=false;
				textArea.editable=false;
				textArea.verticalScrollPolicy=ScrollPolicy.AUTO;
				textArea.horizontalScrollPolicy=ScrollPolicy.AUTO;
				textArea.text=shownText;
				//				textArea.text = "parent.width=" + this.width + "\nparent.height=" + this.height;
				//				textArea.text = this.mouseX + this.mouseY;
				this.addChild(textArea);
				BindingUtils.bindProperty(this.textArea, "text", this, "shownText");
					//				ChangeWatcher.watch(this, "width", watcherListener);
					//				ChangeWatcher.watch(this, "height", watcherListener);
			}
		}
		
		override protected function toolBarData():Array
		{	
			return [ //
				{name: "Clear", icon: iconClearClass, toolTip: "Clear"}, //
				{name: "Hand", icon: iconClass, toolTip: "Hand"}
			]; //
		}
		
		override public function onToolBarClick(event:ToolBarEvent):void
		{
			switch (event.name)
			{
				case "Clear":
				{
					shownText="";
					break;
				}
			}
		}
		public function watcherListener(event:Event):void
		{
			//            textArea.text="parent.width=" + this.width + "\nparent.height=" + this.height;
		}

		//		public function print(string:String):void
		//		{
		//			
		//		}
		//
		//		public function println(string:String):void
		//		{
		//			textArea.text+="\n" + string;
		//		}

	


	}
}