package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;

class UnlockedState extends MusicBeatState
{
    var Imagemmano:FlxSprite;

    override function create()
    {
    // é só isso, consertei umas coisas
    Imagemmano = new FlxSprite();
    Imagemmano.loadGraphic(Paths.image('Unlocked/BFREANIMADO')); //Omega SUSUSUSUSUSUSUUSUSUSUSUS

    if (controls.BACK) 
        {
            FlxG.sound.play(Paths.sound('cancelMenu'));
            MusicBeatState.switchState(new MainMenuState());
        }
        
    }
}