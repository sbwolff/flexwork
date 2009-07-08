package org.flex.components {

	import flash.events.*;
	
	import mx.binding.utils.*;
	import mx.containers.*;
	import mx.controls.*;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.core.*;
	import mx.events.*;
	
	import org.flex.dock.views.*
    //http://www.adobe.com/cfusion/exchange/index.cfm?event=extensionDetail&loc=en_us&extid=1055470
	//http://www.adobe.com/cfusion/exchange/index.cfm?event=extensionDetail&loc=en_us&extid=1055470
	public class ProblemsView extends Box implements View
	{
		
		[Embed(source="/assets/problems.gif")]
		private var iconClass:Class;
		
		private var labelCtrl:Label;
		
		private var datagrid:DataGrid;
		
		
		public function ProblemsView()
		{
			this.icon = iconClass;
			this.label = "Problems";
			this.setStyle("verticalGap", 0);
		}

		override protected function createChildren():void
	    {
	   		super.createChildren();
	    	if (!labelCtrl){
				labelCtrl = new Label();
				labelCtrl.text = "Problems";
				labelCtrl.percentWidth = 100;
				labelCtrl.height = 18;
				this.addChild(labelCtrl);
			}
			
			var dataGridColumn0:DataGridColumn = new DataGridColumn("@description");
            dataGridColumn0.headerText = "Description";
            dataGridColumn0.width = 200;
			//            DataGridColumn1.labelFunction = labelFunc;
//            DataGridColumn1.sortCompareFunction = nameSortCompareFunc;
//            DataGridColumn1.width = 80;
			
			var dataGridColumn1:DataGridColumn = new DataGridColumn("@resource");
            dataGridColumn1.headerText = "Resource";

			var dataGridColumn2:DataGridColumn = new DataGridColumn("@path");
            dataGridColumn2.headerText = "Path";
			
			var dataGridColumn3:DataGridColumn = new DataGridColumn("@location");
            dataGridColumn3.headerText = "Location";
			
			var dataGridColumn4:DataGridColumn = new DataGridColumn("@type");
            dataGridColumn4.headerText = "Type";
			
			if (!datagrid){
				datagrid = new DataGrid();
				
				datagrid.setStyle("borderThickness", 1);
				datagrid.setStyle("borderStyle", "solid");
				datagrid.setStyle("borderSides", "top");
				datagrid.setStyle("paddingTop", 0);
				datagrid.setStyle("paddingBottom", 0);
				
				datagrid.headerHeight = 19;//20
				datagrid.rowHeight = 16;
				datagrid.verticalScrollPolicy = ScrollPolicy.AUTO;
				datagrid.horizontalScrollPolicy = ScrollPolicy.AUTO;
				datagrid.columns = [//
				dataGridColumn0,//
				dataGridColumn1,//
				dataGridColumn2,//
				dataGridColumn3,//
				dataGridColumn4//
				];
//				textArea.name = "textArea";
				datagrid.percentWidth = 100;
				datagrid.percentHeight = 100;
//				datagrid.d
//				datagrid.text = "parent.width=" + this.width + "\nparent.height=" + this.height;
				this.addChild(datagrid);
			}
	    }

	}
}