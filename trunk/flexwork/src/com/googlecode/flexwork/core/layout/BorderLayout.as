package com.googlecode.flexwork.core.layout
{
	import mx.containers.BoxDirection;

	/** java.awt.BorderLayout */
	public class BorderLayout
	{
		public static const FIRST:int=0;

		public static const LAST:int=1;

		public static const NORTH:String="North";

		public static const SOUTH:String="South";

		public static const EAST:String="East";

		public static const WEST:String="West";

		public static const CENTER:String="Center";

		public static function toDirection(borderLayout:String):String
		{
			if (BorderLayout.EAST == borderLayout || BorderLayout.WEST == borderLayout)
			{
				return BoxDirection.HORIZONTAL;
			}
			else if (BorderLayout.NORTH == borderLayout || BorderLayout.SOUTH == borderLayout)
			{
				return BoxDirection.VERTICAL;
			}
			//throw exception
			return BoxDirection.HORIZONTAL;
		}

		public static function childIndex(borderLayout:String):int
		{
			if (BorderLayout.SOUTH == borderLayout || BorderLayout.EAST == borderLayout)
			{
				return LAST;
			}
			return FIRST;
		}

		public static function isHorizontal(borderLayout:String):Boolean
		{
			if (BorderLayout.EAST == borderLayout || BorderLayout.WEST == borderLayout)
			{
				return true;
			}
			return false;
		}

		public static function isVertical(borderLayout:String):Boolean
		{
			if (BorderLayout.NORTH == borderLayout || BorderLayout.SOUTH == borderLayout)
			{
				return true;
			}
			return false;
		}



	}
}