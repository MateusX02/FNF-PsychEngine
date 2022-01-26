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
		title = 'Visuals and UI';
		rpcTitle = 'Visuals & UI Settings Menu'; //for Discord Rich Presence

		var option:Option = new Option('Splashes das notas',
			"Se desmarcado, as notas nao vao mais ter particulas.",
			'noteSplashes',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Esconder HUD',
			'Se marcado, esconde a maior parte do HUD.',
			'hideHud',
			'bool',
			false);
		addOption(option);
		
		var option:Option = new Option('Barra de Tempo:',
			"Nao vou dizer nada.",
			'timeBarType',
			'string',
			'Tempo restante',
			['Tempo restante', 'Tempo passado', 'Nome da musica', 'Desabilitado']);
		addOption(option);

		var option:Option = new Option('Luzes Piscantes',
			"Desative se voce e sensivel!",
			'flashing',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Zooms da camera',
			"Se desmarcado, a tela nao vai mais dar zoom.",
			'camZooms',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Zoom de texto de pontuação ao acertar',
			"Nao vou dizer nada. (denovo)",
			'scoreZoom',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Transparencia da barra de HP',
			'Quao transparentes a barra e os icones vao ser.',
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
		var option:Option = new Option('FPS Counter',
			'If unchecked, hides FPS Counter.',
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