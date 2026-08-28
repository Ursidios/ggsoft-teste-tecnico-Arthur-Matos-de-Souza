package rig;

import openfl.display.Sprite;

class Bone extends Sprite 
{
	public var restX:Float = 0;
	public var restY:Float = 0;
	public var restRotation:Float = 0;

	public var animationX:Float = 0;
	public var animationY:Float = 0;
	public var animationRotation:Float = 0;

	public function new() 
    {
		super();

		mouseEnabled = false;
		mouseChildren = false;
	}

	public function setRestPose(x:Float, y:Float, rotation:Float = 0):Void 
    {
		restX = x;
		restY = y;
		restRotation = rotation;

		applyTransform();
	}

	public function applyTransform():Void 
    {
		x = restX + animationX;
		y = restY + animationY;

		rotation = restRotation + animationRotation;
	}

	public function resetAnimation():Void 
    {
		animationX = 0;
		animationY = 0;
		animationRotation = 0;

		applyTransform();
	}

	public function setAnimationPosition(x:Float, y:Float):Void 
    {
		animationX = x;
		animationY = y;

		applyTransform();
	}

	public function setAnimationRotation(value:Float):Void 
    {
		animationRotation = value;

		applyTransform();
	}
}
