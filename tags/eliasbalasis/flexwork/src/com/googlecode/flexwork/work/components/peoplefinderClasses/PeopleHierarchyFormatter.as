package com.googlecode.flexwork.work.components.peoplefinderClasses
{
/*
   <table width="97%" cellpadding="0" cellspacing="2" align="center">
   <tr>
   <td>
   <a href="orgChart.aspx?target='uid=mark.hurd@hp.com,ou=People,o=hp.com'&amp;SORT_LNAME=&amp;HPOnly=True">Mark Hurd</a>
   &lt;
   <a href="orgChart.aspx?target='uid=ann.livermore@hp.com,ou=People,o=hp.com'&amp;SORT_LNAME=&amp;HPOnly=True">Ann Livermore</a>
   &lt;
   <a href="orgChart.aspx?target='uid=joe.eazor@hp.com,ou=People,o=hp.com'&amp;SORT_LNAME=&amp;HPOnly=True">JOE EAZOR</a>
   &lt;
   <a href="orgChart.aspx?target='uid=robb.rasmussen@hp.com,ou=People,o=hp.com'&amp;SORT_LNAME=&amp;HPOnly=True">Robb Rasmussen</a>
   &lt;
   <a href="orgChart.aspx?target='uid=alai@hp.com,ou=People,o=hp.com'&amp;SORT_LNAME=&amp;HPOnly=True">Andy Lai</a>
   &lt;
   <a href="orgChart.aspx?target='uid=yiming.sha@hp.com,ou=People,o=hp.com'&amp;SORT_LNAME=&amp;HPOnly=True">Yi-Ming Sha</a>
   &lt;
   <a href="orgChart.aspx?target='uid=dan-qi.zhao@hp.com,ou=People,o=hp.com'&amp;SORT_LNAME=&amp;HPOnly=True">Dan-Qi Zhao</a>
   &lt;
   </td>
   </tr>
   </table>
 */
	public class PeopleHierarchyFormatter
	{		
		//<table width="97%" cellpadding="0" cellspacing="2" align="center"></table>
		private static const peopleHierarchyTable:RegExp=/<table width="97%" cellpadding="0" cellspacing="2" align="center">.*?<\/table>/s;
		
		//&lt;
		private static const patternLt:RegExp=/&lt;/g;
	
		public function PeopleHierarchyFormatter()
		{
		}
		
		public function format(string:String):XMLList
		{
		
			var results:Array=string.match(peopleHierarchyTable);

			if (null != results)
			{
				var peopleHierarchyString:String=results[0] as String;
			
				peopleHierarchyString=peopleHierarchyString.replace(patternLt, "");

				return (new XML(peopleHierarchyString)).tr.td.a;
			}
		return null;
		}
		
		
	}
}