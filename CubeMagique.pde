float c = 1; // 1 cm

/*
 *     4--------5
 *   / |      / |
 *  /  |     /  |
 * 0--------1   |
 * |   |    |   |
 * |   6----|--7
 * | /      | /
 * |/       |/
 * 2--------3
 */

// CubeMagique vertex indices
final int FRONT_TL = 0;
final int FRONT_TR = 1;
final int FRONT_BL = 2;
final int FRONT_BR = 3;
final int BACK_TL = 4;
final int BACK_TR = 5;
final int BACK_BL = 6;
final int BACK_BR = 7;

// CubeMagique face indices
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
  new PVector(-c, -c, c), // 0
  new PVector( c, -c, c), // 1
  new PVector(-c, c, c), // 2
  new PVector( c, c, c), // 3
  new PVector(-c, -c, -c), // 4
  new PVector( c, -c, -c), // 5
  new PVector(-c, c, -c), // 6
  new PVector( c, c, -c)  // 7
};

public class CubeMagique {
  private PImage[] textures;
  private PVector[] colors;

  private boolean invertUVs = false;
  private float uvMultiplier = 1;
  private boolean invertNormals = false;
  private float shininessValue = 200.0;
  private PVector specular = new PVector(0, 0, 0);
  private PVector emissiveColor = new PVector(0, 0, 0);

  public CubeMagique(PImage[] textures, PVector[] colors) {
    this.textures = textures;
    this.colors = colors;
  }

  public CubeMagique withUVTiling(float multiplier) {
    this.uvMultiplier = multiplier;
    return this;
  }

  public CubeMagique invertUVs() {
    this.invertUVs = !this.invertUVs;
    return this;
  }

  public CubeMagique invertNormals() {
    this.invertNormals = !this.invertNormals;
    return this;
  }

  public CubeMagique withShininess(float s) {
    this.shininessValue = s;
    return this;
  }

  public CubeMagique withSpecular(PVector c) {
    this.specular = c;
    return this;
  }

  public CubeMagique withSpecular(float r, float g, float b) {
    this.specular = new PVector(r, g, b);
    return this;
  }

  public CubeMagique withSpecular(float v) {
    this.specular = new PVector(v, v, v);
    return this;
  }

  public CubeMagique withEmissive(PVector c) {
    this.emissiveColor = c;
    return this;
  }

  public CubeMagique withEmissive(float r, float g, float b) {
    this.emissiveColor = new PVector(r, g, b);
    return this;
  }

  public CubeMagique withEmissive(float v) {
    this.emissiveColor = new PVector(v, v, v);
    return this;
  }

  public PShape build(float widthShape, float heightShape, float depthShape, float totalSizeWidth, float totalSizeHeight, float totalSizeDepth) {
    PShape cube = createShape(GROUP);

    cube.addChild(this.createCubeMagiqueFace(textures[FRONT], colors[FRONT], cubeVertices[FRONT_TL], cubeVertices[FRONT_TR], cubeVertices[FRONT_BR], cubeVertices[FRONT_BL], widthShape, heightShape, totalSizeWidth, totalSizeHeight));
    cube.addChild(this.createCubeMagiqueFace(textures[BACK], colors[BACK], cubeVertices[BACK_TR], cubeVertices[BACK_TL], cubeVertices[BACK_BL], cubeVertices[BACK_BR], widthShape, heightShape, totalSizeWidth, totalSizeHeight));
    cube.addChild(this.createCubeMagiqueFace(textures[RIGHT], colors[RIGHT], cubeVertices[FRONT_TR], cubeVertices[BACK_TR], cubeVertices[BACK_BR], cubeVertices[FRONT_BR], depthShape, heightShape, totalSizeDepth, totalSizeHeight));
    cube.addChild(this.createCubeMagiqueFace(textures[LEFT], colors[LEFT], cubeVertices[BACK_TL], cubeVertices[FRONT_TL], cubeVertices[FRONT_BL], cubeVertices[BACK_BL], depthShape, heightShape, totalSizeDepth, totalSizeHeight));
    cube.addChild(this.createCubeMagiqueFace(textures[BOTTOM], colors[BOTTOM], cubeVertices[FRONT_BL], cubeVertices[FRONT_BR], cubeVertices[BACK_BR], cubeVertices[BACK_BL], widthShape, depthShape, totalSizeWidth, totalSizeDepth));
    cube.addChild(this.createCubeMagiqueFace(textures[TOP], colors[TOP], cubeVertices[BACK_TL], cubeVertices[BACK_TR], cubeVertices[FRONT_TR], cubeVertices[FRONT_TL], widthShape, depthShape, totalSizeWidth, totalSizeDepth));

    cube.scale(widthShape, heightShape, depthShape);

    return cube;
  }

  public PShape build(float widthShape, float heightShape, float depthShape) {
    return this.build(widthShape, heightShape, depthShape, widthShape, heightShape, depthShape);
  }

  private PShape createCubeMagiqueFace(PImage tex, PVector colors, PVector v0, PVector v1, PVector v2, PVector v3, float widthShape, float heightShape, float totalSizeWidth, float totalSizeHeight) {
    PShape face = createShape();
    face.beginShape(QUAD);
    face.textureMode(NORMAL);
    face.texture(tex);

    // 1. Calcul de la répétition basée sur la taille de l'image (Densité)
    float uMax = (widthShape / totalSizeWidth) * uvMultiplier;
    float vMax = (heightShape / totalSizeHeight) * uvMultiplier;

    // 2. Gestion de l'inversion
    // Si invertUVs est vrai, on commence à uMax/vMax et on va vers 0
    float uStart = invertUVs ? uMax : 0;
    float uEnd   = invertUVs ? 0    : uMax;
    float vStart = 0; // Tu peux aussi ajouter une logique d'inversion verticale ici
    float vEnd   = vMax;

    face.shininess(this.shininessValue);
    face.emissive(this.emissiveColor.x, this.emissiveColor.y, this.emissiveColor.z);
    face.specular(this.specular.x, this.specular.y, this.specular.z);
    face.tint(colors.x, colors.y, colors.z);

    // Calculate normal
    PVector edge1 = PVector.sub(v1, v0);
    PVector edge2 = PVector.sub(v3, v0);
    PVector normal = edge1.cross(edge2);
    normal.normalize();
    if (invertNormals) {
      normal.mult(-1);
    }

    face.normal(normal.x, normal.y, normal.z);
    face.vertex(v0.x, v0.y, v0.z, uStart, vStart);
    face.normal(normal.x, normal.y, normal.z);
    face.vertex(v1.x, v1.y, v1.z, uEnd, vStart);
    face.normal(normal.x, normal.y, normal.z);
    face.vertex(v2.x, v2.y, v2.z, uEnd, vEnd);
    face.normal(normal.x, normal.y, normal.z);
    face.vertex(v3.x, v3.y, v3.z, uStart, vEnd);
    face.endShape(CLOSE);

    return face;
  }
}
