package org.flex.managers {

	import flash.events.*;
	
	import mx.binding.utils.*;
	import mx.containers.*;
	import mx.controls.*;
	import mx.core.*;
	import mx.events.*;
	
	import org.flex.dock.views.*
	
	public class ThreadManager
	{
		
		[Embed(source="/assets/console.gif")]
		private var iconClass:Class;
		
		private var textArea:TextArea;
		private var labelCtrl:Label;
		
		public function ThreadManager()
		{
			//this.icon = iconClass;
			//this.label = "Console";
			//this.setStyle("verticalGap", 0);
		}


	}
}