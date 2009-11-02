package com.googlecode.flexwork.menus
{
	import com.googlecode.flexdock.components.ViewWindow;
	import com.googlecode.flexdock.views.DockView;
	import com.googlecode.flexwork.events.PerspectiveEvent;
	import com.googlecode.flexwork.managers.PerspectiveManager;
	
	import mx.events.MenuEvent;
	
	import org.springextensions.actionscript.context.IApplicationContext;
	import org.springextensions.actionscript.context.IApplicationContextAware;
	import org.springextensions.actionscript.context.support.XMLApplicationContext;

	public class PerspectiveMenuProvider extends AbstractMenuProvider implements IApplicationContextAware
	{
		public var perspectiveManager:PerspectiveManager;

		private var _applicationContext:XMLApplicationContext=null;

		private var perspectiveMenuItem:Object={label: "Open Perspective", children: []};

		private var viewMenuItem:Object={label: "Show View", children: []};

		public function PerspectiveMenuProvider()
		{
			super();
		}

		public function set applicationContext(value:IApplicationContext):void
		{
			this._applicationContext=XMLApplicationContext(value);
		}

		//TODO manage menu items linking views
		//TODO manage Perspective definition xml 
		override public function appendMenuItem(parent:Object):void
		{
			var activePerspectiveName:String=perspectiveManager.perspectives.@active;
			var xmlList:XMLList=perspectiveManager.perspectives.perspective;

			for each (var xml:XML in xmlList)
			{
				perspectiveMenuItem.children.push({ //
						label: xml.@label, //
						perspectiveName: xml.@name, //
						icon: xml.@icon.toString(), //
						toggled: (activePerspectiveName == xml.@name), //
						groupName: "perspectiveGroup", //
						type: "radio", //
						listener: onPerspectiveMenuItemClick //
					});
			}
			parent.children.push(perspectiveMenuItem);

			//
			var dockViews:Array=this._applicationContext.getObjectNamesForType(DockView);
			var dockView:DockView;
			for each (var iViewName:String in dockViews)
			{
				dockView=this._applicationContext.getObject(iViewName);
				viewMenuItem.children.push({ //
						label: dockView.label, //						
						viewName: iViewName, //
						icon: dockView.icon, //
						type: "check", //
						listener: onViewMenuItemClick //
					});
			}

			parent.children.push(viewMenuItem);

			parent.children.push({type: "separator"}); //
			parent.children.push({label: "Customize Perspective..."}); //
			parent.children.push({label: "Save Perspective As..."}); //
			parent.children.push({label: "Reset Perspective..."}); //
			parent.children.push({label: "Close Perspective"}); //
			parent.children.push({label: "Close All Perspectives"}); //

			//
		}
		
		override public function onMenuItemClick(event:MenuEvent):void
		{
			switch (event.label)
			{
				case "Customize Perspective...":
				{
					break;
				}
			}
		}

		private function onPerspectiveMenuItemClick(event:MenuEvent):void
		{
			event.item.toggled=true;

			var perspectiveEvent:PerspectiveEvent=new PerspectiveEvent(PerspectiveEvent.OPEN);
			perspectiveEvent.perspectiveName=event.item.perspectiveName;
			this.publish(perspectiveEvent);
			//			this.perspectiveManager.openPerspective(event.item.perspectiveName);
		}
		private function onViewMenuItemClick(event:MenuEvent):void
		{
			var dockView:DockView  = this._applicationContext.getObject(event.item.viewName) as DockView;
			if(true==event.item.toggled) {
				//TODO add DockView into ViewWindow
			} else {
				var viewWindow:ViewWindow = dockView.parent as ViewWindow;
				viewWindow.selectedChild = dockView;
			}
			event.item.toggled=true;
		}

		override public function afterPropertiesSet():void
		{
			this.subscribe(PerspectiveEvent.OPENED, onPerspectiveOpened);
			//			this.subscribe("openActivePerspective", onOpenActivePerspective);
		}

		private function onPerspectiveOpened(event:PerspectiveEvent):void
		{
			invalidatePerspectiveMenu(event);
			invalidateViewMenu(event);
		}

		private function invalidatePerspectiveMenu(event:PerspectiveEvent):void
		{
			var len:int=perspectiveMenuItem.children.length;
			var item:Object;
			for (var i:int=len - 1; i >= 0; i--)
			{
				item=perspectiveMenuItem.children[i];
				item.toggled=(event.perspectiveName == item.perspectiveName);
			}
		}

		private function invalidateViewMenu(event:PerspectiveEvent):void
		{
			var len:int=viewMenuItem.children.length;

			var xmlList:XMLList=this.perspectiveManager.perspectives.perspective.(@name == event.perspectiveName);
			var perspectiveXml:XML=xmlList[0];
			var views:XMLList=perspectiveXml..View;
			var viewsString:String=views.toXMLString();

			var item:Object;
			for (var i:int=len - 1; i >= 0; i--)
			{
				item=viewMenuItem.children[i];
				var tempToggled:Boolean=(viewsString.indexOf("\"" + item.viewName + "\"") > -1);
				item.toggled=tempToggled;
			}
		}

		private function addView():void
		{
			//			var lbl:String = "(Tab)"+i++;				
			//			var curNum:Number = viewWindow.numChildren + 1;				
			//			var child:Canvas = new Canvas();				
			//			child.setStyle("closable", true);
			//		//	child.setStyle("backgroundColor", 0x0000FF);				
			//			child.label = lbl;
			//			child.icon = documentIconClass;
			//			child.percentWidth =100;
			//			child.percentHeight =100;
			//			var label:Label = new Label();
			//			label.text = "Content for: " + lbl;
			//			
			//			child.addChild(label);
			//			//Alert.show("Do you want to save your changes?", "Save Changes", 3, this, alertClickHandler);
			//			
			//			// Event handler function for displaying the selected Alert button.
			//            function alertClickHandler(event:Event):void {
			//                //if (event.detail==Alert.YES)
			//                   // status.text="You answered Yes";
			//                //else
			//                    //status.text="You answered No";
			//            }				
			//			viewWindow.addChild(child);
		}
	}
}

