package org.flex.components {

	import flash.events.*;
	
	import mx.binding.utils.*;
	import mx.containers.*;
	import mx.controls.*;
	import mx.core.*;
	import mx.events.*;
	
	import org.flex.dock.views.*
	
	public class FileSystemView extends Box implements View
	{
		
		[Embed(source="/assets/document.png")]
		private var iconClass:Class;
		
		private var textArea:TextArea;
		
		public function FileSystemView()
		{
			super();
			
			this.icon = iconClass;
			this.label = "FileSystem";
		}

		override protected function createChildren():void
	    {
	   		super.createChildren();
	   
	    	if (!textArea){
				textArea = new TextArea();
				textArea.name = "textArea";
				textArea.percentWidth = 100;
				textArea.percentHeight = 100;			
				textArea.text = "parent.width=" + this.width + "\nparent.height=" + this.height;
				this.addChild(textArea);
			}
	    }

	}
}