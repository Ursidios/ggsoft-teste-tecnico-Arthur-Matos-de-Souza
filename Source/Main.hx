package;

import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;
import animation.CharacterAnimation;
import rig.CharacterRig;
import ui.UIManager;

class Main extends Sprite
{
    private var character:CharacterRig;
    private var animation:CharacterAnimation;
    private var uiManager:UIManager;

    private var timer:haxe.Timer;
    private var lastTime:Float = -1;

    public var useDebug:Bool = false;
    
    public function new()
    {
        super();

        createCharacter();
        createUI();

        timer = new haxe.Timer(16);
        timer.run = update;
    }

    function createCharacter():Void
    {
        character = new CharacterRig();

        character.x = 250;
        character.y = 100;
		character.setDebugVisible(useDebug);

        addChild(character);

        animation = new CharacterAnimation(character);
    }

    function update():Void
    {
        
        character.setDebugVisible(useDebug);
        var now = haxe.Timer.stamp();

        if (lastTime < 0)
            lastTime = now;

        var dt = now - lastTime;

        lastTime = now;

        if (dt > 0.1)
            dt = 0.1;

        animation.update(dt);
      
    }

    function createUI():Void
    {
        uiManager = new UIManager(character, animation, this);
        addChild(uiManager);
    }

    public function playWave():Void
    {
        animation.playWave();
    }

    public function playBlink():Void
    {
        animation.playBlink();
    }
}