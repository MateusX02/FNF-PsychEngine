package;

import flixel.FlxG;
import flixel.FlxSprite;

class MainMenuState extends MusicBeatState
{
    var Imagemmano:FlxSprite;

    override function create()
    {
    Imagemmano = new FlxSprite();
    Imagemmano.loadGraphic(Paths.image('Unlocked/BFREANIMADO')); //Omega SUSUSUSUSUSUSUUSUSUSUSUS

    if (controls.BACK) MusicBeatState.switchState(new MainMenuState());
    }
}