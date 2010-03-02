package com.googlecode.flexwork.work.components
{
	import com.googlecode.flexwork.work.events.PerspectiveEvent;
	import com.googlecode.flexwork.managers.PerspectiveManager;
	import com.googlecode.flexwork.core.modules.ISystemModule;
	
	import mx.controls.ToggleButtonBar;
	import mx.events.FlexEvent;

	//	<!-- mx:ToggleButtonBar id="perspectiveSwitcher" styleName="toggleButtonBar"
	//								itemClick="onPerspectiveToggleButtonBarClick(event);">
	//				<mx:dataProvider>
	//					<mx:Object label="Graph" perspective="graph"
	//							   icon="@Embed(source='/assets/map.gif')"/>
	//					<mx:Object label="Java" perspective="java"
	//							   icon="@Embed(source='/assets/java.gif')"/>
	//					<mx:Object label="Flex" perspective="flex"
	//							   icon="@Embed(source='/assets/flex.gif')"/>
	//					<mx:Object label="CVS" perspective="cvs" icon="@Embed(source='/assets/cvs.gif')"/>
	//				</mx:dataProvider>
	//			</mx:ToggleButtonBar -->
	public class PerspectiveBarBack extends ToggleButtonBar
	{
		public var systemModule:ISystemModule=null;	
	
		include "./../icons.as";

		private var iconMap:Object={//
			iconMapClass:iconMapClass,//
			iconJavaClass:iconJavaClass,//
			iconFlexClass:iconFlexClass,//
			iconCVSClass:iconCVSClass,//
			iconPeopleClass:iconPeopleClass,//
			iconGraphClass:iconGraphClass//
		};


		public var perspectiveManager:PerspectiveManager;

		[Bindable]
		public var perspectiveToggleItem:Array=[];

		public function PerspectiveBarBack()
		{
			super();
			this.styleName="toggleButtonBar";
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


			//TODO:			BindingUtils
			this.dataProvider=perspectiveToggleItem;
			this.selectedIndex=tempSelectedIndex;
			
			this.systemModule.subscribe(PerspectiveEvent.OPENED, onPerspectiveOpened);
		}
		
		private function onPerspectiveOpened(event:PerspectiveEvent):void {
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
			this.selectedIndex=tempSelectedIndex;
		}
		
	}
}