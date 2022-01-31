package;
import flixel.FlxSprite;
import flixel.*;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

// Autor: BBPanzu
// Modificações: MateusX02

class UnlockedState extends FlxState
{

	public function new() 
	{
		super();
	}
	
	override public function create():Void 
	{
		super.create();
		
		var SPRITE:FlxSprite = new FlxSprite(0, 0);
		SPRITE.loadGraphic("assets/shared/Unlocked/BFREANIMADO.png", false, 1280, 720);
		add(SPRITE);
	}
	public override function update(elapsed){
		
        // Aqui vai ativar o bagui denovo (Eu fiz esse State novo, por conta de bugs e tal)
		if (FlxG.keys.justPressed.ENTER){
			ClientPrefs.unlockedbf = true;
			FlxG.switchState(new MainMenuState());
		}
		if (FlxG.keys.justPressed.BACKSPACE){
			ClientPrefs.unlockedbf = true;
			FlxG.switchState(new MainMenuState());
		}
		super.update(elapsed);
	}
	
}