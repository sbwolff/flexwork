package com.googlecode.flexwork.core.components
{
	import com.googlecode.flexwork.core.components.ArrowPopUpMenuButton;
	import com.googlecode.flexwork.core.components.StageWindow;
	import com.googlecode.flexwork.core.managers.PerspectiveManager;
	import com.googlecode.flexwork.core.modules.ISystemModule;
	import com.googlecode.flexwork.core.events.PerspectiveEvent;
	
	import mx.containers.HBox;
	import mx.controls.PopUpMenuButton;
	import mx.events.FlexEvent;
	import mx.events.ItemClickEvent;

	public class PerspectiveBox extends HBox
	{
		private var perspectiveSwitcher:PopUpMenuButton=null;

		public var perspectiveBar:PerspectiveBar=null;

		public var perspectiveManager:PerspectiveManager=null;

		public var systemModule:ISystemModule=null;
		public var stageWindow:StageWindow=null;
		include "./../icons.as";



		[Embed(source="/assets/icon/16/open_perspective.gif")]
		public var iconOpenPerspectiveClass:Class;
	
		private var iconMap:Object={ //
				iconMapClass: iconMapClass, //
				iconJavaClass: iconJavaClass, //
				iconFlexClass: iconFlexClass, //
				iconCVSClass: iconCVSClass, //
				iconPeopleClass: iconPeopleClass, //
				iconGraphClass: iconGraphClass //
			};

		[Bindable]
		public var perspectiveToggleItem:Array=[];

		public function PerspectiveBox()
		{
			super();
			this.styleName="perspectiveBox";
			this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
		}

		private function onCreationComplete(event:FlexEvent):void
		{
			var activePerspectiveName:String=perspectiveManager.perspectives.@active;
			var xmlList:XMLList=perspectiveManager.perspectives.perspective;
			var xml:XML;
			var tempSelectedIndex:int=0;

			for (var i:int=0; i < xmlList.length(); i++)
			{
				xml=xmlList[i];

				//xml.@icon.toString()
				//	describeType()
				perspectiveToggleItem.push({ //
						label: xml.@label.toString(), //						
						perspectiveName: xml.@name.toString(), //
						toggled: (activePerspectiveName == xml.@name.toString()), //
						type: "radio", //
						//icon:  Class(systemManager.getDefinitionByName(xml.@icon.toString())) //
						icon: iconMap[xml.@icon.toString()]
					//	,toggle: () //
					});
				if (activePerspectiveName == xml.@name)
				{
					tempSelectedIndex=i;
				}

			}
			//			
			//			var len:int=perspectiveMenuItem.children.length;
			//			var item:Object;
			//			for(var i:int=len-1; i>=0; i--) {
			//				item=perspectiveMenuItem.children[i];
			//				if(event.perspectiveName==item.perspectiveName) {
			//					item.toggled =true;
			//					break;
			//				}
			//			}	


			this.perspectiveSwitcher.dataProvider=perspectiveToggleItem;

			//TODO:			BindingUtils
			this.perspectiveBar.dataProvider=perspectiveToggleItem;
			this.perspectiveBar.selectedIndex=tempSelectedIndex;

			this.systemModule.subscribe(PerspectiveEvent.OPENED, onPerspectiveOpened);

		}

		protected function onPerspectiveToggleButtonBarClick(event:ItemClickEvent):void
		{
			var perspectiveName:String=event.item.perspectiveName;
			var xmlList:XMLList=this.perspectiveManager.perspectives.perspective.(@name == perspectiveName);
			var perspectiveXml:XML=xmlList[0];
			this.stageWindow.openPerspective(perspectiveXml.layout[0]);
			this.systemModule.publish(PerspectiveEvent.createOpenedEvent(perspectiveName));
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			if (!perspectiveSwitcher)
			{
				perspectiveSwitcher=new ArrowPopUpMenuButton();
				perspectiveSwitcher.setStyle("popUpIcon",iconOpenPerspectiveClass);
			}
			this.addChild(perspectiveSwitcher);

			if (!perspectiveBar)
			{
				perspectiveBar=new PerspectiveBar();				
				perspectiveBar.addEventListener(ItemClickEvent.ITEM_CLICK, onPerspectiveToggleButtonBarClick);
			}
			this.addChild(perspectiveBar);
		}

		private function onPerspectiveOpened(event:PerspectiveEvent):void
		{
			var len:int=perspectiveToggleItem.length;
			var item:Object;
			var tempSelectedIndex:int=0;
			for (var i:int=len - 1; i >= 0; i--)
			{
				item=perspectiveToggleItem[i];
				if (event.perspectiveName == item.perspectiveName)
				{
					tempSelectedIndex=i;
					break;
				}
			}
			this.perspectiveBar.selectedIndex=tempSelectedIndex;
		}
	}
}