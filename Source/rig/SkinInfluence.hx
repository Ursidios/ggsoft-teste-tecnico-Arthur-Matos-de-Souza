package rig;

class SkinInfluence
{
    public var bone:Bone;
    public var weight:Float;
    public var bindX:Float;
    public var bindY:Float;

    public function new(bone:Bone, weight:Float, bindX:Float, bindY:Float)
    {
        this.bone = bone;
        this.weight = weight;
        this.bindX = bindX;
        this.bindY = bindY;
    }
}
