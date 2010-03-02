package com.googlecode.flexwork.work
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;

	import org.springextensions.actionscript.context.support.FlexXMLApplicationContext;
	import com.googlecode.flexwork.core.managers.MessageEventBusManager;
	import mx.controls.Alert;
	import mx.containers.Panel;
	import mx.events.CloseEvent;
	import mx.resources.ResourceBundle;

	import com.googlecode.flexwork.work.*;

	import com.googlecode.flexwork.core.cursors.*;
	import com.googlecode.flexwork.core.components.*;
	import com.googlecode.flexwork.core.managers.*; //
	import com.googlecode.flexwork.core.modules.*; //
	import com.googlecode.flexwork.core.events.*; //	
	
	import com.googlecode.flexwork.work.components.*; //		
	import com.googlecode.flexwork.work.menus.*; //

	public class OnlyForForceBuild
	{

		public function OnlyForForceBuild()
		{



			new SystemModule();
			new BoxSystemModule();

			new EastWestCursor();
			new SouthNorthCursor();


			new FileMenuProvider();
			new EditMenuProvider();
			new SourceMenuProvider();
			new NavigateMenuProvider();
			new SearchMenuProvider();
			new ProjectMenuProvider();
			new DataMenuProvider();
			new RunMenuProvider();

			new PerspectiveMenuProvider();
			new WindowMenuProvider();
			new HelpMenuProvider();

			new MenuBarProvider();

			new MainWindow();

			new MessageEventBusManager();
			new LogManager();
			new ModelManager();
			new ThreadManager();

			new PerspectiveManager();

			new ExplorerView();
			new HierarchyView();
			new FileSystemView();
			new TextAreaView();
			new TextEditor();
			new PropertiesView();
			new OutlineView();
			new TasksView();
			new ProblemsView();
			new ConsoleView();
			new SearchView();
			new ProgressView();

			new GoogleMapView();
			new TwitterView();
			new YouTubeView();
			new YahooMapView();
			new UMapView();

			new FlickrView();
			new BirdEyeView();
			
			new WorkflowEditor();
			new WorkflowActivityView();
			
		}

	}
}