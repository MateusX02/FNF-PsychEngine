package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;
import openfl.Lib;

using StringTools;

class GraphicsSettingsSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Graphics';
		rpcTitle = 'Graphics Settings Menu'; //for Discord Rich Presence

		//I'd suggest using "Low Quality" as an example for making your own option since it is the simplest here
		var option:Option = new Option('Qualidade baixa', //Name
			'Se marcado, as imagens ficaram um pouco pixelada, resultando em maior performance.', //Description
			'lowQuality', //Save data variable name
			'bool', //Variable type
			false); //Default value
		addOption(option);

		var option:Option = new Option('Anti-Aliasing',
			'Se desmarcado, desabilita o Anti Aliasing, resulta em mais FPS.',
			'globalAntialiasing',
			'bool',
			true);
		option.showBoyfriend = true;
		option.onChange = onChangeAntiAliasing; //Changing onChange is only needed if you want to make a special interaction after it changes the value
		addOption(option);

		#if !html5 //Apparently other framerates isn't correctly supported on Browser? Probably it has some V-Sync shit enabled by default, idk
		var option:Option = new Option('Framerate',
			"Nao vou explicar.",
			'framerate',
			'int',
			60);
		addOption(option);
		option.minValue = 60;
		option.maxValue = 240;
		option.displayFormat = '%v FPS';
		option.onChange = onChangeFramerate;
		
		
		var option:Option = new Option('Resolucao de tela',
			"Tamanho da janela [Aperte ACCEPT para aplicar, CANCEL para cancelar]",
			'screenResTemp',
			'string',
			'1280 x 720', ['1280 x 720',
			'1280 x 960',
			'Tela cheia'
			]);
		addOption(option);
		
		if (ClientPrefs.screenRes == "Tela cheia") {
			var option:Option = new Option('Modo de escala',
				"Trocar a escala da tela [Aperte ACCEPT para aplicar, CANCEL para cancelar] (Adaptive não e compativel com Tela cheia.)",
				'screenScaleModeTemp',
				'string',
				'LETTERBOX', ['LETTERBOX',
				'PAN',
				'STRETCH'
				]);
			addOption(option);
		} else {
			var option:Option = new Option('Scale Mode',
				"Scale Mode [Press ACCEPT to apply, CANCEL to cancel] (Adaptive is unstable and may cause visual issues and doesn't work with fullscreen!)",//summerized < 333
				'screenScaleModeTemp',
				'string',
				'LETTERBOX', ['LETTERBOX',
				'PAN',
				'STRETCH',
				'ADAPTIVE'
				]);
			addOption(option);
		}
		// before you tell me "why add adaptive in" i didn't add it in. someone changed the default behavior to be like adaptive which was way too buggy so i'm making it optional
		//thx, niko
		//      -bbpanzu
		ClientPrefs.screenScaleModeTemp = ClientPrefs.screenScaleMode;
		ClientPrefs.screenResTemp = ClientPrefs.screenRes;
		#end

		/*
		var option:Option = new Option('Persistent Cached Data',
			'If checked, images loaded will stay in memory\nuntil the game is closed, this increases memory usage,\nbut basically makes reloading times instant.',
			'imagesPersist',
			'bool',
			false);
		option.onChange = onChangePersistentData; //Persistent Cached Data changes FlxGraphic.defaultPersist
		addOption(option);
		*/



		super();
	}

	override function update (elapsed:Float)
	{
		if(controls.ACCEPT)
		{
			if (curOption.name == "Resolucao de tela")
			{
				ClientPrefs.screenRes = ClientPrefs.screenResTemp;
				if (ClientPrefs.screenRes == "Tela cheia" && ClientPrefs.screenScaleMode == "ADAPTIVE") ClientPrefs.screenScaleMode = "LETTERBOX";
				onChangeRes ();
				MusicBeatState.switchState (new options.OptionsState ());
				FlxG.sound.play(Paths.sound('confirmMenu'));
			} else if (curOption.name == "Modo de escala")
			{
				var shouldReset:Bool = ClientPrefs.screenScaleMode == "ADAPTIVE" || ClientPrefs.screenScaleModeTemp == "ADAPTIVE";
				ClientPrefs.screenScaleMode = ClientPrefs.screenScaleModeTemp;
				if (ClientPrefs.screenScaleMode == "ADAPTIVE") onChangeRes ();
				if (shouldReset) MusicBeatState.switchState (new options.OptionsState ());
				else MusicBeatState.musInstance.fixAspectRatio ();
				FlxG.sound.play(Paths.sound('confirmMenu'));
			}
		}
		super.update(elapsed);
	}

	function onChangeAntiAliasing()
	{
		for (sprite in members)
		{
			var sprite:Dynamic = sprite; //Make it check for FlxSprite instead of FlxBasic
			var sprite:FlxSprite = sprite; //Don't judge me ok
			if(sprite != null && (sprite is FlxSprite) && !(sprite is FlxText)) {
				sprite.antialiasing = ClientPrefs.globalAntialiasing;
			}
		}
	}

	function onChangeFramerate()
	{
		if(ClientPrefs.framerate > FlxG.drawFramerate)
		{
			FlxG.updateFramerate = ClientPrefs.framerate;
			FlxG.drawFramerate = ClientPrefs.framerate;
		}
		else
		{
			FlxG.drawFramerate = ClientPrefs.framerate;
			FlxG.updateFramerate = ClientPrefs.framerate;
		}
	}
	
	public static function onChangeRes()
	{
		FlxG.fullscreen = ClientPrefs.screenRes == "Tela cheia";
		if (!FlxG.fullscreen) {
			var res = ClientPrefs.screenRes.split(" x ");
			FlxG.resizeWindow(Std.parseInt(res[0]), Std.parseInt(res[1]));
			// FlxG.resizeGame(Std.parseInt(res[0]), Std.parseInt(res[1]));
			// Lib.application.window.width = Std.parseInt(res[0]);
			// Lib.application.window.height = Std.parseInt(res[1]);
			// Lib.current.stage.width = Std.parseInt(res[0]);
			// Lib.current.stage.height = Std.parseInt(res[1]);
			FlxCamera.defaultZoom = 1280/Std.parseInt(res[0]);
		}

		MusicBeatState.musInstance.fixAspectRatio ();
		// FlxG.resetState();
	}

}