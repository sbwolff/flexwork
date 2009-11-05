package com.googlecode.flexwork.managers
{
	import com.googlecode.flexwork.events.PerspectiveEvent;
	import com.googlecode.flexwork.modules.SystemModule;

	import org.springextensions.actionscript.ioc.factory.IInitializingObject;

	public class PerspectiveManager extends SystemModule //implements IInitializingObject
	{

		private static var SHARED_OBJECT_PERSPECTIVES:String="shared_object_perspectives";

		//		public var mainWindow:MainWindow;

		public function PerspectiveManager()
		{
			loadSharedObjectPerspectives();
		}

		public function loadSharedObjectPerspectives():void
		{
			//var sharedObjectPerspectives:SharedObject=SharedObject.getLocal(SHARED_OBJECT_PERSPECTIVES);			
		}

		//		public function afterPropertiesSet():void
		//		{
		//			this.subscribe(PerspectiveEvent.OPEN, onPerspectiveOpen);
		//			//			this.subscribe("openActivePerspective", onOpenActivePerspective);
		//		}



		//		public function openPerspective(perspectiveName:String):void
		//		{
		//			var xmlList:XMLList=perspectives.perspective.(@name == perspectiveName);
		//			this.mainWindow.openPerspective(xmlList[0]);
		//			//
		//			var perspectiveEvent:PerspectiveEvent = new PerspectiveEvent(PerspectiveEvent.OPENED);
		//			perspectiveEvent.perspectiveName=perspectiveName;
		//			this.publish(perspectiveEvent);
		//			//var a:SharedObject=SharedObject.getLocal(SHARED_OBJECT_PERSPECTIVES);
		//		}

		//		public function openActivePerspective():void
		//		{
		//			openPerspective(perspectives.@active);
		//		}

		public function get perspectives():XML
		{
			//TODO shareObject
			return _perspectives;
		}

		public function set perspectives(value:XML):void
		{
			//TODO shareObject
			this._perspectives=value;
		}
		[Bindable]
		private var _perspectives:XML=<perspectives active="flex">
			
				<perspective label="Flex" name="flex" icon="iconFlexClass">
					<layout>
						<SplitWindow direction="horizontal">
							<SplitWindow width="40%">		
								<ViewWindow height="40%">
									<View id="tasksView" />
								</ViewWindow>
								<ViewWindow height="60%">
									<View id="explorerView" />
									<View id="hierarchyView" />
									<View id="fileSystemView" />
								</ViewWindow>
							</SplitWindow>	
							<SplitWindow width="60%">							
								<ViewWindow height="60%" closeOnNoChild="false" editor="true">
									<View id="textAreaView" />
								</ViewWindow>								
								<ViewWindow height="40%">								
									<View id="problemsView" />
									<View id="consoleView" />
									<View id="searchView" />
									<View id="progressView" />
								</ViewWindow>
							</SplitWindow>						
						</SplitWindow>
					</layout>
				</perspective>


				<perspective label="Graph" name="graph" icon="iconGraphClass">
					<layout>
						<SplitWindow direction="horizontal">
							<SplitWindow width="30%">
								<ViewWindow height="40%">
									<View id="explorerView" />
								</ViewWindow>
								<ViewWindow height="60%">
									<View id="consoleView" />
								</ViewWindow>
							</SplitWindow>
							<ViewWindow width="70%">							
								<View id="birdEyeView" />
							</ViewWindow>
						</SplitWindow>
					</layout>	
				</perspective>
				
				
				<perspective label="Map" name="map" icon="iconMapClass">
					<layout>
						<SplitWindow direction="horizontal">
							<ViewWindow width="33%">
								<View id="googleMapView" />
							</ViewWindow>
							<ViewWindow width="33%">
								<View id="uMapView" />
							</ViewWindow>
							<ViewWindow width="34%">
								<View id="yahooMapView" />
							</ViewWindow>
						</SplitWindow>
					</layout>
				</perspective>

				

				
				
				<!--
					<perspective label="Java" name="java" icon="iconJavaClass">
					<layout>
						<SplitWindow direction="horizontal">
							<ViewWindow width="25%">
								<View id="explorerView" />
								<View id="hierarchyView" />
								<View id="fileSystemView" />
							</ViewWindow>
							<SplitWindow width="75%">
								<SplitWindow height="60%" direction="horizontal">
									<ViewWindow width="75%">
										<View id="textAreaView" />
									</ViewWindow>
									<ViewWindow width="25%">
										<View id="propertiesView" />
										<View id="outlineView" />
									</ViewWindow>
								</SplitWindow>
								<ViewWindow height="40%">
									<View id="tasksView" />
									<View id="problemsView" />
									<View id="consoleView" />
									<View id="searchView" />
									<View id="progressView" />
								</ViewWindow>
							</SplitWindow>
						</SplitWindow>
					</layout>
				</perspective>

				<perspective label="CVS" name="cvs" icon="iconCVSClass">
					<layout>
						<SplitWindow>
							<SplitWindow height="25%" direction="horizontal">
								<ViewWindow width="50%">
									<View id="explorerView" />
									<View id="hierarchyView" />
								</ViewWindow>
								<ViewWindow width="50%">
									<View id="fileSystemView" />
								</ViewWindow>
							</SplitWindow>						
							<SplitWindow height="50%" direction="horizontal">
								<ViewWindow width="75%">
									<View id="textAreaView" />
								</ViewWindow>
								<ViewWindow width="25%">
									<View id="propertiesView" />
									<View id="outlineView" />
								</ViewWindow>
							</SplitWindow>
							<ViewWindow height="25%">
								<View id="consoleView" />
							</ViewWindow>						
						</SplitWindow>
					</layout>
				</perspective>				
				-->
				
			</perspectives>;
	}
}