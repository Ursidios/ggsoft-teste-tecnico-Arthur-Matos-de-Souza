package animation;

import openfl.geom.Point;
import rig.CharacterRig;


class CharacterAnimation
{
    public var rig:CharacterRig;

    public var playing:Bool = true;

    public var idleEnabled:Bool = true;

    public var wavePlaying:Bool = false;


    public var blinkPlaying:Bool = false;

    private var elapsed:Float = 0;

    private var waveTime:Float = 0;

    private var blinkTime:Float = 0;

    public function new(rig:CharacterRig)
    {
        this.rig = rig;
    }

    public function update(dt:Float):Void
    {
        if (!playing)
            return;

        elapsed += dt;

        updateIdle(dt);
        updateWave(dt);
        updateBlink(dt);
        lookAtMouse();
        rig.updateSkin();

        if (!blinkPlaying)
        {
            var blinkCycle = elapsed % 3.5;

            if (blinkCycle > 3.25)
            {
                blinkPlaying = true;
                blinkTime = 0;
            }
        }
    }


    function updateIdle(dt:Float):Void
    {
        if (!idleEnabled)
            return;

        var cycle = elapsed % 2.0;

        var breathing = Math.sin(
            cycle / 2.0 * Math.PI * 2
        );

        rig.body.setAnimationPosition(0, breathing * 3);

        rig.head.rotation = breathing * 1.5;

        rig.leftArm.rotation = -breathing * 2;
        rig.leftForearm.rotation = breathing * 1.5;
        rig.rightArm.rotation = breathing * 2;
        rig.rightForearm.rotation = -breathing * 1.5;

        rig.leftLeg.rotation = breathing * 0.5;
        rig.leftShin.rotation = -breathing * 0.35;
        rig.rightLeg.rotation = -breathing * 0.5;
        rig.rightShin.rotation = breathing * 0.35;
    }


    function updateWave(dt:Float):Void
    {
        if (!wavePlaying)
            return;

        waveTime += dt;

        var waveRaisePercent:Float = 25;
        var waveHoldPercent:Float = 50;
        var waveReturnPercent:Float = 25;

        var duration = 2.0;
        var totalPercent = waveRaisePercent + waveHoldPercent
            + waveReturnPercent;

        var raiseDuration = duration * waveRaisePercent / 100;
        var holdDuration = duration * waveHoldPercent / 100;
        var returnStart = raiseDuration + holdDuration;

        if (waveTime >= duration)
        {
            wavePlaying = false;
            waveTime = 0;
            rig.rightArm.rotation = 0;
            rig.rightForearm.rotation = 0;
            return;
        }

        if (waveTime < raiseDuration)
        {
            var t = waveTime / raiseDuration;

            t = smoothStep(t);

            rig.rightArm.rotation = -120 * t;
            rig.rightForearm.rotation = -50 * t;
        }
        else if (waveTime < returnStart)
        {
            var wave = Math.sin(
                (waveTime - raiseDuration) / holdDuration * Math.PI * 4
            );

            rig.rightArm.rotation = -120 + wave * 15;
            rig.rightForearm.rotation = -50 + wave * 35;
        }
        else
        {
            var returnDuration = duration - returnStart;
            var t = (waveTime - returnStart) / returnDuration;
            t = smoothStep(t);

            rig.rightArm.rotation = -120 * (1 - t);
            rig.rightForearm.rotation = -50 * (1 - t);
        }
    }



    function updateBlink(dt:Float):Void
    {
        if (!blinkPlaying)
            return;

        blinkTime += dt;

        if (blinkTime < 0.08)
        {
            var t = blinkTime / 0.08;

            rig.leftEye.scaleY = 1 - t;
            rig.rightEye.scaleY = 1 - t;
        }
        else if (blinkTime < 0.16)
        {
            var t = (blinkTime - 0.08) / 0.08;

            rig.leftEye.scaleY = t;
            rig.rightEye.scaleY = t;
        }
        else
        {
            rig.leftEye.scaleY = 1;
            rig.rightEye.scaleY = 1;

            blinkPlaying = false;
            blinkTime = 0;
        }
    }

    public function lookAtMouse(maxDistance:Float = 10.0):Void
    {
        if (rig.stage == null) return;

        var headGlobalPos = rig.head.localToGlobal(new Point(0, 0));

        var angle = Math.atan2(rig.stage.mouseY - headGlobalPos.y, rig.stage.mouseX - headGlobalPos.x);

        rig.leftEye.x = rig.LEyeX + Math.cos(angle) * maxDistance;
        rig.leftEye.y = rig.LEyeY + Math.sin(angle) * maxDistance;

        rig.rightEye.x = rig.REyeX + Math.cos(angle) * maxDistance;
        rig.rightEye.y = rig.REyeY + Math.sin(angle) * maxDistance;
    }

    public function playWave():Void
    {
        wavePlaying = true;
        waveTime = 0;
    }

    public function playBlink():Void
    {
        blinkPlaying = true;
        blinkTime = 0;
    }

    public function pause():Void
    {
        playing = false;
    }

    public function resume():Void
    {
        playing = true;
    }

    function smoothStep(t:Float):Float
    {
        return t * t * (3 - 2 * t);
    }
}