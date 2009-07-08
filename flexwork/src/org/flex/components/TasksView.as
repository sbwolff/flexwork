package org.flex.components {

	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	
	import mx.binding.utils.*;
	import mx.containers.*;
	import mx.controls.*;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.core.*;
	import mx.events.*;
	
	import org.flex.dock.views.*

	//http://www.adobe.com/cfusion/exchange/index.cfm?event=extensionDetail&loc=en_us&extid=1055470
	public class TasksView extends Box implements View
	{
		//[ArrayElementType("cairngorm.vo.FriendVO")]
		[Embed(source="/assets/tasks.gif")]
		private var iconClass:Class;
		
		private var labelCtrl:Label;
		
		private var datagrid:DataGrid;
		
//		private var _dataProvider:Object;
		private var tasksData:XML;
//		[Bindable]
//		private var _source:XML;
		private var loader:URLLoader;
		
		
		public function TasksView()
		{
			this.icon = iconClass;
			this.label = "Tasks";
			this.setStyle("verticalGap", 0);
			this.addEventListener(FlexEvent.CREATION_COMPLETE,onCreationComplete);
			
			
		}
 		

		override protected function createChildren():void
	    {
	   		super.createChildren();
	   		
	    	if (!labelCtrl){
				labelCtrl = new Label();
				labelCtrl.text = "Tasks";
				labelCtrl.percentWidth = 100;
				labelCtrl.height = 18;
				this.addChild(labelCtrl);
			}

			var dataGridColumn0:DataGridColumn = new DataGridColumn("@completed");
            dataGridColumn0.headerText = "Completed";
            dataGridColumn0.width = 80;
			//            DataGridColumn1.labelFunction = labelFunc;
//            DataGridColumn1.sortCompareFunction = nameSortCompareFunc;
//            DataGridColumn1.width = 80;
			
			var dataGridColumn1:DataGridColumn = new DataGridColumn("@priority");
            dataGridColumn1.headerText = "Priority";
			dataGridColumn1.width = 80;
			
			var dataGridColumn2:DataGridColumn = new DataGridColumn("@description");
            dataGridColumn2.headerText = "Description";
			dataGridColumn2.width = 350;
			
			var dataGridColumn3:DataGridColumn = new DataGridColumn("@resource");
            dataGridColumn3.headerText = "Resource";
			
			var dataGridColumn4:DataGridColumn = new DataGridColumn("@path");
            dataGridColumn4.headerText = "Path";
//			dataGridColumn4.width = 250;

			var dataGridColumn5:DataGridColumn = new DataGridColumn("@location");
            dataGridColumn5.headerText = "Location";
						
			var dataGridColumn6:DataGridColumn = new DataGridColumn("@type");
            dataGridColumn6.headerText = "Type";
            
			if (!datagrid){
				
				datagrid = new DataGrid();
			
				datagrid.setStyle("borderThickness", 1);
				datagrid.setStyle("borderStyle", "solid");
				datagrid.setStyle("borderSides", "top");
				datagrid.setStyle("paddingTop", 0);
				datagrid.setStyle("paddingBottom", 0);
				datagrid.lockedColumnCount = 1;
				datagrid.headerHeight = 19;//20
				datagrid.rowHeight = 16;
				datagrid.verticalScrollPolicy = ScrollPolicy.AUTO;
				datagrid.horizontalScrollPolicy = ScrollPolicy.AUTO;
				datagrid.columns = [//
					dataGridColumn0,//
					dataGridColumn1,//
					dataGridColumn2,//
					dataGridColumn3,//
					dataGridColumn4,//
					dataGridColumn5,//
					dataGridColumn6//
				];
//				textArea.name = "textArea";
				datagrid.percentWidth = 100;
				datagrid.percentHeight = 100;
//				datagrid.d
//				datagrid.text = "parent.width=" + this.width + "\nparent.height=" + this.height;
				this.addChild(datagrid);
			}
	    }
//	    public function set dataProvider(value:Object):void {
//		 	this._dataProvider = value;
//		}
//private function onComplete(event:Event):void
//{
//    var loader:URLLoader = event.target as URLLoader;
//    if (loader != null)
//    {
//        tasksData = new XML(loader.data);
//        trace(tasksData.toXMLString());
//    }
//    else
//    {
//        trace("loader is not a URLLoader!");
//    }
//}

		private function onCreationComplete(event:FlexEvent):void {
			/*
			loader = new URLLoader();			
			//loader.dataFormat = DataFormat.VARIABLES;
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.addEventListener (IOErrorEvent.IO_ERROR, onURLLoaderIOError);
			loader.addEventListener(Event.COMPLETE,onURLLoaderComplete);
			loader.load(new URLRequest("preferences/tasks.xml"));
			*/
		}

		private function onURLLoaderComplete(event:Event):void {
			var bytes:ByteArray = ByteArray(loader.data);
      		var xmlStr:String = bytes.readMultiByte(bytes.length,"utf-8");			
			this.tasksData = XML(xmlStr);
			datagrid.dataProvider = tasksData.children();
		}
		
		private function onURLLoaderIOError (event:IOErrorEvent):void {
            trace("Load failed: IO error: " + event.text);
        }
	}
}