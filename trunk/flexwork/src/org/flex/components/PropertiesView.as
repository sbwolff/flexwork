package org.flex.components {

	import flash.events.*;
	
	import mx.binding.utils.*;
	import mx.containers.*;
	import mx.controls.*;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.core.*;
	import mx.events.*;
	
	import org.flex.dock.views.*
	
	//http://flexlib.googlecode.com/svn/trunk/examples/ConvertibleTreeList/ConvertibleTreeList_Sample.swf
		public class PropertiesView extends Box implements View
	{
		
		[Embed(source="/assets/properties.gif")]
		private var iconClass:Class;
		
		private var labelCtrl:Label;
		
		private var datagrid:DataGrid;
		
		
		public function PropertiesView()
		{
			this.icon = iconClass;
			this.label = "Properties";
			this.setStyle("verticalGap", 0);
		}

		override protected function createChildren():void
	    {
	   		super.createChildren();
	   		 
	    	if (!labelCtrl){
				labelCtrl = new Label();
				labelCtrl.text = "Properties";
				labelCtrl.percentWidth = 100;
				labelCtrl.height = 18;
				this.addChild(labelCtrl);
			}
			
			var dataGridColumn0:DataGridColumn = new DataGridColumn("@property");
            dataGridColumn0.headerText = "Property";
//            dataGridColumn0.width = 200;
			
			var dataGridColumn1:DataGridColumn = new DataGridColumn("@value");
            dataGridColumn1.headerText = "Value";
			
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
				dataGridColumn1
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