float c = 1;

PVector[] cubeVertices = {
  new PVector(-c, c, c), // 0
  new PVector( c, c, c), // 1
  new PVector( c, -c, c), // 2
  new PVector(-c, -c, c), // 3
  new PVector( c, c, -c), // 4
  new PVector(-c, c, -c), // 5
  new PVector(-c, -c, -c), // 6
  new PVector( c, -c, -c)  // 7
};

PShape createCube() {
  PShape cube = createShape(GROUP);
  cube.addChild( createCubeFrontFace(bottom, 255, 0, 0) );
  cube.addChild( createCubeBackFace(bottom, 0, 100, 0) );
  cube.addChild( createCubeRightFace(bottom, 0, 0, 255) );
  cube.addChild( createCubeLeftFace(bottom, 255, 255, 0) );
  cube.addChild( createCubeBottomFace(bottom, 255, 0, 255) );
  cube.addChild( createCubeTopFace(bottom, 0, 255, 255) );

  return cube;
}

PShape createCubeInitFace() {
  PShape face = createShape();
  face.beginShape(QUAD);
  face.textureMode(NORMAL);
  face.shininess(200.0);
  face.emissive(0, 0, 0);
  face.endShape();

  return face;
}

PShape createCubeFace(PImage tex, int tr, int tg, int tb, PVector v0, PVector v1, PVector v2, PVector v3) {
  PShape face = createCubeInitFace();
  face.beginShape(QUAD);
  face.texture(tex);
  face.tint(tr, tg, tb);
  face.vertex(v0.x, v0.y, v0.z, 0, 1);
  face.vertex(v1.x, v1.y, v1.z, 1, 1);
  face.vertex(v2.x, v2.y, v2.z, 1, 0);
  face.vertex(v3.x, v3.y, v3.z, 0, 0);
  face.endShape(CLOSE);

  return face;
}

PShape createCubeFrontFace(PImage tex, int tr, int tg, int tb) {
  return createCubeFace(tex, tr, tg, tb,
    cubeVertices[0],
    cubeVertices[1],
    cubeVertices[2],
    cubeVertices[3]
    );
}

PShape createCubeBackFace(PImage tex, int tr, int tg, int tb) {
  return createCubeFace(tex, tr, tg, tb,
    cubeVertices[4],
    cubeVertices[5],
    cubeVertices[6],
    cubeVertices[7]
    );
}

PShape createCubeRightFace(PImage tex, int tr, int tg, int tb) {
  return createCubeFace(tex, tr, tg, tb,
    cubeVertices[1],
    cubeVertices[4],
    cubeVertices[7],
    cubeVertices[2]
    );
}

PShape createCubeLeftFace(PImage tex, int tr, int tg, int tb) {
  return createCubeFace(tex, tr, tg, tb,
    cubeVertices[5],
    cubeVertices[0],
    cubeVertices[3],
    cubeVertices[6]
    );
}

PShape createCubeBottomFace(PImage tex, int tr, int tg, int tb) {
  return createCubeFace(tex, tr, tg, tb,
    cubeVertices[0],
    cubeVertices[1],
    cubeVertices[4],
    cubeVertices[5]
    );
}

PShape createCubeTopFace(PImage tex, int tr, int tg, int tb) {
  return createCubeFace(tex, tr, tg, tb,
    cubeVertices[6],
    cubeVertices[7],
    cubeVertices[4],
    cubeVertices[5]
    );
}

