package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
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

using StringTools;

class VisualsUISubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Visuals e UI';
		rpcTitle = 'Menu de configuracoes de Visuals & UI'; //for Discord Rich Presence

		var option:Option = new Option('Note Splashes',
			"Se desmarcado, acertar \"Sick!\" nao ira mas mostrar particulas.",
			'noteSplashes',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Esconder HUD',
			'Se marcado, esconde a maioria de imagens do HUD.',
			'hideHud',
			'bool',
			false);
		addOption(option);
		
		var option:Option = new Option('Barra de Tempo:',
			"auto explicativo??",
			'timeBarType',
			'string',
			'Tempo Restante',
			['Tempo Restante', 'Tempo Passado', 'Nome da Musica', 'Desabilitado']);
		addOption(option);

		var option:Option = new Option('Luzes Piscantes',
			"Desmarque caso for sensivel a luzes piscantes!",
			'flashing',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Zooms da Camera',
			"Se desmarcado, a camera nao vai mais dar zooms.",
			'camZooms',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Zoom de Score Text',
			"Se desmarca--Ah mano...",
			'scoreZoom',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Transparencia da barra de vida',
			'Auto explicativo mermao.',
			'healthBarAlpha',
			'percent',
			1);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		addOption(option);
		
		#if !mobile
		var option:Option = new Option('Contador de FPS',
			'Se desmarcado, esconde o counter.',
			'showFPS',
			'bool',
			true);
		addOption(option);
		option.onChange = onChangeFPSCounter;
		#end

		super();
	}

	#if !mobile
	function onChangeFPSCounter()
	{
		if(Main.fpsVar != null)
			Main.fpsVar.visible = ClientPrefs.showFPS;
	}
	#end
}