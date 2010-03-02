package com.googlecode.flexwork.work.components.peoplefinderClasses
{
	public class DuplicateValuePeopleListFormatter
	{
		//
		private static const peopleListTable:RegExp=/<tr class="ContentHeader" align="left" valign="middle" style="font-weight:bold;font-style:normal;text-decoration:none;">.*?<tr align="right" style="background-color:#E1E1E1;border-width:0px;border-style:None;height:0px;width:0px;">/s;
		
		//
		private static const patternSuffiex:RegExp=/<tr align="right" style="background-color:#E1E1E1;border-width:0px;border-style:None;height:0px;width:0px;">/;
		
		//<br>
		private static const patternBr:RegExp=/<br>/g;
		
		//<a href=javascript:pop_window_scroll('PeopleFinder.aspx?target=uid=xxxxx@hp.com,ou=People,o=hp.com','popup','550','800')>
		private static const patternA:RegExp=/<a href=javascript:pop_window_scroll.*?>/g;
		
		//&nbsp;
		private static const patternNbsp:RegExp=/&nbsp;/g;
				
		//
		private static const patternTable:RegExp=/<table border="0">.*?<\/table>/s;
		
		//
		private static const patternAndSpace:RegExp=/& /g;
		
		public function DuplicateValuePeopleListFormatter()
		{
		}
		
		public function format(string:String):XMLList
		{
			var results:Array=string.match(peopleListTable);

			if (null != results)
			{
				var peopleListString:String=results[0] as String;
				
				peopleListString=peopleListString.replace(patternTable, "");
				
				peopleListString=peopleListString.replace(patternA, "<a>");
				
				peopleListString=peopleListString.replace(patternSuffiex, "");
				
				peopleListString=peopleListString.replace(patternBr, "");				
				
				peopleListString=peopleListString.replace(patternNbsp, "");
				
				peopleListString=peopleListString.replace(patternAndSpace, "&amp; ");
				
//				this.debug("DuplicateValuePeopleListFormatter result=\n"+"<xml>"+peopleListString+"</xml>");
		
				return (new XMLList(peopleListString));
			}
			return null;
		}

	}
}