package com.googlecode.flexdock.utils
{

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
		
		public function horizontal():Boolean
		{
			if (BorderLayout.EAST==borderLayout||BorderLayout.WEST==borderLayout)
			{
				return true;
			}
			return false;
		}
		
		public function vertical():Boolean
		{
			if (BorderLayout.NORTH==borderLayout||BorderLayout.SOUTH==borderLayout)
			{
				return true;
			}
			return false;
		}
		public function childIndex():int {
			if (BorderLayout.SOUTH==borderLayout||BorderLayout.WEST==borderLayout)
			{
				return 1;
			}
			return 0;
		}

	}
}