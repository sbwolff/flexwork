package com.googlecode.flexwork.core.components
{
	import com.googlecode.flexwork.core.events.DockingEvent;
	import com.googlecode.flexwork.core.components.IconButton;
	import com.googlecode.flexwork.core.components.DockableToolBar;

	import flash.events.MouseEvent;

	public class FastViewBar extends DockableToolBar
	{
		[Embed(source="assets/restore.gif")]
		protected var restoreIconClass:Class;

		public var viewWindow:ViewWindow;

		public var stageWindow:StageWindow;

		private var restoreButton:IconButton;
		public var isMaximizing:Boolean=false;
		public function FastViewBar()
		{
			super();
			
			setStyle("borderThickness", 1);
			setStyle("borderColor", 0x808080);
			setStyle("borderStyle", "solid");			
			setStyle("cornerRadius", 3);
			setStyle("horizontalGap", 0);
			setStyle("verticalGap", 0);
			setStyle("paddingTop", 1);
			setStyle("paddingLeft", 1);
			setStyle("paddingRight", 1);
			setStyle("paddingBottom", 1);
			
			//this.addEventListener(DockingEvent.RESTORE, onRestoreViewWindow);
			//TODO BORDER

		}

//		protected function onRestoreViewWindow(event:DockingEvent):void {
//			
//			
//			
//			event.stopImmediatePropagation();
//			
//			//stageWindow			
//		}
//		


		override protected function createChildren():void
		{
			if (!restoreButton)
			{
				restoreButton=new IconButton();
				restoreButton.toolTip="Restore";
				restoreButton.setStyle("icon", restoreIconClass);
				restoreButton.addEventListener(MouseEvent.CLICK, onRestore);
			}
			this.addChildAt(restoreButton, 0);
			
			super.createChildren();
		}

		private function onRestore(event:MouseEvent):void
		{
			stageWindow.fireRestoreViewWindow(viewWindow);
			if(this.parent) {
				this.parent.removeChild(this);
			}
		}



	}
}