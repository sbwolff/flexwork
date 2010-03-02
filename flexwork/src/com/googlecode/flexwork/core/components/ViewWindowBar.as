package com.googlecode.flexwork.core.components
{

	import mx.core.EdgeMetrics;
	import mx.containers.HBox;

	public class ViewWindowBar extends HBox
	{

		public function ViewWindowBar()
		{
			super();
			//titleBar.direction = BoxDirection.HORIZONTAL;
			setStyle("verticalAlign", "middle");
			styleName="viewWindowBar";
			//	addEventListener("creationComplete", handleCreationComplete); 
		}


		override public function get viewMetrics():EdgeMetrics
		{
			var vm:EdgeMetrics=new EdgeMetrics(0, 0, 0, 0);
			var o:EdgeMetrics=super.viewMetrics;

			var bt:Number=getStyle("borderThickness");

			vm.top=0;
			vm.left=0;
			vm.right=0;
			vm.bottom=0;
			return vm;
		}

		override public function get borderMetrics():EdgeMetrics
		{
			var bm:EdgeMetrics=super.borderMetrics;
			//bm.bottom=2;
			return bm;
		}
	}
}