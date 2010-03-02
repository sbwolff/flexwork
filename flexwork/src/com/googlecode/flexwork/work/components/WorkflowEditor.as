package com.googlecode.flexwork.work.components
{
	import com.anotherflexdev.diagrammer.Diagram;
	import com.anotherflexdev.diagrammer.Link;
	import com.googlecode.flexwork.core.events.ToolBarEvent;
	import com.googlecode.flexwork.core.components.DockingEditor;
	import com.googlecode.flexwork.work.components.workflowClasses.*;
	import flash.events.*;
	
	import mx.binding.utils.*;
	import mx.containers.*;
	import mx.controls.*;
	import mx.core.*;
	import mx.events.*;
	//Tasks|Process|Services
	
	public class WorkflowEditor extends DockingEditor
	{

		[Embed(source="/assets/progress.gif")]
		private var iconClass:Class;
		
		private var workflowDigrammer:WorkflowDigrammer;
		
		public function WorkflowEditor()
		{
			super();
			this.icon=iconClass;
			this.label="Workflow";
			this.setStyle("verticalGap", 0);
			
			this.setStyle("backgroundColor", 0xFFFFFF);			
//			this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
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
			
			if (!workflowDigrammer)
			{
				workflowDigrammer = new WorkflowDigrammer();
				this.addChild(workflowDigrammer);
			}
		}
		
		override protected function toolBarData():Array
		{	
			return [ //
//				{name: "Clear", icon: iconClearClass, toolTip: "Clear"}, //
				{name: "Hand", icon: iconClass, toolTip: "Hand"}
			]; //
		}
		
		override public function onToolBarClick(event:ToolBarEvent):void
		{
			switch (event.name)
			{
				case "Clear":
				{
//					shownText="";
					break;
				}
			}
		}
//		public function watcherListener(event:Event):void
//		{
//			//            textArea.text="parent.width=" + this.width + "\nparent.height=" + this.height;
//		}

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