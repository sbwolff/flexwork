package org.flex.components {

	import flash.events.*;
	
	import mx.binding.utils.*;
	import mx.containers.*;
	import mx.controls.*;
	import mx.core.*;
	import mx.events.*;
	
	import org.flex.dock.views.*
	/*
	Log Viewer
Often times a developer would like to have an easy way to append data to 
a log on-screen. Unfortunatly, using a simple TextArea and appending text 
becomes very slow operation. This component allows you to append text 
with minimal slow-down for massive amounts of data.
	http://www.rogue-development.com/logViewer.xml#Example%20Usage
	*/
	public class ConsoleView extends Box implements View
	{
		
		[Embed(source="/assets/console.gif")]
		private var iconClass:Class;
		
		private var textArea:TextArea;
		private var labelCtrl:Label;
		
		public function ConsoleView()
		{
			this.icon = iconClass;
			this.label = "Console";
			this.setStyle("verticalGap", 0);
		}

		override protected function createChildren():void
	    {
	   		super.createChildren();	   		 
	    	if (!labelCtrl){
				labelCtrl = new Label();
				labelCtrl.text = "Console";
				labelCtrl.percentWidth = 100;
				labelCtrl.height = 18;
				this.addChild(labelCtrl);
			}
			
			if (!textArea){
				textArea = new TextArea();
//				textArea.name = "textArea";
				textArea.setStyle("borderThickness", 1);
				textArea.setStyle("borderStyle","solid");
				textArea.setStyle("borderSides","top");
				textArea.setStyle("focusAlpha", 0.0);
				textArea.percentWidth = 100;
				textArea.percentHeight = 100;
				textArea.focusEnabled = false;
				textArea.editable = false;
				textArea.verticalScrollPolicy = ScrollPolicy.AUTO;
				textArea.horizontalScrollPolicy = ScrollPolicy.AUTO;
								
				textArea.text = "parent.width=" + this.width + "\nparent.height=" + this.height;
//				textArea.text = this.mouseX + this.mouseY;
				this.addChild(textArea);
				
				ChangeWatcher.watch(this, "width", watcherListener);
				ChangeWatcher.watch(this, "height", watcherListener);
			}
	    }
	    
		public function watcherListener(event:Event):void {
            textArea.text="parent.width=" + this.width + "\nparent.height=" + this.height;
        }

	}
}