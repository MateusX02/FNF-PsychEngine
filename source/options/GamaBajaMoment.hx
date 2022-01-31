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

class GamaBajaMoment extends BaseOptionsMenu
{
	public function new()
	{
		//eu sei lá se isso vai funcionar, eu nem sei programar derp :P
		//aparentemente tá tudo certo?!?!?!?
		title = 'Otimizacao';
		rpcTitle = 'Menu de Otimizacao'; //for Discord Rich Presence

		var option:Option = new Option('Remover Girlfriend',
			"Ajuda no FPS.",
			'gf',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option('Remover todos os personagens',
			"Ajuda no FPS.",
			'personagens',
			'bool',
			false);
		addOption(option);	

		super();
		
		}
	}