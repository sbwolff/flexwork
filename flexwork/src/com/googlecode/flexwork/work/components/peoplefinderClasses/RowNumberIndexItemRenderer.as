package com.googlecode.flexwork.work.components.peoplefinderClasses
{

	import mx.controls.Label;
	import mx.controls.dataGridClasses.DataGridListData;

	public class RowNumberIndexItemRenderer extends Label
	{
		public function RowNumberIndexItemRenderer()
		{
			super();			
			this.percentWidth=100;
			this.percentHeight=100;
			this.setStyle("horizontalAlign", "center");
		}

		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			this.text=(listData.rowIndex + 1) + "";
		}


	}
}