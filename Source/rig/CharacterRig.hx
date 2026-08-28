package rig;

import openfl.display.Sprite;
import openfl.utils.Assets;

class CharacterRig extends Sprite 
{
	public var characterScale:Float = 1.0;


	public var characterRoot:Bone;

	public var body:Bone;
	public var head:Bone;

	public var leftArm:Bone;
	public var leftForearm:Bone;
	public var rightArm:Bone;
	public var rightForearm:Bone;

	public var leftLeg:Bone;
	public var leftShin:Bone;
	public var rightLeg:Bone;
	public var rightShin:Bone;

	public var leftEye:Bone;
	public var rightEye:Bone;
	private var skinMeshes:Array<SkinMesh> = [];
	private var debugView:BoneDebugView;
	public var debugVisible:Bool = false;



    public var characterRootX:Float = -100;
    public var characterRootY:Float = 0;

	public var bodyX:Float = 245;
	public var bodyY:Float = 378;

	public var headX:Float = 245;
	public var headY:Float = 265;

	public var leftArmX:Float = 97;
	public var leftArmY:Float = 275;

	public var rightArmX:Float = 397;
	public var rightArmY:Float = 275;

	public var leftLegX:Float = 206.5;
	public var leftLegY:Float = 515;

	public var rightLegX:Float = 293.5;
	public var rightLegY:Float = 515;

	public var LEyeX:Float = -35;
	public var LEyeY:Float = -120;

	public var REyeX:Float = 35;
	public var REyeY:Float = -120;



	public function new() 
    {
		super();

		createBones();
		createCharacter();
	}



	function createBones():Void 
    {
		characterRoot = new Bone();
		addChild(characterRoot);

		body = new Bone();
		characterRoot.addChild(body);

		leftArm = new Bone();
		body.addChild(leftArm);
		leftForearm = new Bone();
		leftArm.addChild(leftForearm);

		rightArm = new Bone();
		body.addChild(rightArm);
		rightForearm = new Bone();
		rightArm.addChild(rightForearm);

		leftLeg = new Bone();
		body.addChild(leftLeg);
		leftShin = new Bone();
		leftLeg.addChild(leftShin);

		rightLeg = new Bone();
		body.addChild(rightLeg);
		rightShin = new Bone();
		rightLeg.addChild(rightShin);

		head = new Bone();
		body.addChild(head);

		leftEye = new Bone();
		head.addChild(leftEye);

		rightEye = new Bone();
		head.addChild(rightEye);

		body.setChildIndex(head, body.numChildren - 1);
	}



	function createCharacter():Void 
    {
		positionBones();

		addSkinPart("assets/character/Body.png", body, 3, 3, null, 0.5, 0.5);
		addSkinPart("assets/character/LArm.png", leftArm, 4, 10, leftForearm, 0.5, 0, true, 0.35, 0.55, 0.85);
		addSkinPart("assets/character/RArm.png", rightArm, 10, 10, rightForearm, 0.5, 0, true, 0.35, 0.55, 1);
		addSkinPart("assets/character/LLeg.png", leftLeg, 3, 10, leftShin, 0.5, 0, true, 0.35, 0.55, 1);
		addSkinPart("assets/character/RLeg.png", rightLeg, 3, 10, rightShin, 0.5, 0, true, 0.35, 0.55, 1);
		addSkinPart("assets/character/Head.png", head, 4, 4, body, 0.5, 1, true);
		addSkinPart("assets/character/LEye.png", leftEye, 1, 1, head, 0.5, 0.5, true, 0.5, 0.5, 0.2);
		addSkinPart("assets/character/REye.png", rightEye, 1, 1, head, 0.5, 0.5, true, 0.5, 0.5, 0.2);

		debugView = new BoneDebugView(this, characterRoot, [
			characterRoot, body, head, leftArm, leftForearm, rightArm,
			rightForearm, leftLeg, leftShin, rightLeg, rightShin,
			leftEye, rightEye
		]);
		addChild(debugView);
		debugView.visible = debugVisible;
		debugView.refresh();
	}



	function positionBones():Void 
    {
        characterRoot.setRestPose(characterRootX, characterRootY);

		body.setRestPose(bodyX, bodyY);

		head.setRestPose(headX - bodyX, headY - bodyY);

		leftArm.setRestPose(leftArmX - bodyX, leftArmY - bodyY);
		leftForearm.setRestPose(0, 91);

		rightArm.setRestPose(rightArmX - bodyX, rightArmY - bodyY);
		rightForearm.setRestPose(0, 91);

		leftLeg.setRestPose(leftLegX - bodyX, leftLegY - bodyY);
		leftShin.setRestPose(0, 81);

		rightLeg.setRestPose(rightLegX - bodyX, rightLegY - bodyY);
		rightShin.setRestPose(0, 81);

		leftEye.setRestPose(LEyeX, LEyeY);

		rightEye.setRestPose(REyeX, REyeY);
	}



	function addSkinPart(path:String, bone:Bone, columns:Int, rows:Int,
		blendBone:Bone = null, pivotX:Float = 0, pivotY:Float = 0,
		blendFromBottom:Bool = false, blendStart:Float = 0.35,
		blendEnd:Float = 0.65, maxBlendWeight:Float = 0.70):Void
    {
		var bitmapData = Assets.getBitmapData(path);

		if (bitmapData == null) {
			trace("ERRO: não encontrei " + path);
			return;
		}

		var offsetX = -bitmapData.width * pivotX;

		var offsetY = -bitmapData.height * pivotY;

		var mesh = new SkinMesh(characterRoot, bitmapData, bone,
			offsetX, offsetY, columns, rows, blendBone, blendFromBottom,
			blendStart, blendEnd, maxBlendWeight);

		characterRoot.addChild(mesh);
		skinMeshes.push(mesh);
	}

	public function updateSkin():Void
	{
		for (mesh in skinMeshes)
			mesh.updateSkin();

		if (debugVisible)
			debugView.refresh();
	}

	public function setDebugVisible(value:Bool):Void
	{
		debugVisible = value;
		debugView.visible = value;

		if (value)
			debugView.refresh();
	}



	public function resetPose():Void 
    {
		body.resetAnimation();

		head.resetAnimation();

		leftArm.resetAnimation();
		leftForearm.resetAnimation();
		rightArm.resetAnimation();
		rightForearm.resetAnimation();

		leftLeg.resetAnimation();
		leftShin.resetAnimation();
		rightLeg.resetAnimation();
		rightShin.resetAnimation();

		leftEye.resetAnimation();
		rightEye.resetAnimation();

		leftEye.scaleY = 1;
		rightEye.scaleY = 1;
		updateSkin();
	}
}
