package com.googlecode.flexwork.work.components
{
	import com.googlecode.flexwork.core.components.ToolBar;
	import com.googlecode.flexwork.core.components._ToolBarButton;
	import com.googlecode.flexwork.core.events.ToolBarEvent;
	import com.googlecode.flexwork.core.components.DockingView;
	import com.googlecode.flexwork.work.components.peoplefinderClasses.DuplicateValuePeopleListFormatter;
	import com.googlecode.flexwork.work.components.peoplefinderClasses.PeopleDetailFormatter;
	import com.googlecode.flexwork.work.components.peoplefinderClasses.PeopleHierarchyFormatter;
	import com.googlecode.flexwork.work.components.peoplefinderClasses.PeopleListFormatter;
	import com.googlecode.flexwork.core.events.MessageEvent;
	
	import flash.display.DisplayObject;
	import flash.events.*;
	import flash.ui.Keyboard;
	
	import mx.binding.utils.*;
	import mx.collections.ArrayCollection;
	import mx.containers.*;
	import mx.controls.*;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.core.*;
	import mx.events.*;
	import mx.messaging.messages.HTTPRequestMessage;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.mxml.HTTPService;
	//	var params:Object={};
	//			params["target"]="uid=mark.hurd@hp.com,ou=People,o=hp.com";
	//			params["SORT_LNAME"]="";
	//			params["HPOnly"]="True";
	
	//var str:String = "bob@example.com, omar@example.org";
	//var pattern:RegExp = /\w*@\w*\.[org|com]+/g;
	//var results:Array = str.match(pattern);
	public class PeopleFinderView extends DockingView
	{
		private var patternEmail:RegExp = /\w*@\w*\.[org|com]+/g;

		[Embed(source="assets/logo_hp.gif")]
		private var iconClass:Class;
		
		[Embed(source="assets/search.gif")]
		private var iconSearchClass:Class;		
		
		[Embed(source="assets/xls.png")]
		private var iconExportClass:Class;

		[Embed(source="assets/back.gif")]
		private var iconBackClass:Class;
		
		[Embed(source="assets/next.gif")]
		private var iconNextClass:Class;
		
		private var datagrid:DataGrid;

		private var urlPrefix:String="http://peoplefinder.portal.hp.com/peoplefinder/";

		private var httpService:HTTPService;

//		private var detailService:HTTPService;

		private var hierarchyBar:HBox;

		protected var contentBox:VBox;
		//
		private var searchButton:_ToolBarButton;
		
		private var exportButton:_ToolBarButton;
		
		private var hierachyButton:_ToolBarButton;
		
		private var peopleFinder:TextInput;
		
		private var pageIndex:int=1;
		
		private var ceo:Object={ //

				name: "Mark Hurd", //
				Location: "Palo Alto, US", //
				telephone: "+1 650 857 2130", //
				Email: "mark.hurd@hp.com ", //
				aboutMe: "", //
				orgChart: "orgChart.aspx?target='uid=mark.hurd@hp.com,ou=People,o=hp.com'&SORT_LNAME=&HPOnly=True" //
			};

		//		[Bindable]
		//		private var peopleData:XML;

		public function PeopleFinderView()
		{
			super();
			this.icon=iconClass;
			this.label="PeopleFinder";
			
			httpService=new HTTPService();
			//httpService.resultFormat=HTTPService.RESULT_FORMAT_E4X;
			httpService.resultFormat="text";
			httpService.useProxy=false;
			httpService.method=HTTPRequestMessage.GET_METHOD;
			httpService.showBusyCursor=true;
//			httpService.addEventListener(ResultEvent.RESULT, onFindPeopleResult);
			httpService.addEventListener(FaultEvent.FAULT, onFindPeopleFault);
//
//			//
//			detailService=new HTTPService();
//			//httpService.resultFormat=HTTPService.RESULT_FORMAT_E4X;
//			detailService.resultFormat="text";
//			detailService.useProxy=false;
//			detailService.method=HTTPRequestMessage.GET_METHOD;
//			detailService.showBusyCursor=true;
////			detailService.addEventListener(ResultEvent.RESULT, onFindPeopleDetailResult);
////			detailService.addEventListener(FaultEvent.FAULT, onFindPeopleFault);


		}
//override protected function createToolBar():void
//		{
//			
//			toolBarDataProvider=new ArrayCollection([ //
//				{name: "Layout Renderer", type: ToolBar.TYPE_DISPLAY_OBJECT, displayObject: layoutRendererSelector, toolTip: "Layout Renderer"},// 
//				{name: "Layout Renderer", type: ToolBar.TYPE_DISPLAY_OBJECT, displayObject: layoutRendererSelector, toolTip: "Layout Renderer"}//
//				]);
//		}

		override protected function createControlBarChildren():void
		{
			
			var brotherToolBar:HBox =new HBox;
			brotherToolBar.setStyle("borderThickness", 0);
			brotherToolBar.setStyle("verticalAlign", "middle");
			//  brotherToolBar="center"
			brotherToolBar.setStyle("paddingTop", 0);
			brotherToolBar.setStyle("paddingRight", 2);
			brotherToolBar.setStyle("paddingBottom", 0);
			brotherToolBar.setStyle("backgroundColor", 0xD4D0C8);
			brotherToolBar.setStyle("horizontalGap", 0);
			brotherToolBar.setStyle("verticalGap", 0);
			brotherToolBar.percentWidth=99;
			brotherToolBar.percentHeight=100;
			this.controlBar.addChild(brotherToolBar);
			
			if (null == hierarchyBar)
			{
				hierarchyBar=new HBox;
				hierarchyBar.setStyle("borderThickness", 0);
				hierarchyBar.setStyle("verticalAlign", "middle");
				//  horizontalAlign="center"
				hierarchyBar.setStyle("paddingTop", 0);
				hierarchyBar.setStyle("paddingBottom", 0);
				hierarchyBar.setStyle("backgroundColor", 0xD4D0C8);
				hierarchyBar.setStyle("horizontalGap", 0);
				hierarchyBar.setStyle("verticalGap", 0);
				hierarchyBar.percentWidth=99;
				brotherToolBar.addChild(hierarchyBar);
			}
//			addLinkButton(ceo);
			if (null == peopleFinder)
			{
				peopleFinder=new TextInput();
				peopleFinder.width=150;
				peopleFinder.height=20;
//				peopleFinder.addEventListener(KeyboardEvent.KEY_UP, onPeopleFinderkeyUp);
				brotherToolBar.addChild(peopleFinder);
			}
			
			
			
			//
			
			
			createToolBar();
			
		
//			if (null == peopleFinder)
//			{
//				peopleFinder=new TextInput();
//				peopleFinder.width=150;
//				peopleFinder.height=20;
//				peopleFinder.addEventListener(KeyboardEvent.KEY_UP, onPeopleFinderkeyUp);
//				this.controlBar.addChild(peopleFinder);
//			}
		}
		
		
		
		override protected function toolBarData():Array
		{
			searchButton = new _ToolBarButton();
			searchButton.setStyle("icon", iconSearchClass);
			searchButton.toolTip="Find";
			searchButton.addEventListener(MouseEvent.CLICK, onPeopleFinderClick);
			
			exportButton = new _ToolBarButton();
			exportButton.setStyle("icon", iconExportClass);
			exportButton.toolTip="Export";
			exportButton.addEventListener(MouseEvent.CLICK, onPeopleListExport);
			
			hierachyButton = new _ToolBarButton();
			hierachyButton.setStyle("icon", iconSearchClass);
			hierachyButton.toolTip="Hierachy";
			hierachyButton.addEventListener(MouseEvent.CLICK, onPeopleHierachy);
		
			return [ //
				{name: "search", type: ToolBar.TYPE_DISPLAY_OBJECT, displayObject: searchButton, toolTip: "Search"}, //
				{name: "export", type: ToolBar.TYPE_DISPLAY_OBJECT, displayObject: exportButton, toolTip: "Export"}, //
				{name: "hierachy", type: ToolBar.TYPE_DISPLAY_OBJECT, displayObject: hierachyButton, toolTip: "Hierachy"}, //
				{name: "back", icon: iconBackClass, toolTip: "Back"}, //
				{name: "next", icon: iconNextClass, toolTip: "Next"} //
			];			
		}
		
		override public function onToolBarClick(event:ToolBarEvent):void
		{
			var name:String=event.name;
			switch (name)
			{
				case "back":
				{
//					__doPostBack(\'ctl00$contMaster$DDLPagesize\',\'\')', 0)
//					'ctl00$contMaster$gvShow','Page$2'
//					function __doPostBack(eventTarget, eventArgument) {
//    if (!theForm.onsubmit || (theForm.onsubmit() != false)) {
//        theForm.__EVENTTARGET.value = eventTarget;
//        theForm.__EVENTARGUMENT.value = eventArgument;
//        theForm.submit();
//    }
//					document.all("aspnetForm").action = 'peoplefinder.asp'
					
					break;
				}
				case "next":
				{
					
					break;
				}
			}
		}
		
		
		
		private function onPeopleFinderClick(event:MouseEvent):void{
			event.stopImmediatePropagation();
			
			findPeopleByValue(this.peopleFinder.text);			
		}
		
		private function onPeopleListExport(event:MouseEvent):void{
			
			event.stopImmediatePropagation();
			
			this.logDebug("<table border=\"1\">");	
			var peopleRow:String="";	
			for(var ii:int=this.attributes.length-1;ii>=0;ii--) {
				peopleRow=peopleRow+"<td>&nbsp;"+attributes[ii]+"</td>";											
			}
			this.logDebug("<tr>"+peopleRow+"</tr>");	
			var len:int=datagrid.dataProvider.length;
			var people:Object;		
			//for(var index:int=len-1;index>=0;index--) {
			for(var index:int=0;index<len;index++) {	
				people = datagrid.dataProvider[index];
				peopleRow = ""; 
				for(var i:int=this.attributes.length-1;i>=0;i--) {
					peopleRow=peopleRow+"<td>&nbsp;"+people[attributes[i]]+"</td>";											
				}
				this.logDebug("<tr>"+peopleRow+"</tr>");
			}
			this.logDebug("</table>");			
		}

		override public function logDebug(message:String):void
		{
			trace(message);
			super.logError(message);			
		}

		private function onPeopleFinderkeyUp(event:KeyboardEvent):void
		{
			if(event.keyCode==Keyboard.ENTER) {
				findPeopleByValue(this.peopleFinder.text);
			}
		}

		private function addLinkButton(people:Object, showName:Boolean=true):void
		{
			var linkButton:LinkButton=new LinkButton();
			if(showName) {
				linkButton.label=people.name + " >";				
			} else {
				linkButton.label= " >";				
			}
			linkButton.toolTip=people.name+"\n"+people.orgChart+"\n"+people.Email;
			
			linkButton.addEventListener(MouseEvent.MOUSE_OVER, onLinkButtonMouseOver);
			linkButton.addEventListener(MouseEvent.MOUSE_OUT, onLinkButtonMouseOut);
			//			linkButton.
			linkButton.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void
				{ //
					removeLowerLinkButton(event); //
					findPeopleByEmail(people);
				} //
				);
			//	linkButton.addEventListener(MouseEvent.CLICK, onLinkButtonClick(people));

			this.hierarchyBar.addChild(linkButton);
		}

		private function onLinkButtonMouseOver(event:MouseEvent):void {		
			var linkButton:Button=event.target as Button;
			linkButton.label=linkButton.toolTip + " >";	
		}
		
		private function onLinkButtonMouseOut(event:MouseEvent):void {
			var linkButton:Button=event.target as Button;
			linkButton.label= " >";	
		}

		//		private function onLinkButtonClick(people:Object,event:MouseEvent=null):void{
		//		
		//		}

		private function removeLowerLinkButton(event:MouseEvent):void
		{
			var index:int=this.hierarchyBar.getChildIndex(DisplayObject(event.target));
			while (this.hierarchyBar.numChildren - 1 > index)
			{
				//TODO:controlBar.getChildAt(controlBar.numChildren - 1).removeEventListener(MouseEvent.CLICK);
				hierarchyBar.removeChildAt(hierarchyBar.numChildren - 1);
			}
		}

		private var attributes:Array=[//
			"#",//			
			"NT User ID",//			
			"Full Legal Name",//
			"Email",//
			"Company Name",//
			"Telephone Number",//
			"Mobile Number",//
			"Job Function",//
			"Job Family",//
			"Manager",//
			"Organization Unit",//
			"Postal Address",//
			
			"Business Unit",//				
			"Global ID",//
			"Location Code",//					
			"Business Group",//
			"Business Region",//
			"Street",//
			"City",//
			"Country/Region",//
			"Postal Code",//					
			"Time Zone",//
			"Time Zone Name",//			
			"Mail Routing Address",//			
			"Status",//			
			"Employee Type",//
			"Payroll Country Code",//			
			"First Name",//
			"Last Name",//			
			"Maiden Name",//
			"Org. Chart Group",//			
			"MRU Code",//
			"Real Estate ID\Building",//
			"Mail Stop",//
			"Floor",//
			"Post",//
			"Location",//
			"About Me"//
		];
	
		override protected function createChildren():void
		{
			super.createChildren();
			//
			if (null == datagrid)
			{
				
				
//				var dataGridBox:HBox =new HBox;
//				dataGridBox.setStyle("borderThickness", 0);
//				dataGridBox.setStyle("verticalAlign", "middle");
//				//  brotherToolBar="center"
//				dataGridBox.setStyle("paddingTop", 0);
//				dataGridBox.setStyle("paddingBottom", 0);
//				dataGridBox.setStyle("backgroundColor", 0xD4D0C8);
//				dataGridBox.setStyle("horizontalGap", 0);
//				dataGridBox.setStyle("verticalGap", 0);
//				dataGridBox.percentWidth=100;
//				dataGridBox.percentHeight=100;				
//				dataGridBox.horizontalScrollPolicy=ScrollPolicy.ON;
//				dataGridBox.verticalScrollPolicy=ScrollPolicy.ON;
//				this.addChild(dataGridBox);
					
				var dataGridColumns:Array=[];
				var dataGridColumn:DataGridColumn;
			
				var column:String;
				for(var i:int=10;i>=0;i--) {
					column=attributes[i];
					dataGridColumn=new DataGridColumn(column);
					dataGridColumn.headerText=column;
//					dataGridColumn.width=150;
					dataGridColumns.push(dataGridColumn);
				}
		
//				dataGridColumn=new DataGridColumn("rowNum");
//				dataGridColumn.headerText="#";
//				dataGridColumn.width=30;		
//				dataGridColumn.itemRenderer=new ClassFactory(com.googlecode.flexwork.work.components.peoplefinderClasses.RowNumberIndexItemRenderer);
				//
//				dataGridColumns.push(dataGridColumn);
				dataGridColumn=null;
				
				//
				datagrid=new DataGrid();
				datagrid.lockedColumnCount=3;
				datagrid.setStyle("borderThickness", 0);
				//				datagrid.setStyle("borderStyle", "solid");
				//				datagrid.setStyle("borderSides", "top");
				datagrid.setStyle("paddingTop", 0);
				datagrid.setStyle("paddingBottom", 0);
				datagrid.headerHeight=19; //20
				datagrid.rowHeight=16;
				
				datagrid.percentWidth=100;
				datagrid.percentHeight=100;
				
//				datagrid.verticalScrollPolicy=ScrollPolicy.OFF;
//				datagrid.horizontalScrollPolicy=ScrollPolicy.OFF;
				datagrid.verticalScrollPolicy=ScrollPolicy.AUTO;
				datagrid.horizontalScrollPolicy=ScrollPolicy.AUTO;
				datagrid.columns=dataGridColumns.reverse();
								
				datagrid.doubleClickEnabled=true;
				datagrid.addEventListener(MouseEvent.DOUBLE_CLICK, onDatagridDoubleClick);				
				this.addChild(datagrid);
			}
		}
		
		private function findPeopleByEmail(people:Object):void
		{
			this.httpService.url="http://peoplefinder.portal.hp.com/peoplefinder/peoplefinder.aspx?target=uid=" + people.Email + ",ou=People,o=hp.com";
			this.httpService.addEventListener(ResultEvent.RESULT, onFindPeopleByValueResult);
			this.httpService.send();
		}
		
		

		private function onDatagridDoubleClick(event:MouseEvent):void
		{			
			var people:Object=event.currentTarget.selectedItem;
			if (null != people)
			{
				this.peopleFinder.text = people["Email"];
				findPeopleByEmail(people);
			}
		}



		private function findPeopleByValue(value:String):void
		{	
//			pageIndex=1;
			this.httpService.url="http://peoplefinder.portal.hp.com/peoplefinder/?pf_hp=1&pf_detectsearch=1&pf_searchoption=0&pf_searchtype=2&pf_searchval=" + value + "&x=14&y=9";
			this.httpService.addEventListener(ResultEvent.RESULT, onFindPeopleByValueResult);
			this.httpService.send();
		}
		
		
		//
		
		 
		//~
		
		private function onFindPeopleByValueResult(event:ResultEvent):void {
			this.httpService.removeEventListener(ResultEvent.RESULT, onFindPeopleByValueResult);
			
			var resultString:String=event.result as String;
			
			var people:Object = new PeopleDetailFormatter().format(resultString);
			
			if(null!=people) {
				displayPeopleDetailInfoProperties(people);				
				this.findPeopleDetailInfoListByPeople(people);
			} else {
				var duplicateValuePeopleList:XMLList = new DuplicateValuePeopleListFormatter().format(resultString);
				if(null!=duplicateValuePeopleList) {
					displayDuplicateValuePeopleList(duplicateValuePeopleList);
				} else {
					this.logDebug("duplicateValuePeopleList not found");
				}				
			}
		}
		
		private function displayPeopleDetailInfoProperties(people:Object):void
		{
			var messageEvent:MessageEvent=new MessageEvent(PropertiesView.EVENT_SHOW_PROPERTIES);
			messageEvent.value=people;
			this.publish(messageEvent);
		}
		
		private function displayDuplicateValuePeopleList(peopleList:XMLList):void
		{
			this.datagrid.dataProvider=null;
			var data:ArrayCollection=new ArrayCollection();
			
			var people:Object;
			var peopleXml:XML;
			var xml:XML
			//this.debug(root.tr.length + "个马仔");
			var rowNum:int=1;
			for (var i:int=1;i<peopleList.length();i++)//xml:XML in peopleList)
			{
				xml=peopleList[i];
				peopleXml=xml.td[1] as XML;
//				if (peopleXml.hasComplexContent())
//				{
					people={};
					//
					people["#"]=(rowNum++)+"";
					people["Full Legal Name"]=xml.td[0].a.a.text();
					people["Location"]=xml.td[1].span.text();//.replace(/\n*/,"");
					people["Telephone Number"]=xml.td[2].span.text();
					people["Email"]=xml.td[4].a.text();
					people["Organization Unit"]=xml.td[5].span.text();					
					people["About Me"]=xml.td[6].span.text();
					//
					//people["orgChart"]=xml.td[1].a.@href;
					//
					data.addItem(people);					
//				}
			}
			datagrid.dataProvider=data;
			
		}
		private function displayPeopleList(peopleList:XMLList):void//, detailed:Boolean
		{
			this.datagrid.dataProvider=null;
			
			var data:ArrayCollection=new ArrayCollection();
			datagrid.dataProvider=data;//call later result listener
			var people:Object;
			var peopleXml:XML;
			var xml:XML
			//this.debug(root.tr.length + "个马仔");
			var rowNum:int=1;
			for (var i:int=0;i<peopleList.length();i++)//xml:XML in peopleList)
			{
				xml=peopleList[i];
				peopleXml=xml.td[1] as XML;
				if (peopleXml.hasComplexContent())
				{
					people={};
					//
					people["#"]=(rowNum++)+"";
					people["Full Legal Name"]=xml.td[1].a.text();
					people["Location"]=xml.td[3].text();//.replace(/\n*/,"");
					people["Telephone Number"]=xml.td[4].text();
					people["Email"]=xml.td[5].a.text();
					people["About Me"]=xml.td[6].text();
					//
					people["orgChart"]=xml.td[1].a.@href;
					//
					data.addItem(people);
					//
					//if(detailed) {
						this.callLater(findPeopleDetailInfoForList,[people]);
					//}
				}
			}			
		}

		private function findPeopleDetailInfoListByPeople(people:Object):void
		{
			datagrid.dataProvider=null;
			httpService.url=this.urlPrefix + people.orgChart;
			//one person has two email boxs
			//httpService.url=this.urlPrefix + "orgchart.aspx?target='uid=" + people["Email"] + ",ou=People,o=hp.com'&HPOnly=True";			
			httpService.addEventListener(ResultEvent.RESULT, onFindPeopleDetailInfoListByPeople);
			httpService.send();
		}

		private function onFindPeopleDetailInfoListByPeople(event:ResultEvent):void		
		{
			httpService.removeEventListener(ResultEvent.RESULT, onFindPeopleDetailInfoListByPeople);
			
			var resultString:String=event.result as String;
			
			var peopleList:XMLList = new PeopleListFormatter().format(resultString);
			if(null!=peopleList) {			
				displayPeopleList(peopleList);//, true
			} else {
				this.logDebug("peopleList not found");
			}
			var peopleHierarchy:XMLList	=new PeopleHierarchyFormatter().format(resultString);			
			if(null!=peopleHierarchy) {			
				displayPeopleHierarchy(peopleHierarchy);
			} else {
				this.logDebug("peopleHierarchy not found");
			}
			resultString=null;
		}

		private function displayPeopleHierarchy(peopleHierarchy:XMLList):void
		{
			//TODO; release event listener of LinkButton
			this.hierarchyBar.removeAllChildren();

			var people:Object;
			var peopleXml:XML;
			
			for(var i:int=0;i<peopleHierarchy.length();i++)
			{
				peopleXml=peopleHierarchy[i];				
				people={};
				//
				people["name"]=peopleXml.text();
				//
				people["orgChart"]=peopleXml.@href;				
				try {
					people["Email"]=people["orgChart"].match(patternEmail)[0];
			  	}
				catch (err:Error)
				{
				}
				//
				var showName:Boolean = i>(peopleHierarchy.length()-2); //i<0 || 
				this.addLinkButton(people, showName);
			}

		}

		private function findPeopleDetailInfoForList(people:Object):void{
			
			var tempHttpService:HTTPService=new HTTPService();
			//httpService.resultFormat=HTTPService.RESULT_FORMAT_E4X;
			tempHttpService.resultFormat="text";
			tempHttpService.useProxy=false;
			tempHttpService.method=HTTPRequestMessage.GET_METHOD;
			tempHttpService.showBusyCursor=true;
			//httpService.addEventListener(ResultEvent.RESULT, onFindPeopleResult);
			tempHttpService.addEventListener(FaultEvent.FAULT, onFindPeopleFault);
			
			//http://peoplefinder.portal.hp.com/peoplefinder/peoplefinder.aspx?target=uid=aitao.ren@hp.com,ou=People,o=hp.com
			tempHttpService.url="http://peoplefinder.portal.hp.com/peoplefinder/peoplefinder.aspx?target=uid=" + people.Email + ",ou=People,o=hp.com";			
			
			tempHttpService.addEventListener(ResultEvent.RESULT, onFindPeopleDetailInfoForList);
			tempHttpService.send();
		}
		
		private function onFindPeopleDetailInfoForList(event:ResultEvent):void {
			//this.httpService.removeEventListener(ResultEvent.RESULT, onFindPeopleDetailForList);
			
			var resultString:String=event.result as String;
			
			var people:Object = new PeopleDetailFormatter().format(resultString);
			
			if(null!=people) {
				displayPeopleDetailInfoForList(people);
			}
		}

		private function displayPeopleDetailInfoForList(people:Object):void{			
			var len:int=datagrid.dataProvider.length;
			var oldPeople:Object;
			for(var index:int=len-1;index>=0;index--) {
				oldPeople = datagrid.dataProvider[index];
				if(oldPeople.Email==people.Email) {
					for(var i:int=this.attributes.length-3;i>=1;i--) {
						oldPeople[attributes[i]] = people[attributes[i]];						
					}
					oldPeople[attributes[0]] = "(" + oldPeople[attributes[0]] + ")"; 
					//this.datagrid.(index, {backgroundColor:0xFCE85F});					
					break;
				}
			}			
		}































		
//		private function buildPeopleHierarchy(resultString:String):void
//		{
//			var peopleHierarchyTable:RegExp=/<table width="97%" cellpadding="0" cellspacing="2" align="center">.*?<\/table>/s;
//			var results:Array=resultString.match(peopleHierarchyTable);
//
//			if (null != results)
//			{
//				var peopleHierarchyString:String=results[0] as String;
//				//
//				var patternLt:RegExp=/&lt;/g;
//				peopleHierarchyString=peopleHierarchyString.replace(patternLt, "");
//
//				displayPeopleHierarchy(new XML(peopleHierarchyString));
//
//			}
//			else
//			{
//				this.debug("没有老板");
//			}
//		}
//
//		private function buildPeopleList(resultString:String):void
//		{
//			//<table style="border-collapse:collapse;" width="97%" align="center" id="MainListTable"> </table>
//			var peopleListTable:RegExp=/<table style="border-collapse:collapse;" width="97%" align="center" id="MainListTable">.*?<\/table>/s;
//			var results:Array=resultString.match(peopleListTable);
//
//			if (null != results)
//			{
//				var peopleListString:String=results[0] as String;
//
//				//<img src="images/plus.gif" style="cursor:hand" onclick="javascript:showLevel('level_shane.robison@hp.com', 'img_shane.robison@hp.com');" id="img_shane.robison@hp.com">
//				var patternImg:RegExp=/<img src=".*>/g;
//				
//				peopleListString=peopleListString.replace(patternImg, "<img />");
//
//				//<br>
//				var patternBr:RegExp=/<br>/g;
//				peopleListString=peopleListString.replace(patternBr, "");
//				//this.debug("results=\n"+tempString);
//
//
//				displayPeopleList(new XML(peopleListString));
//					//				
//					//				this.debug("results=\n"+results.length);
//
//
//
//			}
//			else
//			{
//				this.debug("没有马仔");
//			}
//		}




//Brad Shi Li
// danny.li@hp.com 
//		private function displayPeopleList(root:XML):void
//		{
//			var data:ArrayCollection=new ArrayCollection();
//			datagrid.dataProvider=data;
//			var item:Object;
//			var td1:XML;
//			this.debug(root.tr.length + "个马仔");
////			for each (var xml:XML in root.tr)
//			for each (var xml:XML in root..tr)
//			{
//				td1=xml.td[1] as XML;
//				if (td1.hasComplexContent())
//				{
//					item={};
//					//
//					item["Full Legal Name"]=xml.td[1].a.text();
//					item["Location"]=xml.td[3].text();//.replace(/\n*/,"");
//					item["Telephone Number"]=xml.td[4].text();
//					item["Email"]=xml.td[5].a.text();
//					item["About Me"]=xml.td[6].text();
//					//
//					item["orgChart"]=xml.td[1].a.@href;
//					//
//					data.addItem(item);
//					this.callLater(findPeopleDetailForList,[item]);
//				}
//			}			
//			//
//			//			//<a href="orgChart.aspx?target='uid=ann.livermore@hp.com,ou=People,o=hp.com'&amp;SORT_LNAME=&amp;HPOnly=True">Ann Livermore</a>
//			//			var pattern:RegExp=/<a href="orgChart\.aspx.*<\/a>/g;
//		}

	
	

		//detail
//		
//		private function findPeopleDetail(searchValue:String):void
//		{
//			this.httpService.url="http://peoplefinder.portal.hp.com/peoplefinder/?pf_hp=1&pf_detectsearch=1&pf_searchoption=0&pf_searchtype=2&pf_searchval=" + searchValue + "&x=14&y=9";
//		}
	
		


//		private function onFindPeopleDetailResult(event:ResultEvent):void
//		{
//
//			var resultString:String=event.result as String;
//
//			var peopleDetailTable:RegExp=/<table class="Body" cellpadding="1" border="0">.*?<\/table>/s;
//			var results:Array=resultString.match(peopleDetailTable);
//
//			if (null != results)
//			{
//				var peopleDetailString:String=results[0] as String;
//				//<br>
//				var patternBr:RegExp=/<br>/g;
//				peopleDetailString=peopleDetailString.replace(patternBr, "");
//
//				//
//				//this.debug("results=\n"+tempString);
//				displayPeopleDetail(new XML(peopleDetailString));
//					//				
//					//				this.debug("results=\n"+results.length);
//
//
//
//			}
//			else
//			{
//				this.debug("没有马仔");
//			}
//		}

	
		//////////
			//Detail
			//http://peoplefinder.portal.hp.com/peoplefinder/peoplefinder.aspx?target=uid=aitao.ren@hp.com,ou=People,o=hp.com
			//searchValue
		//http://peoplefinder.portal.hp.com/peoplefinder/?pf_hp=1&pf_detectsearch=1&pf_searchoption=0&pf_searchtype=2&pf_searchval=XXXXXXX&x=14&y=9
		
		
		private function onFindPeopleFault(event:FaultEvent):void
		{
			Alert.show(event.fault.message, "Fault");
		}
		///////////////////////////////////
		//r
		///////////////////////////////////
		
		private var findedPeople:ArrayCollection=new ArrayCollection();
		private var currentPeople:Object;
		private var tofindPeople:ArrayCollection=new ArrayCollection();
		
		private function onPeopleHierachy(event:MouseEvent):void {
			event.stopImmediatePropagation();
			hierachyFindPeopleDetail();
		}
				
		private function hierachyFindPeopleDetail():void {			
			this.httpService.url = "http://peoplefinder.portal.hp.com/peoplefinder/?pf_hp=1&pf_detectsearch=1&pf_searchoption=0&pf_searchtype=2&pf_searchval=" + this.peopleFinder.text + "&x=14&y=9";
			this.httpService.addEventListener(ResultEvent.RESULT, hierachyOnFindPeopleDetail);
			this.httpService.send();
		
		}
		
		private function hierachyOnFindPeopleDetail(event:ResultEvent):void {
			
			this.httpService.removeEventListener(ResultEvent.RESULT, hierachyOnFindPeopleDetail);
			
			var resultString:String=event.result as String;
			
			var people:Object = new PeopleDetailFormatter().format(resultString);
			
			if(null!=people) {
				tofindPeople.addItem(people);				
				recursiveFindPeopleDetail();
			}
		}
		
		private function recursiveFindPeopleDetail():void {
			if(tofindPeople.length>0) {
				currentPeople = tofindPeople.removeItemAt(0);
				
				//http://peoplefinder.portal.hp.com/peoplefinder/peoplefinder.aspx?target=uid=aitao.ren@hp.com,ou=People,o=hp.com
				httpService.url="http://peoplefinder.portal.hp.com/peoplefinder/peoplefinder.aspx?target=uid=" + currentPeople.Email + ",ou=People,o=hp.com";			
				
				httpService.addEventListener(ResultEvent.RESULT, onRecursiveFindPeopleDetail);
				httpService.send();
				
				
//				this.httpService.url = "http://peoplefinder.portal.hp.com/peoplefinder/?pf_hp=1&pf_detectsearch=1&pf_searchoption=0&pf_searchtype=2&pf_searchval=" + this.peopleFinder.text + "&x=14&y=9";
//				this.httpService.addEventListener(ResultEvent.RESULT, hierachyOnFindPeopleDetail);
//				this.httpService.send();
			
			} else {
				this.datagrid.dataProvider = findedPeople;
			}
		}
		
		private function onRecursiveFindPeopleDetail(event:ResultEvent):void {
			
			this.httpService.removeEventListener(ResultEvent.RESULT, onRecursiveFindPeopleDetail);
			
			var resultString:String=event.result as String;
			
			var people:Object = new PeopleDetailFormatter().format(resultString);
			
			if(null!=people) {
				for(var i:int=this.attributes.length-3;i>=1;i--) {
					currentPeople[attributes[i]] = people[attributes[i]];						
				}	
			}
			findedPeople.addItem(currentPeople);
			this.logDebug("# " + findedPeople.length + " : " + currentPeople["First Name"] + ", " + currentPeople["Last Name"]);
			people = null;			
			////
			//find Ma Zai
			this.httpService.url = this.urlPrefix + currentPeople.orgChart;		
			this.httpService.addEventListener(ResultEvent.RESULT, onRecursiveFindPeopleList);
			this.httpService.send();
		}
		
		private function onRecursiveFindPeopleList(event:ResultEvent):void {
			
			this.httpService.removeEventListener(ResultEvent.RESULT, onRecursiveFindPeopleList);
			
			var resultString:String=event.result as String;
			
			var peopleList:XMLList = new PeopleListFormatter().format(resultString);
			if(null!=peopleList) {			
				var people:Object;
				var peopleXml:XML;
				var xml:XML
				//this.debug(root.tr.length + "个马仔");
				var rowNum:int=1;
				for (var i:int=0;i<peopleList.length();i++)//xml:XML in peopleList)
				{
					xml=peopleList[i];
					peopleXml=xml.td[1] as XML;
					if (peopleXml.hasComplexContent())
					{
						people={};
						//
						people["#"]=(rowNum++)+"";
						people["Full Legal Name"]=xml.td[1].a.text();
						people["Location"]=xml.td[3].text();//.replace(/\n*/,"");
						people["Telephone Number"]=xml.td[4].text();
						people["Email"]=xml.td[5].a.text();
						people["About Me"]=xml.td[6].text();
						//
						people["orgChart"]=xml.td[1].a.@href;
						//
						tofindPeople.addItemAt(people, 0);						
					}
				}
//			} else {
//				this.logDebug("peopleList not found");
			}
//			var peopleHierarchy:XMLList	=new PeopleHierarchyFormatter().format(resultString);			
//			if(null!=peopleHierarchy) {			
//				displayPeopleHierarchy(peopleHierarchy);
//			} else {
//				this.logDebug("peopleHierarchy not found");
//			}
			resultString=null;
			recursiveFindPeopleDetail();
		}
		
	}
}
