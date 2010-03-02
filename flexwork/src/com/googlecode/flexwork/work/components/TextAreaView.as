package com.googlecode.flexwork.work.components
{

	import com.googlecode.flexwork.core.components.DockingView;
	
	import flash.events.*;
	
	import mx.binding.utils.*;
	import mx.containers.*;
	import mx.controls.*;
	import mx.core.*;

	public class TextAreaView extends DockingView
	{

		[Embed(source="/assets/text.gif")]
		private var iconClass:Class;

		private var textArea:TextArea;

		public function TextAreaView()
		{
			this.icon=iconClass;
			this.label="TextArea";
			this.addEventListener(KeyboardEvent.KEY_DOWN, onKeyboardKeyDown);
		}
		
		private function onKeyboardKeyDown(event:KeyboardEvent):void {
			var msg:String = "";
			msg+="event.keyCode:"+event.keyCode;
			msg+=", event.shiftKey:"+event.shiftKey;
			msg+=", event.ctrlKey:"+event.ctrlKey;
			msg+=", event.altKey:"+event.altKey;
			this.logDebug(msg);
		}

		override protected function createChildren():void
		{
			super.createChildren();

			if (!textArea)
			{
				textArea=new TextArea();

				textArea.name="textArea";
				textArea.setStyle("borderThickness", 0);
				textArea.setStyle("focusAlpha", 0.0);
				textArea.percentWidth=100;
				textArea.percentHeight=100;

				textArea.focusEnabled=false;
				//textArea.editable=false;

				textArea.verticalScrollPolicy=ScrollPolicy.AUTO;
				textArea.horizontalScrollPolicy=ScrollPolicy.AUTO;

				changeText();

				this.addChild(textArea);

				ChangeWatcher.watch(this, "width", watcherListener);
				ChangeWatcher.watch(this, "height", watcherListener);
			}
		}

		public function watcherListener(event:Event):void
		{
			changeText();
		}

		private function changeText():void
		{
			textArea.text="parent.width=" + this.width + "\nparent.height=" + this.height;
		}

	}
}