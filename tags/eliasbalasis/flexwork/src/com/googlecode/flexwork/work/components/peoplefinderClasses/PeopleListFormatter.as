package com.googlecode.flexwork.work.components.peoplefinderClasses
{
	public class PeopleListFormatter
	{
		//<table style="border-collapse:collapse;" width="97%" align="center" id="MainListTable"></table>
		private static const peopleListTable:RegExp=/<table style="border-collapse:collapse;" width="97%" align="center" id="MainListTable">.*?<\/table>/s;
		
		//<img src="images/plus.gif" style="cursor:hand" onclick="javascript:showLevel('level_shane.robison@hp.com', 'img_shane.robison@hp.com');" id="img_shane.robison@hp.com">
		private static const  patternImg:RegExp=/<img src=".*>/g;
		
		//<br>
		private static const patternBr:RegExp=/<br>/g;
		
		public function PeopleListFormatter()
		{
		}
		
		public function format(string:String):XMLList
		{
			var results:Array=string.match(peopleListTable);

			if (null != results)
			{
				var peopleListString:String=results[0] as String;
				
				peopleListString=peopleListString.replace(patternImg, "<img />");				
				peopleListString=peopleListString.replace(patternBr, "");
				//this.debug("results=\n"+peopleListString);
		

				//return (new XML(peopleListString))..tr;
				return (new XML(peopleListString)).tr;
			}
			return null;
		}

	}
}