package com.googlecode.flexwork.core.components
{
	import flash.display.DisplayObject;
	
	import mx.collections.ArrayCollection;
	import mx.containers.HBox;
	import mx.controls.Label;
	import mx.core.*;

	//flex 拖动效果（影子效果）
	//http://www.javaeye.com/topic/373210
	public class StageWindowBar extends HBox
	{
		private var labelCtrl:Label=null;

		public var stageWindow:StageWindow=null;

		public function StageWindowBar()
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

		public function addViewWindow(viewWindow:ViewWindow, stageWindow:StageWindow, isMaximizing:Boolean=false):void
		{
			var dragToolBar:FastViewBar=new FastViewBar();
			dragToolBar.isMaximizing=isMaximizing;
			dragToolBar.viewWindow=viewWindow;
			dragToolBar.stageWindow=stageWindow;

			dragToolBar.height=26;
//			

			var toolbar:ToolBar=new ToolBar();

			//			toolbar.setStyle("borderThickness", 1);
			//			toolbar.setStyle("borderColor", 0xACA899);
			//			toolbar.setStyle("borderStyle", "solid");
			//			toolbar.setStyle("borderSides", "top left right bottom");
			var array:ArrayCollection=new ArrayCollection();
			for each (var dockingView:DockingView in viewWindow.getChildren())
			{
				array.addItem({icon: dockingView.icon, toolTip: dockingView.label});
			}
			toolbar.dataProvider=array;
			dragToolBar.addChild(toolbar);

			this.addChild(dragToolBar);
		}

		public function clearViewWindows():void
		{
			doClearViewWindows();
		}

		public function clearViewWindowsForMaximization():void
		{
			doClearViewWindows(true);
		}
		
		private function doClearViewWindows(isMaximizing:Boolean=false):void
		{
			for (var i:int=this.numChildren - 1; i >= 0; i--)
			{
				var displayObject:DisplayObject=this.getChildAt(i);
				if (displayObject is FastViewBar)
				{
					var fastViewBar:FastViewBar=displayObject as FastViewBar;
					if(isMaximizing) {
						if (fastViewBar.isMaximizing == true) {
							this.removeChildAt(i);
						}	
					} else {
						this.removeChildAt(i);
					}
				}
			}
		}

	}
}
