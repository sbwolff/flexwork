package com.googlecode.flexwork.core.components
{
	import com.googlecode.flexwork.core.components.BoxSystemModule;
	import com.googlecode.flexwork.core.components.ToolBar;
	import com.googlecode.flexwork.core.events.DockingEvent;
	import com.googlecode.flexwork.core.events.ToolBarEvent;

	import flash.events.Event;
	import flash.events.MouseEvent;

	import mx.core.EdgeMetrics;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	import mx.containers.HBox;
	import mx.controls.Label;
	import mx.core.ScrollPolicy;
	import mx.managers.IFocusManagerComponent;

	public class DockingView extends BoxSystemModule implements IFocusManagerComponent
	{
		[Embed(source="assets/execute.png")]
		protected var defaultViewIconClass:Class;

		[Embed(source="assets/execute.png")]
		protected var tempIconClass:Class;

		[Embed(source="assets/view_menu.gif")]
		protected var iconViewMenuClass:Class;

		//		private static const viewMenuPopUpButtonStyleNameProp:String="viewMenuPopUpButtonStyleName";

		//		private static const VIEW_MENU_BUTTON_WIDTH:Number=18;
		private static const CONTROL_BAR_HEIGHT:Number=24;
		
		protected var controlBar:HBox;

		//		protected var contentBox:VBox;

		protected var toolBar:ToolBar;

		protected var viewLabel:Label;

		//TODO:protected var toolBar:ToolBar;

		//TODO:protected var popupMenu:PopupMenu;
		[Bindable]
		private var _toolBarDataProvider:Object=null;
		[Bindable]
		private var _viewMenuDataProvider:Object=null;

		//		[Bindable]
		//		public var stateArray:ArrayCollection=


		//		protected var viewMenu:Menu;
		//		
		////		protected var viewPopUpMenuButton:ToolBarButton;
		//		protected var viewPopUpMenuButton:PopUpMenuButton;


		public function DockingView()
		{
			super();
			/** common */
			this.label="untitled";
			this.icon=defaultViewIconClass;
			/** effects */ /** events */
			this.addEventListener(DockingEvent.CLOSED, onViewClosed);

			/** size */ /** styles */
			this.setStyle("horizontalGap", 0);
			this.setStyle("verticalGap", 0);
			
			this.verticalScrollPolicy=ScrollPolicy.OFF;
			this.horizontalScrollPolicy=ScrollPolicy.OFF;
			
			/** other */
		}

		private function onLabelChanged(event:Event):void {
			if(viewLabel) {
				viewLabel.text = this.label;
			}
		}

		protected function createControlBar():void
		{
			if (null == controlBar)
			{
				controlBar=new HBox();
				controlBar.enabled=true;
				controlBar.setStyle("borderColor", 0x808080);
				controlBar.setStyle("borderThickness", 1);
				controlBar.setStyle("borderStyle", "solid");
				controlBar.setStyle("borderSides", "bottom");
				controlBar.setStyle("verticalAlign", "top");
				//  horizontalAlign="center"
				controlBar.setStyle("paddingTop", 0);
				controlBar.setStyle("paddingBottom", 0);
				controlBar.setStyle("backgroundColor", 0xD4D0C8);
				controlBar.setStyle("horizontalGap", 0);
				controlBar.setStyle("verticalGap", 0);
				//				labelCtrl.text="Problems";
				controlBar.percentWidth=100;
				controlBar.height=CONTROL_BAR_HEIGHT; //toolbar height + bottom line(borderThickness)
			}
			createControlBarChildren();
			
			this.addChild(controlBar);
			//this.rawChildren.addChild(controlBar);
			
		}

		override protected function updateDisplayList(unscaledWidth:Number,
                                                  unscaledHeight:Number):void
	    {
	        
			super.updateDisplayList(unscaledWidth, unscaledHeight);
//	        controlBar.visible = true;     
//	        
//	        var em:EdgeMetrics = EdgeMetrics.EMPTY;
//	        var bm:EdgeMetrics = borderMetrics;
//        
//	        var x:Number = bm.left;
//	        var y:Number = bm.top;
//	        
//	        var controlBarWidth:Number = unscaledWidth - bm.left - bm.right;
//	        
//	        controlBar.move(x, y);
//            controlBar.setActualSize(controlBarWidth, CONTROL_BAR_HEIGHT);
	        
	    }
//



//		override public function get viewMetrics():EdgeMetrics
//	    {
//	    	var vm:EdgeMetrics = super.viewMetrics;
//	    	vm.top+=this.controlBar.getExplicitOrMeasuredHeight();
//	        return vm;
//	    }


// override protected function measure():void
//    {
//        super.measure();
//
//         var bm:EdgeMetrics =
//          
//            borderMetrics;
//          
//        
//        
//
//      
//        
//        if (controlBar && controlBar.includeInLayout)
//        {
//            var controlWidth:Number = controlBar.getExplicitOrMeasuredWidth() +
//                                      bm.left + bm.right;
//            
//            measuredWidth =
//                Math.max(measuredWidth, controlWidth);
//        }
//    }   

//		override public function get viewMetrics():EdgeMetrics
//	    {
//	    	var vm:EdgeMetrics = super.viewMetrics;
//	    	//if (controlBar && controlBar.includeInLayout) {
//                vm.top += CONTROL_BAR_HEIGHT;
//            //}
//            return vm;
//	    }

//
//		override protected function layoutChrome(unscaledWidth:Number, unscaledHeight:Number):void
//		{
//			super.layoutChrome(unscaledWidth, unscaledHeight);
//			var bm:EdgeMetrics=borderMetrics;
//			
//	        controlBar.move(bm.left, bm.top);
//            controlBar.setActualSize(unscaledWidth - bm.left - bm.right, controlBar.getExplicitOrMeasuredHeight());
//            this.invalidateDisplayList();
//		}

//		override protected function layoutChrome(unscaledWidth:Number, unscaledHeight:Number):void
//	    {
//	        super.layoutChrome(unscaledWidth, unscaledHeight);
//	        
//	        var em:EdgeMetrics = EdgeMetrics.EMPTY;
//	        var bm:EdgeMetrics = borderMetrics;
//        
//	        var x:Number = bm.left;
//	        var y:Number = bm.top;
//	        
//	        var controlBarWidth:Number = unscaledWidth - bm.left - bm.right;
//	        
//	        controlBar.move(x, y);
//            controlBar.setActualSize(controlBarWidth, CONTROL_BAR_HEIGHT);
//            this.invalidateDisplayList();	        
//        }
		protected function createControlBarChildren():void
		{
			createViewLabel();
			createToolBar();
		}

		protected function createViewLabel():void
		{
			if (null == viewLabel)
			{
				viewLabel=new Label();
				//viewLabel.setStyle("backgroundColor", 0x0000FF);
				viewLabel.setStyle("paddingTop", 3);
				viewLabel.percentWidth=100;
				viewLabel.percentHeight=100;
				viewLabel.text=this.label;
				//				labelCtrl.text="Problems";
				//				labelCtrl.percentWidth=100;
				//				labelCtrl.height=18;
				this.controlBar.addChild(viewLabel);
				this.addEventListener("labelChanged", onLabelChanged);
					//				ChangeWatcher.watch(this, "width", onSizeChangeWatcher);
					//				ChangeWatcher.watch(this, "height", onSizeChangeWatcher);
			}
		}

		protected function createToolBar():void
		{
			if (null == toolBar)
			{
				toolBar=new ToolBar();
				toolBar.addEventListener(ToolBarEvent.CLICK, onToolBarClick);
				//toolBar.addEventListener(MenuEvent.ITEM_CLICK, onItemClick);
				//toolBar.dataProvider=_toolBarDataProvider;
				_toolBarDataProvider=toolBarData();
				BindingUtils.bindProperty(toolBar, "dataProvider", this, "toolBarDataProvider");
				this.controlBar.addChild(toolBar);
			}
		}

		protected function toolBarData():Array
		{
			return [ //
//				{l1abel: "a", icon: tempIconClass, openAlways: true, //
//					children: [ //
//					{label: "a1", icon: tempIconClass, //
//							children: [ //
//							{label: "aa1", icon: tempIconClass}, //
//								{label: "aa2", icon: tempIconClass} //
//							]}, //
//						{type: "separator"}, //
//						{label: "a2", icon: tempIconClass} //
//					] //
//				}, //
				{l1abel: "a", icon: tempIconClass}, //
				{l1abel: "b", icon: tempIconClass}, //
				{l1abel: "c", icon: tempIconClass, //
					children: [ //
						{label: "aa2", icon: tempIconClass}, //
						{type: "separator"}, //
						{label: "aa12", icon: tempIconClass} //
					] //
				}, //				
				{l1abel: "d", type: ToolBar.TYPE_VIEW_MENU, toolTip: "View Menu", //
					children: [ //
					{label: "b1", icon1: tempIconClass, //
							children: [ //
							{label: "bb1", icon1: tempIconClass}, //
								{label: "bb2", icon: tempIconClass} //
							]}, //
						{type: "separator"}, //
						{label: "b2", icon: tempIconClass} //
					] //
				} //
				]; //			
		}

		override protected function createChildren():void
		{	
			createControlBar();
			super.createChildren();
			
			
			//			if (null == viewPopUpMenuButton)
			//			{
			//				viewMenuPopUpButton=new ToolBarButton();
			//				
			//				var viewMenuPopUpButtonStyleName:String=getStyle(viewMenuPopUpButtonStyleNameProp);
			//				if (!viewMenuPopUpButtonStyleName)
			//				{
			//					viewMenuPopUpButtonStyleName="PopUpButtonSkin";
			//				}
			//								
			//				
			//				viewMenuPopUpButton.setStyle("icon", iconViewMenuClass);
			//				viewMenuPopUpButton.styleName=viewMenuPopUpButtonStyleName
			//				viewMenuPopUpButton.width=VIEW_MENU_BUTTON_WIDTH;
			//				viewMenuPopUpButton.addEventListener(MouseEvent.CLICK, onViewMenuPopUpButton);
			//				viewMenu = new Menu();
			////				viewMenu.dataProvider = _viewMenuDataProvider;
			//				BindingUtils.bindProperty(viewMenu, "dataProvider", this, "viewMenuDataProvider");

			//				viewPopUpMenuButton=new PopUpMenuButton();
			//				viewPopUpMenuButton.setStyle("popUpIcon", iconViewMenuClass);
			//				viewPopUpMenuButton.openAlways=true;
			//				viewPopUpMenuButton.styleName="viewPopUpMenuButton";
			//				viewPopUpMenuButton.width=VIEW_MENU_BUTTON_WIDTH;
			//				BindingUtils.bindProperty(viewPopUpMenuButton, "dataProvider", this, "viewMenuDataProvider");
			//				this.controlBar.addChild(viewPopUpMenuButton);

			//			}
		}



		public function onViewMenuPopUpButton(event:MouseEvent):void
		{

		}

		public function onToolBarClick(event:ToolBarEvent):void
		{
			this.logInfo("event.target.toString()=" + event.target.toString());
			this.logInfo("event.name=" + event.name + " event.type=" + event.type + " buttonIndex:" + event.buttonIndex + " menuIndex:" + event.menuIndex);
			//			var e:*;
			//			if (event is MouseEvent)
			//			{
			//				e=MouseEvent(event);
			//				this.info("event.type=" + e.type + " " + e.target.toString() + "  item:" + e.index);
			//			}
			//			else if (event is ItemClickEvent)
			//			{
			//				e=ItemClickEvent(event);
			//				this.info("event.type=" + e.type + " " + e.target.toString() + "  item:" + e);
			//			}
			//			else if (event is MenuEvent)
			//			{
			//				e=MenuEvent(event);
			//				this.info("event.type=" + e.type + " " + e.target.toString() + "  item:" + e.index);
			//			}
		}

		public function onSizeChangeWatcher(event:Event):void
		{
			viewLabel.text=this.label + " (width: " + this.width + ",height: " + this.height + ")";
		}

		public function onViewClosed(event:DockingEvent):void
		{
			dispose();
		}

		public function dispose():void
		{

		}

		//		override public function get icon():Class{
		//			return defaultIconClass;
		//		}

		//		function get label():String;



		public function isDockAccepted():Boolean
		{
			return true;
		}


		public function set toolBarDataProvider(value:Object):void
		{
			_toolBarDataProvider=value;
		}

		public function get toolBarDataProvider():Object
		{
			return _toolBarDataProvider;

		}


	}
}