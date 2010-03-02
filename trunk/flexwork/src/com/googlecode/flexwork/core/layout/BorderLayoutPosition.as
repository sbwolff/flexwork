package com.googlecode.flexwork.core.layout
{
	import com.googlecode.flexwork.core.layout.BorderLayout;

	public class BorderLayoutPosition
	{
		public var borderLayout:String=BorderLayout.CENTER;

		public var nextBorderLayoutPosition:BorderLayoutPosition;

		public function BorderLayoutPosition()
		{

		}

		public function appendPosition(borderLayout:String):void
		{
			var lastBorderLayoutPosition:BorderLayoutPosition=this;

			while (null != lastBorderLayoutPosition.nextBorderLayoutPosition)
			{
				lastBorderLayoutPosition=lastBorderLayoutPosition.nextBorderLayoutPosition;
			}
			var borderLayoutPosition:BorderLayoutPosition=new BorderLayoutPosition();
			borderLayoutPosition.borderLayout=borderLayout;
			lastBorderLayoutPosition.nextBorderLayoutPosition=borderLayoutPosition;
		}

		public function toDirection():String
		{
			return BorderLayout.toDirection(borderLayout);
		}

		public function isHorizontal():Boolean
		{
			return BorderLayout.isHorizontal(borderLayout);
		}

		public function isVertical():Boolean
		{
			return BorderLayout.isVertical(borderLayout);
		}

		public function childIndex():int
		{
			return BorderLayout.childIndex(borderLayout);
		}
	}
}