package com.googlecode.flexwork.core.components
{
	public class LayoutDescriptor
	{
		public function LayoutDescriptor()
		{
		}


		public function describeLayout():XML
		{
			var layoutXml:XML= <layout />;

			describeWindowLayout(layoutXml, this.getChildren());

			return layoutXml;
		}

		public function describeWindowLayout(parentXml:XML, children:Array):void
		{
			if (null != children)
			{
				var object:UIComponent;
				var xml:XML;
				for (var i:int=0; i < children.length; i++)
				{
					object=children[i] as UIComponent;

					if (object is SplitWindow)
					{
						var tempSplitWindow:SplitWindow=object as SplitWindow;
						//
						xml=<SplitWindow />;
						xml.@width=tempSplitWindow.percentWidth + "%";
						xml.@height=tempSplitWindow.percentHeight + "%";
						if (true == tempSplitWindow.isHorizontal())
						{
							xml.@direction=tempSplitWindow.direction;
						}
						//
						describeWindowLayout(xml, tempSplitWindow.getChildren());
					}
					else if (object is ViewWindow)
					{
						var tempViewWindow:ViewWindow=object as ViewWindow;
						//
						xml=<ViewWindow />;
						xml.@width=tempViewWindow.percentWidth + "%";
						xml.@height=tempViewWindow.percentHeight + "%";
						//
						describeWindowLayout(xml, tempViewWindow.getChildren());
					}
					else if (object is DockingView)
					{
						xml=<View />;
						var clazz:Class=Class(getDefinitionByName(getQualifiedClassName(object)));
						var objectNames:Array=this._applicationContext.getObjectNamesForType(clazz);
						for (var j:int=0; j < objectNames.length; j++)
						{
							var objectName:String=objectNames[j];
							if (object == this._applicationContext.getObject(objectName))
							{
								xml.@id=objectName;
							}
						}
					}
					parentXml.appendChild(xml);
				}

			}
		}

	}
}