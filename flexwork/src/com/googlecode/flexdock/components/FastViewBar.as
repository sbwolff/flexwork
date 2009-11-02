package com.googlecode.flexdock.components
{	
	import com.googlecode.flexdock.events.DockViewEvent;
	import com.googlecode.flexdock.views.DockView;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.containers.HBox;
	import mx.controls.Label;
	import mx.core.*;

	//flex 拖动效果（影子效果）
	//http://www.javaeye.com/topic/373210
	public class FastViewBar extends HBox
	{
		[Embed(source="assets/restore.gif")]
		protected var restoreIconClass:Class;
		private var labelCtrl:Label=null;

		public var stageWindow:StageWindow=null;

		public function FastViewBar()
		{
			super();
			this.horizontalScrollPolicy=ScrollPolicy.AUTO;
			this.percentWidth=100;
			this.percentHeight=100;
			this.styleName="fastViewBar";
			this.setStyle("verticalAlign", "middle");
			this.setStyle("verticalGap", 0);
			this.setStyle("horizontalGap", 2);
		}

		override protected function createChildren():void
		{
			super.createChildren();

			//			if (!labelCtrl)
			//			{
			//				labelCtrl=new Label();
			//				labelCtrl.text="//TODO:fastViewBar";
			//				labelCtrl.percentWidth=100;
			//				labelCtrl.height=18;
			//				this.addChild(labelCtrl);
			//			}

		}

		public function addViewWindow(viewWindow:ViewWindow, stageWindow:StageWindow):void
		{
			var dragToolBar:DragToolBar=new DragToolBar();
			dragToolBar.height=26;
			dragToolBar.setStyle("borderThickness", 1);
			dragToolBar.setStyle("borderColor", 0xACA899);
			dragToolBar.setStyle("borderStyle", "solid");
			dragToolBar.setStyle("borderSides", "top left right bottom");
			dragToolBar.setStyle("cornerRadius", 3);
			dragToolBar.setStyle("horizontalGap", 0);
			dragToolBar.setStyle("verticalGap", 0);
			dragToolBar.setStyle("paddingTop", 1);
			dragToolBar.setStyle("paddingLeft", 1);
			dragToolBar.setStyle("paddingRight", 1);
			dragToolBar.setStyle("paddingBottom", 1);

			var toolbar:ViewMinimizeToolBar=new ViewMinimizeToolBar();
			toolbar.viewWindow = viewWindow;
			//			toolbar.setStyle("borderThickness", 1);
			//			toolbar.setStyle("borderColor", 0xACA899);
			//			toolbar.setStyle("borderStyle", "solid");
			//			toolbar.setStyle("borderSides", "top left right bottom");
			var array:ArrayCollection=new ArrayCollection();
			array.addItem({icon: restoreIconClass, toolTip: "Restore", listener:restoreFromMaximize });
			
			for each (var child:DockView in viewWindow.getChildren())
			{
				array.addItem({icon: child.icon, toolTip: child.label});
			}
			toolbar.dataProvider=array;
			dragToolBar.addChild(toolbar);

			this.addChild(dragToolBar);
		}
		
		private function restoreFromMaximize(event:MouseEvent):void {
			dispatchEvent(new DockViewEvent(DockViewEvent.RESTORE));
		}
	}
}
