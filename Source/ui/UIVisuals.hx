package ui;

import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.utils.Assets;

class UIVisuals extends Sprite
{
    public var uIManager:UIManager;

    public var buttonWave:Sprite;
    public var buttonBlink:Sprite;
    public var buttonReset:Sprite;
    public var buttonDebug:Sprite;

    public function new(uIManager:UIManager)
    {
        super();

        this.uIManager = uIManager;
        createButtons();
    } 

    private function createButtons():Void
    {
        var blackButtonPath = "assets/UI/Button.png";

        buttonWave = createButton(blackButtonPath, "Wave", 750, 100, uIManager.onWaveClick);

        buttonBlink = createButton(blackButtonPath, "Blink", 750, 300, uIManager.onBlinkClick);

        buttonReset = createButton(blackButtonPath, "Pause/Play", 750, 500, uIManager.onPausePlayClick);

        buttonDebug = createButton(blackButtonPath, "Debug View", 750, 700, uIManager.onDebugClick);
    }

    public function createButton(path:String, text:String, x:Float, y:Float, onClick:MouseEvent->Void):Sprite
    {
        var button = new Sprite();
        button.x = x;
        button.y = y;

        var bitmapData = Assets.getBitmapData(path);
        if (bitmapData != null)
        {
            var bitmap = new Bitmap(bitmapData);
            button.addChild(bitmap);
        }

        var label = new TextField();
        
        var format = new TextFormat(null, 25, 0xFFFFFF, true);
        format.align = TextFormatAlign.CENTER;
        
        label.defaultTextFormat = format;
        label.text = text;
        label.width = button.width > 0 ? button.width : 120;
        label.height = button.height > 0 ? button.height : 40;
        
        label.y = (label.height - label.textHeight) / 2 - 2;
        
        label.selectable = false;
        label.mouseEnabled = false;

        button.addChild(label);

        button.buttonMode = true;
        button.mouseChildren = false;
        button.addEventListener(MouseEvent.CLICK, onClick);

        addChild(button);

        return button;
    }
}