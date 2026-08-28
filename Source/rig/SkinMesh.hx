package rig;

import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.geom.Point;
import openfl.Vector;

class SkinMesh extends Sprite
{
    private var rootBone:Bone;
    private var texture:BitmapData;
    private var vertices:Vector<Float>;
    private var indices:Vector<Int>;
    private var uvtData:Vector<Float>;
    private var weights:Array<Array<SkinInfluence>>;

    public function new(rootBone:Bone, texture:BitmapData, drivenBone:Bone,
        offsetX:Float = 0, offsetY:Float = 0, columns:Int = 1,
        rows:Int = 1, blendBone:Bone = null, blendFromBottom:Bool = false,
        blendStart:Float = 0.35, blendEnd:Float = 0.65,
        maxBlendWeight:Float = 0.70)
    {
        super();

        this.rootBone = rootBone;
        this.texture = texture;
        this.vertices = new Vector<Float>();
        this.indices = new Vector<Int>();
        this.uvtData = new Vector<Float>();
        this.weights = [];

        buildGrid(drivenBone, offsetX, offsetY, columns, rows, blendBone,
            blendFromBottom, blendStart, blendEnd, maxBlendWeight);
        redraw();
    }

    private function buildGrid(drivenBone:Bone, offsetX:Float, offsetY:Float,
        columns:Int, rows:Int, blendBone:Bone, blendFromBottom:Bool,
        blendStart:Float, blendEnd:Float, maxBlendWeight:Float):Void
    {
        var width = texture.width;
        var height = texture.height;

        for (row in 0...rows + 1)
        {
            var v = row / rows;
            var localY = offsetY + height * v;

            for (column in 0...columns + 1)
            {
                var u = column / columns;
                var localX = offsetX + width * u;
                var restPoint = drivenBone.localToGlobal(new Point(localX, localY));
                var rootPoint = rootBone.globalToLocal(restPoint);

                vertices.push(rootPoint.x);
                vertices.push(rootPoint.y);
                uvtData.push(u);
                uvtData.push(v);

                var vertexWeights = new Array<SkinInfluence>();
                var blend = blendBone == null ? 0.0 : jointBlend(v,
                    blendFromBottom, blendStart, blendEnd, maxBlendWeight);

                if (blend > 0)
                {
                    var blendPoint = blendBone.globalToLocal(restPoint);
                    vertexWeights.push(new SkinInfluence(blendBone, blend,
                        blendPoint.x, blendPoint.y));
                    vertexWeights.push(new SkinInfluence(drivenBone, 1 - blend,
                        localX, localY));
                }
                else
                {
                    vertexWeights.push(new SkinInfluence(drivenBone, 1,
                        localX, localY));
                }

                weights.push(vertexWeights);
            }
        }

        for (row in 0...rows)
        {
            for (column in 0...columns)
            {
                var topLeft = row * (columns + 1) + column;
                var topRight = topLeft + 1;
                var bottomLeft = topLeft + columns + 1;
                var bottomRight = bottomLeft + 1;

                indices.push(topLeft);
                indices.push(topRight);
                indices.push(bottomRight);
                indices.push(topLeft);
                indices.push(bottomRight);
                indices.push(bottomLeft);
            }
        }
    }

    private function jointBlend(v:Float, blendFromBottom:Bool,
        blendStart:Float, blendEnd:Float, maxBlendWeight:Float):Float
    {
        var progress = (v - blendStart) / (blendEnd - blendStart);
        progress = Math.max(0, Math.min(progress, 1));

        if (!blendFromBottom)
            progress = 1 - progress;

        return maxBlendWeight * progress;
    }

    public function updateSkin():Void
    {
        for (vertexIndex in 0...weights.length)
        {
            var worldX = 0.0;
            var worldY = 0.0;

            for (influence in weights[vertexIndex])
            {
                var transformed = influence.bone.localToGlobal(
                    new Point(influence.bindX, influence.bindY));
                worldX += transformed.x * influence.weight;
                worldY += transformed.y * influence.weight;
            }

            var rootPoint = rootBone.globalToLocal(new Point(worldX, worldY));
            vertices[vertexIndex * 2] = rootPoint.x;
            vertices[vertexIndex * 2 + 1] = rootPoint.y;
        }

        redraw();
    }

    private function redraw():Void
    {
        graphics.clear();
        graphics.beginBitmapFill(texture);
        graphics.drawTriangles(vertices, indices, uvtData);
        graphics.endFill();
    }
}
