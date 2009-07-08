package org.flex.components {

	import flash.events.*;
	
	import mx.binding.utils.*;
	import mx.containers.*;
	import mx.core.*;
	import mx.controls.*;
	
	import org.flex.dock.views.*
	
	public class TextAreaView extends Box implements View {

		[Embed(source="/assets/text.gif")]
		private var iconClass:Class;
		
		private var textArea:TextArea;
		
		public function TextAreaView() {
			this.icon = iconClass;
			this.label = "TextArea";
		}

		override protected function createChildren():void {
	    	super.createChildren();
	   
	    	if (!textArea){
				textArea = new TextArea();
				
				textArea.name = "textArea";
				textArea.setStyle("borderThickness", 0);
				textArea.setStyle("focusAlpha", 0.0);
				textArea.percentWidth = 100;
				textArea.percentHeight = 100;
				
				textArea.focusEnabled = false;
				textArea.editable = false;
				
				textArea.verticalScrollPolicy = ScrollPolicy.AUTO;
				textArea.horizontalScrollPolicy = ScrollPolicy.AUTO;
						
				changeText();
				
				this.addChild(textArea);
				
				ChangeWatcher.watch(this, "width", watcherListener);
				ChangeWatcher.watch(this, "height", watcherListener);
			}
	    }
	    
	    public function watcherListener(event:Event):void {
            changeText();
        }

		private function changeText():void {
			textArea.text="parent.width=" + this.width + "\nparent.height=" + this.height;
		}
		
	}
}