package com.googlecode.flexwork.components
{
	import com.googlecode.flexdock.events.ToolBarEvent;
	import com.googlecode.flexdock.views.DockView;
	import com.googlecode.flexwork.managers.ILogOutputTarget;
	
	import flash.events.*;
	
	import mx.binding.utils.*;
	import mx.containers.*;
	import mx.controls.*;
	import mx.core.*;
	import mx.events.*;

	/*
	   Log Viewer
	   Often times a developer would like to have an easy way to append data to
	   a log on-screen. Unfortunatly, using a simple TextArea and appending text
	   becomes very slow operation. This component allows you to append text
	   with minimal slow-down for massive amounts of data.
	   http://www.rogue-development.com/logViewer.xml#Example%20Usage
	 */
	//http://www.javaeye.com/topic/437168
	public class ConsoleView extends DockView implements ILogOutputTarget
	{

		[Embed(source="/assets/console.gif")]
		private var iconClass:Class;
		
		[Embed(source="/assets/clear.gif")]
		private var iconClearClass:Class;

		[Bindable]
		public var shownText:String=""; //ReferenceError: Error #1069: Property shownText not found on com.googlecode.flexwork.components.ConsoleView and there is no default value.

		private var textArea:TextArea;

		//private var labelCtrl:Label;

		public function ConsoleView()
		{
			super();
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

		override public function logError(message:String):void
		{
			shownText+=message + "\n";
		}

		override public function logInfo(message:String):void
		{
			shownText+=message + "\n";
		}

		override public function logDebug(message:String):void
		{
			shownText+=message + "\n";
		}

	}
}