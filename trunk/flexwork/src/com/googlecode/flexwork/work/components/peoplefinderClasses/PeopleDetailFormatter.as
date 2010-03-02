package com.googlecode.flexwork.work.components.peoplefinderClasses
{
	public class PeopleDetailFormatter
	{		
		//<table class="Body" cellpadding="1" border="0"></table>
		private static const peopleDetailTable:RegExp=/<table class="Body" cellpadding="1" border="0">.*?<\/table>/s;
		
		//<br>
		private static const patternBr:RegExp=/<br>/g;
		
		private var details:Array = [//
			{label:"First Name", trIndex:0, tdIndex:1},//
			{label:"Last Name", trIndex:0, tdIndex:4},//
			
			{label:"Maiden Name", trIndex:2, tdIndex:1},//
			
			
			{label:"Time Zone", trIndex:4, tdIndex:4},//
			{label:"Telephone Number", trIndex:7, tdIndex:1},//
			{label:"Mobile Number", trIndex:7, tdIndex:4}//
					
		];
	
		public function PeopleDetailFormatter()
		{
		}
		
		private static const orgChartRegExp:RegExp=/<table border="0" align="center" cellpadding="11px">.*?<\/table>/s;
		
		public function format(string:String):Object
		{
			var results:Array=string.match(peopleDetailTable);
			
			if(null!=results) {
				var peopleDetailString:String=results[0] as String;
				peopleDetailString=peopleDetailString.replace(patternBr, "<br />");
				var people:Object = populatePeople(new XML(peopleDetailString));
				//orgChart
				//
				var orgChartResults:Array=string.match(orgChartRegExp);
				
				if(null!=orgChartResults) {
					var orgChartResultString:String = orgChartResults[0] as String;
					orgChartResultString=orgChartResultString.replace(/<\/a>/g, "</img></a>");					
					people["orgChart"] = new XML(orgChartResultString).tr.td[1].a.@href;
				} else {
					people["orgChart"] = "orgChart.aspx?target='uid=" + people.Email + ",ou=People,o=hp.com'&SORT_LNAME=&HPOnly=True";
				}
				//
				return people;
			}
			return null;			
		}
		
		private function populatePeople(peopleXml:XML):Object{
			var people:Object={};
			var detail:Object;
//			var pattern:RegExp=/\n/g;
			for(var i:int=details.length-1;i>=0;i--) {
				detail=details[i];
				try {
					people[detail.label]="" + peopleXml.tr[detail.trIndex].td[detail.tdIndex].text();//.replace(pattern, "");
			  	}
				catch (err:Error)
				{
				}				
			}
			try {
				//people["Full Legal Name"]=peopleXml.tr[1].td[1].*[0] + " " + peopleXml.tr[1].td[1].*[2];
				people["Full Legal Name"]=peopleXml.tr[1].td[1].*[0];
		  	}
			catch (err:Error)
			{
			}
			try {
				people["Company Name"]=peopleXml.tr[3].td[1].*[0];
		  	}
			catch (err:Error)
			{
			}
			try {
				people["Street"]=peopleXml.tr[3].td[1].script.text();
		  	}
			catch (err:Error)
			{
			}
			try {
				people["City"]=peopleXml.tr[3].td[1].*[3];
		  	}
			catch (err:Error)
			{
			}
			try {
				people["Country/Region"]=peopleXml.tr[3].td[1].*[5];
		  	}
			catch (err:Error)
			{
			}
			try {
				people["Postal Code"]=peopleXml.tr[3].td[1].*[7];
		  	}
			catch (err:Error)
			{
			}			
			try {
				people["Postal Address"]=peopleXml.tr[3].td[4].*[0] + " " + peopleXml.tr[3].td[4].*[2] + " " + peopleXml.tr[3].td[4].script.text();
		  	}
			catch (err:Error)
			{
			}
			try {
				var b:String = peopleXml.tr[4].td[1].*[1];
				people["Real Estate ID\Building"]=b.replace(/\\/, "");
		  	}
			catch (err:Error)
			{
			}
			try {
				people["Mail Stop"]=peopleXml.tr[4].td[1].*[3];
		  	}
			catch (err:Error)
			{
			}
			try {
				people["Floor"]=peopleXml.tr[4].td[1].*[5];
		  	}
			catch (err:Error)
			{
			}
			try {
				people["Post"]=peopleXml.tr[4].td[1].*[7];
		  	}
			catch (err:Error)
			{
			}
			try {
				people["Time Zone Name"]=peopleXml.tr[4].td[4].a[0].text();
		  	}
			catch (err:Error)
			{
			} 
			try {
				people["Email"]=peopleXml.tr[4].td[4].a[1].font.text();
		  	}
			catch (err:Error)
			{
			} 		
			try {
				people["Mail Routing Address"]=peopleXml.tr[5].td[4].a.font.text();
		  	}
			catch (err:Error)
			{
			}	
			try {
				people["Status"]=peopleXml.tr[10].td[1].script.text();
		  	}
			catch (err:Error)
			{
			}	
			try {
				people["Job Function"]=peopleXml.tr[10].td[1].*[2];
		  	}
			catch (err:Error)
			{
			}	
			try {
				people["Job Family"]=peopleXml.tr[10].td[1].*[4];
		  	}
			catch (err:Error)
			{
			}	
			try {
				people["Employee Type"]=peopleXml.tr[10].td[1].*[6];
		  	}
			catch (err:Error)
			{
			}	
			try {
				people["Payroll Country Code"]=peopleXml.tr[10].td[1].*[8];
		  	}
			catch (err:Error)
			{
			}	
			try {
				people["NT User ID"]=peopleXml.tr[10].td[1].*[10];
		  	}
			catch (err:Error)
			{
			}	
			try {
				people["Global ID"]=peopleXml.tr[10].td[1].*[12];
		  	}
			catch (err:Error)
			{
			}	
			try {
				people["Manager"]=peopleXml.tr[10].td[1].a[0].text();
		  	}
			catch (err:Error)
			{
			}
			try {
				people["Location Code"]=peopleXml.tr[10].td[4].*[0];
		  	}
			catch (err:Error)
			{
			}	
			try {
				people["Organization Unit"]=peopleXml.tr[10].td[4].*[2];
		  	}
			catch (err:Error)
			{
			}	
			try {
				people["Org. Chart Group"]=peopleXml.tr[10].td[4].*[4];
		  	}
			catch (err:Error)
			{
			}	
			try {
				people["Business Unit"]=peopleXml.tr[10].td[4].*[6];
		  	}
			catch (err:Error)
			{
			}	
			try {
				people["Business Group"]=peopleXml.tr[10].td[4].*[8];
		  	}
			catch (err:Error)
			{
			}	
			try {
				people["Business Region"]=peopleXml.tr[10].td[4].*[10];
		  	}
			catch (err:Error)
			{
			}	
			try {
				people["MRU Code"]=peopleXml.tr[10].td[4].*[12];
		  	}
			catch (err:Error)
			{
			}				
			return people;
		}

		
	}
}