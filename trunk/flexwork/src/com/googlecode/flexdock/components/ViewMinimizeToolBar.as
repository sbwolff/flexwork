package com.googlecode.flexdock.components
{
	import com.googlecode.flexdock.events.DockViewEvent;
	
	public class ViewMinimizeToolBar extends ToolBar
	{		
		public var viewWindow:ViewWindow;
		
		public var stageWindow:StageWindow;
	
		public function ViewMinimizeToolBar()
		{
			super();			
			this.addEventListener(DockViewEvent.RESTORE, restoreViewWindow);
		}
		
		private function restoreViewWindow(event:DockViewEvent):void {
			event.stopImmediatePropagation();
			
			stageWindow
			
		}
	}
}