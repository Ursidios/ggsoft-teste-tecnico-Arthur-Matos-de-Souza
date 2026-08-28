package ui;

import animation.CharacterAnimation;
import rig.CharacterRig;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFormat;

class UIManager extends Sprite
{
    private var character:CharacterRig;
    private var animation:CharacterAnimation;
    private var main:Main;
    public function new(character:CharacterRig, animation:CharacterAnimation, main:Main)
    {
        super();
        this.character = character;
        this.animation = animation;
        this.main = main;
        createUI();
    }

    public function createUI():Void
    {
        var uiVisuals = new UIVisuals(this);
        addChild(uiVisuals);
    }

    public function onWaveClick(event:MouseEvent):Void
    {
        if (animation != null && !animation.wavePlaying)
            animation.playWave();
    }

    public function onBlinkClick(event:MouseEvent):Void
    {
        if (animation != null)
            animation.playBlink();
    }

    public function onPausePlayClick(event:MouseEvent):Void
    {
        if (animation != null && animation != null)
            animation.playing= !animation.playing;
    }

    public function onDebugClick(event:MouseEvent):Void
    {
        main.useDebug = !main.useDebug;
    }
}