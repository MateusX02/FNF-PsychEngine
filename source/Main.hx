package;

import flixel.graphics.FlxGraphic;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import openfl.Assets;
import openfl.Lib;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.display.StageScaleMode;

class Main extends Sprite
{
	var gameWidth:Int = 1280; // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var gameHeight:Int = 720; // Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var initialState:Class<FlxState> = TitleState; // The FlxState the game starts with.
	var zoom:Float = -1; // If -1, zoom is automatically calculated to fit the window dimensions.
	var framerate:Int = 120; // How many frames per second the game should run at.
	var skipSplash:Bool = true; // Whether to skip the flixel splash screen that appears in release mode.
	var startFullscreen:Bool = false; // Whether to start the game in fullscreen on desktop targets
	public static var fpsVar:FPS;
	public static var memoryCounter:MemoryCounter;

	// You can pretty much ignore everything from here on - your code should go in your states.

	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}

	public function new()
	{
		super();

		if (stage != null)
		{
			init();
		}
		else
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

	private function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		setupGame();
	}

	private function setupGame():Void
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (zoom == -1)
		{
			var ratioX:Float = stageWidth / gameWidth;
			var ratioY:Float = stageHeight / gameHeight;
			zoom = Math.min(ratioX, ratioY);
			gameWidth = Math.ceil(stageWidth / zoom);
			gameHeight = Math.ceil(stageHeight / zoom);
		}

		#if !debug
		initialState = TitleState;
		#end
	
		ClientPrefs.loadDefaultKeys();
		FlxGraphic.defaultPersist = true;
		addChild(new FlxGame(gameWidth, gameHeight, initialState, zoom, framerate, framerate, skipSplash, startFullscreen));

		fpsVar = new FPS(10, 3, 0xFFFFFF);
		addChild(fpsVar);
		Lib.current.stage.align = "tl";
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		if(fpsVar != null) {
			fpsVar.visible = ClientPrefs.showFPS;
		}

		memoryCounter = new MemoryCounter(10, 3, 0xffffff);
		addChild(memoryCounter);
		if(memoryCounter != null) {
			memoryCounter.visible = ClientPrefs.showFPS;
		}

		var ourSource:String = "assets/videos/DO NOT DELETE OR GAME WILL CRASH/dontDelete.webm";

		#if web
		var str1:String = "HTML CRAP";
		var vHandler = new VideoHandler();
		vHandler.init1();
		vHandler.video.name = str1;
		addChild(vHandler.video);
		vHandler.init2();
		GlobalVideo.setVid(vHandler);
		vHandler.source(ourSource);
		#elseif desktop
		var str1:String = "WEBM SHIT"; 
		var webmHandle = new WebmHandler();
		webmHandle.source(ourSource);
		webmHandle.makePlayer();
		webmHandle.webm.name = str1;
		addChild(webmHandle.webm);
		GlobalVideo.setWebm(webmHandle);
		#end
		
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onCrash);

		#if html5
		FlxG.autoPause = false;
		FlxG.mouse.visible = false;
		#end

		function onCrash(e:UncaughtErrorEvent):Void
			{
				var errMsg:String = "";
				var path:String;
				var callStack:Array<StackItem> = CallStack.exceptionStack(true);
				var dateNow:String = Date.now().toString();
		
				dateNow = StringTools.replace(dateNow, " ", "_");
				dateNow = StringTools.replace(dateNow, ":", "'");
		
				path = "./crash/" + "NE_" + dateNow + ".txt";
		
				for (stackItem in callStack)
				{
					switch (stackItem)
					{
						case FilePos(s, file, line, column):
							errMsg += file + " (line " + line + ")\n";
						default:
							Sys.println(stackItem);
					}
				}
		
				errMsg += "\nErro não detectado: " + e.error + "\nPor favor reporte isso na página do Github: https://github.com/MateusX02/FNFNitherEngine";
		
				if (!FileSystem.exists("./crash/"))
					FileSystem.createDirectory("./crash/");
		
				File.saveContent(path, errMsg + "\n");
		
				Sys.println(errMsg);
				Sys.println("Crash dump saved in " + Path.normalize(path));
		
				var crashDialoguePath:String = "NE-CrashDialog";
		
				#if windows
				crashDialoguePath += ".exe";
				#end
		
				if (FileSystem.exists("./" + crashDialoguePath))
				{
					Sys.println("Found crash dialog: " + crashDialoguePath);
		
					#if linux
					crashDialoguePath = "./" + crashDialoguePath;
					#end
					new Process(crashDialoguePath, [path]);
				}
				else
				{
					Sys.println("No crash dialog found! Making a simple alert instead...");
					Application.current.window.alert(errMsg, "Error!");
				}
		
				Sys.exit(1);
			}
		}	
