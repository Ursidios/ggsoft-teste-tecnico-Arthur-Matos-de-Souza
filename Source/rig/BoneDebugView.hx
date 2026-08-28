package rig;

import openfl.display.Sprite;
import openfl.display.DisplayObject;
import openfl.geom.Point;

class BoneDebugView extends Sprite
{
    private var characterRoot:Bone;
    private var bones:Array<Bone>;
    private var target:Sprite;

    public function new(target:Sprite, characterRoot:Bone, bones:Array<Bone>)
    {
        super();

        this.target = target;
        this.characterRoot = characterRoot;
        this.bones = bones;
        mouseEnabled = false;
        mouseChildren = false;
    }

    public function refresh():Void
    {
        graphics.clear();

        for (bone in bones)
        {
            var parentDisplay:DisplayObject = bone.parent;
            var bonePoint = target.globalToLocal(bone.localToGlobal(new Point(0, 0)));

            graphics.lineStyle(bone == characterRoot ? 4 : 3,
                bone == characterRoot ? 0xFFCC00 : 0x00E5FF, 0.9);
            graphics.beginFill(bone == characterRoot ? 0xFFCC00 : 0xFFFFFF, 1);
            graphics.drawCircle(bonePoint.x, bonePoint.y, bone == characterRoot ? 7 : 5);
            graphics.endFill();

            if (parentDisplay != null && parentDisplay != characterRoot.parent)
            {
                var parentPoint = target.globalToLocal(
                    parentDisplay.localToGlobal(new Point(0, 0)));
                graphics.lineStyle(2, 0xFF4D6D, 0.85);
                graphics.moveTo(parentPoint.x, parentPoint.y);
                graphics.lineTo(bonePoint.x, bonePoint.y);
            }

            drawAxis(bone, bonePoint);
        }
    }

    private function drawAxis(bone:Bone, origin:Point):Void
    {
        var axisPoint = target.globalToLocal(bone.localToGlobal(new Point(28, 0)));
        graphics.lineStyle(5, 0x7CFF6B, 0.8);
        graphics.moveTo(origin.x, origin.y);
        graphics.lineTo(axisPoint.x, axisPoint.y);
    }
}
