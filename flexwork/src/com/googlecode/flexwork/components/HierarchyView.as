package com.googlecode.flexwork.components
{
	import com.googlecode.flexdock.views.DockView;
	import com.googlecode.flexwork.events.MessageEvent;
	
	import flash.events.*;
	
	import mx.binding.utils.*;
	import mx.containers.*;
	import mx.controls.*;
	import mx.core.*;
	import mx.events.*;
	
	public class HierarchyView extends DockView
	{

		[Embed(source="/assets/globalVillage.gif")]
		private var iconGlobalVillageClass:Class;

		[Embed(source="/assets/country.gif")]
		private var iconCountryClass:Class;

		[Embed(source="/assets/city.gif")]
		private var iconCityClass:Class;

		[Embed(source="/assets/hierarchy.gif")]
		private var iconClass:Class;



		private var tree:Tree;

		public function HierarchyView()
		{
			super();
			this.icon=iconClass;
			this.label="Hierarchy";
		}

		override protected function createChildren():void
		{
			super.createChildren();

			if (!tree)
			{
				tree=new Tree();
				tree.name="tree";
				tree.percentWidth=100;
				tree.percentHeight=100;
				tree.setStyle("borderThickness", 0);
				tree.showRoot=false;
				tree.labelFunction=labelFunction;
				tree.iconFunction = iconFunction;
				tree.doubleClickEnabled = true;
				
				
				tree.dataProvider = this.getModel("cities");
				tree.addEventListener(ListEvent.ITEM_DOUBLE_CLICK, onTreeItemDoubleClick);
				
				this.addChild(tree);
			}
		}

		private function onTreeItemDoubleClick(event:ListEvent):void 
		{
			var node:XML = tree.selectedItem as XML;     // — this will get the node
			if(!tree.dataDescriptor.isBranch(node)) {
				var messageEvent:MessageEvent = new MessageEvent(MessageEvent.CITY_DOUBLE_CLICK);
				messageEvent.value = node;
				this.publish(messageEvent);
			}
//			var isOpen:Boolean = node..tree..isItemOpen(node);  //  — this will check tree is opened or not
//			tree.expandItem(node, !isOpen);                //         — this will expand the tree if not and close if opened (viceversa)
		}
		
		private function labelFunction(item:Object):String
		{
			var suffix:String="";
			if (tree.dataDescriptor.isBranch(item))
			{
				suffix=" (" + item.children().length() + ")";
			}
			return item.@label + suffix;
		}
		
		private function iconFunction(item:Object):Class 
		{
			 var iconClass:Class;
                switch (XML(item).localName()) {
                    case "globalVillage":
                        iconClass = iconGlobalVillageClass;
                        break;
                    case "country":
                        iconClass = iconCountryClass;
                        break;
                    case "city":
                        iconClass = iconCityClass;
                        break;
                }
                return iconClass;
		}
	}
}