float c = 1;

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

PShape createCube(PImage[] textures, PVector[] colors) {
  /*
  textures[0] = front
  textures[1] = back
  textures[2] = right
  textures[3] = left
  textures[4] = bottom
  textures[5] = top
  */
  PShape cube = createShape(GROUP);
  cube.addChild( createCubeFace(textures[0], colors[0], cubeVertices[0], cubeVertices[1], cubeVertices[3], cubeVertices[2]) );
  cube.addChild( createCubeFace(textures[1], colors[1], cubeVertices[5], cubeVertices[4], cubeVertices[6], cubeVertices[7]) );
  cube.addChild( createCubeFace(textures[2], colors[2], cubeVertices[1], cubeVertices[5], cubeVertices[7], cubeVertices[3]) );
  cube.addChild( createCubeFace(textures[3], colors[3], cubeVertices[4], cubeVertices[0], cubeVertices[2], cubeVertices[6]) );
  cube.addChild( createCubeFace(textures[4], colors[4], cubeVertices[2], cubeVertices[3], cubeVertices[7], cubeVertices[6]) );
  cube.addChild( createCubeFace(textures[5], colors[5], cubeVertices[4], cubeVertices[5], cubeVertices[1], cubeVertices[0]) );

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

PShape createCubeFace(PImage tex, PVector colors, PVector v0, PVector v1, PVector v2, PVector v3) {
  PShape face = createCubeInitFace();
  face.beginShape(QUAD);
  face.texture(tex);
  face.tint(colors.x, colors.y, colors.z);
  face.vertex(v0.x, v0.y, v0.z, 0, 0);
  face.vertex(v1.x, v1.y, v1.z, 1, 0);
  face.vertex(v2.x, v2.y, v2.z, 1, 1);
  face.vertex(v3.x, v3.y, v3.z, 0, 1);
  face.endShape(CLOSE);

  return face;
}

