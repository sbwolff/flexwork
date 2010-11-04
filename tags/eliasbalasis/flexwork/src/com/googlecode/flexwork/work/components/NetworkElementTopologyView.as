package com.googlecode.flexwork.work.components
{
	//http://code.google.com/p/birdeye/
	//http://code.google.com/p/birdeye/
	import flash.events.*;

	import mx.binding.utils.*;
	import mx.containers.*;
	import mx.controls.*;
	import mx.core.*;
	import mx.events.*;

	import com.googlecode.flexwork.core.components.DockingView

	//	__sm = new SocketMonitor(HOSTNAME, PORT_NUMBER);
	//__sm.addEventListener(StatusEvent.STATUS, onNetworkStatusChange);
	//__sm.start();

	public class SocketMonitorView extends Box implements DockingView
	{

		[Embed(source="/assets/explorer.gif")]
		private var iconClass:Class;

		private var tree:Tree;

		public function SocketMonitorView()
		{
			this.icon=iconClass;
			this.label="Explorer";
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

				tree.dataProvider=<root>
						<gallery label="project">
							<file label="cfg">
								<file label="cfg.xml" />
								<file label="cfg.xml" />
							</file>
							<file label="src">
								<file label="src.java" />
								<file label="src.as" />
							</file>
							<file label="tst">
								<file label="tst.java" />
								<file label="tst.as" />
							</file>
							<file label="lib">
								<file label="lib.jar" />
							</file>
							<file label="web">
								<file label="WEB-INF" />
							</file>
						</gallery>
					</root>;
				this.addChild(tree);
			}
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

	}
}