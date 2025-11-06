float c = 1; // 1 cm

/*
    4--------5
  / |      / |
 /  |     /  |
0--------1   |
|   |    |   |
|   6----|--7
| /      | /
|/       |/
2--------3
*/

// Cube vertex indices
final int FRONT_TL = 0;
final int FRONT_TR = 1;
final int FRONT_BL = 2;
final int FRONT_BR = 3;
final int BACK_TL = 4;
final int BACK_TR = 5;
final int BACK_BL = 6;
final int BACK_BR = 7;

// Cube face indices
final int FRONT = 0;
final int BACK = 1;
final int RIGHT = 2;
final int LEFT = 3;
final int BOTTOM = 4;
final int TOP = 5;

// UV coordinates, normal and inverted
PVector[] cubeUVs = {
  new PVector(0, 0),
  new PVector(1, 0),
  new PVector(1, 1),
  new PVector(0, 1)
};

PVector[] cubeUVsInverted = {
  new PVector(1, 0),
  new PVector(0, 0),
  new PVector(0, 1),
  new PVector(1, 1)
};

PVector[] cubeVertices = {
  new PVector(-c, -c,  c), // 0
  new PVector( c, -c,  c), // 1
  new PVector(-c,  c,  c), // 2
  new PVector( c,  c,  c), // 3
  new PVector(-c, -c, -c), // 4
  new PVector( c, -c, -c), // 5
  new PVector(-c,  c, -c), // 6
  new PVector( c,  c, -c)  // 7
};

PShape createCube(PImage[] textures, PVector[] colors, boolean invertUVs) {
  PVector[] uvs = invertUVs ? cubeUVsInverted : cubeUVs;

  PShape cube = createShape(GROUP);
  cube.addChild( createCubeFace(textures[FRONT], colors[FRONT], cubeVertices[FRONT_TL], cubeVertices[FRONT_TR], cubeVertices[FRONT_BR], cubeVertices[FRONT_BL], uvs) );
  cube.addChild( createCubeFace(textures[BACK], colors[BACK], cubeVertices[BACK_TR], cubeVertices[BACK_TL], cubeVertices[BACK_BL], cubeVertices[BACK_BR], uvs) );
  cube.addChild( createCubeFace(textures[RIGHT], colors[RIGHT], cubeVertices[FRONT_TR], cubeVertices[BACK_TR], cubeVertices[BACK_BR], cubeVertices[FRONT_BR], uvs) );
  cube.addChild( createCubeFace(textures[LEFT], colors[LEFT], cubeVertices[BACK_TL], cubeVertices[FRONT_TL], cubeVertices[FRONT_BL], cubeVertices[BACK_BL], uvs) );
  cube.addChild( createCubeFace(textures[BOTTOM], colors[BOTTOM], cubeVertices[FRONT_BL], cubeVertices[FRONT_BR], cubeVertices[BACK_BR], cubeVertices[BACK_BL], uvs) );
  cube.addChild( createCubeFace(textures[TOP], colors[TOP], cubeVertices[BACK_TL], cubeVertices[BACK_TR], cubeVertices[FRONT_TR], cubeVertices[FRONT_TL], uvs) );

  return cube;
}


PShape createCube(PImage[] textures, PVector[] colors) {
  return createCube(textures, colors, false);
}

PShape createCubeFace(PImage tex, PVector colors, PVector v0, PVector v1, PVector v2, PVector v3, PVector[] uvs) {
  PShape face = createShape();
  face.beginShape(QUAD);
  face.textureMode(NORMAL);
  face.shininess(200.0);
  face.emissive(0, 0, 0);
  face.texture(tex);
  face.tint(colors.x, colors.y, colors.z);
  face.vertex(v0.x, v0.y, v0.z, uvs[0].x, uvs[0].y);
  face.vertex(v1.x, v1.y, v1.z, uvs[1].x, uvs[1].y);
  face.vertex(v2.x, v2.y, v2.z, uvs[2].x, uvs[2].y);
  face.vertex(v3.x, v3.y, v3.z, uvs[3].x, uvs[3].y);
  face.endShape(CLOSE);

  return face;
}
