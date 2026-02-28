final int PIED_CHAISE_W = 4 / 2;
final int PIED_CHAISE_H = 42 / 2;
final int PIED_CHAISE_D = 4 / 2;

final int FRAME_THICKNESS = 1;

final int ASSISE_CHAISE_W = 40 / 2;
final int ASSISE_CHAISE_H = 4 / 2;
final int ASSISE_CHAISE_D = 45 / 2;

final int DOSSIER_CHAISE_W = 40 / 2;
final int DOSSIER_CHAISE_H = 50 / 2;
final int DOSSIER_CHAISE_D = 4 / 2;

final PVector YELLOW_METAL = new PVector(255, 186, 10);

PShape chaise;
PImage woodChaise;
PImage[] woodChaiseTextures;
PImage[] metalTextures;

PShape createChaise() {
  PShape chaise = createShape(GROUP);

  PShape assise = createAssiseChaise();
  PShape dossier = createDossierChaise();
  PShape piedFrontLeft = createPiedChaise();
  PShape piedFrontRight = createPiedChaise();
  PShape piedBackLeft = createPiedChaise();
  PShape piedBackRight = createPiedChaise();
  PShape frameAssise = createFrameAssise();
  PShape frameDossier = createFrameDossier();

  assise.translate(0, - ASSISE_CHAISE_H, 0);
  dossier.translate(0, - (ASSISE_CHAISE_H * 2 + DOSSIER_CHAISE_H), (ASSISE_CHAISE_D - DOSSIER_CHAISE_D));
  frameAssise.translate(0, - ASSISE_CHAISE_H, 0);
  frameDossier.translate(0, - (ASSISE_CHAISE_H * 2 + DOSSIER_CHAISE_H), (ASSISE_CHAISE_D - DOSSIER_CHAISE_D));
  piedFrontLeft.translate(- (ASSISE_CHAISE_W - PIED_CHAISE_D), PIED_CHAISE_H, (ASSISE_CHAISE_D - PIED_CHAISE_D));
  piedFrontRight.translate((ASSISE_CHAISE_W - PIED_CHAISE_D), PIED_CHAISE_H, (ASSISE_CHAISE_D - PIED_CHAISE_D));
  piedBackLeft.translate(- (ASSISE_CHAISE_W - PIED_CHAISE_D), PIED_CHAISE_H, - (ASSISE_CHAISE_D - PIED_CHAISE_D));
  piedBackRight.translate((ASSISE_CHAISE_W - PIED_CHAISE_D), PIED_CHAISE_H, - (ASSISE_CHAISE_D - PIED_CHAISE_D));

  chaise.addChild(assise);
  chaise.addChild(frameAssise);
  chaise.addChild(dossier);
  chaise.addChild(frameDossier);
  chaise.addChild(piedFrontLeft);
  chaise.addChild(piedFrontRight);
  chaise.addChild(piedBackLeft);
  chaise.addChild(piedBackRight);

  // descend le centre de la chaise au niveau du sol
  chaise.translate(-5, -PIED_CHAISE_H * 2, PLANCHE_D);

  return chaise;
}

PShape createAssiseChaise() {
  PShape assiseChaise = new CubeMagique(woodChaiseTextures, defaultColors).build(ASSISE_CHAISE_W, ASSISE_CHAISE_H, ASSISE_CHAISE_D);
  return assiseChaise;
}

PShape createDossierChaise() {
  PShape dossierChaise = new CubeMagique(woodChaiseTextures, defaultColors).invertUVs().build(DOSSIER_CHAISE_W, DOSSIER_CHAISE_H, DOSSIER_CHAISE_D);
  return dossierChaise;
}

PShape createPiedChaise() {
  PImage[] textures = new PImage[] {
    metal,
    metal,
    metal,
    metal,
    metal,
    metal
  };

  PVector[] colors = new PVector[] {
    new PVector(255, 186, 10),
    new PVector(255, 186, 10),
    new PVector(255, 186, 10),
    new PVector(255, 186, 10),
    new PVector(255, 186, 10),
    new PVector(255, 186, 10),
  };

  PShape piedChaise = new CubeMagique(textures, colors).withSpecular(255.0, 255.0, 255.0).build(PIED_CHAISE_W, PIED_CHAISE_H, PIED_CHAISE_D);

  return piedChaise;
}

void loadChaiseImages() {
  woodChaise = loadImage("asset/woodChair.jpg");
  woodChaiseTextures = new PImage[] {
    woodChaise, woodChaise, woodChaise, woodChaise, woodChaise, woodChaise
  };
  metalTextures = new PImage[] {
    metal, metal, metal, metal, metal, metal
  };
}

PShape createFrameAssise() {
  PShape frame = createShape(GROUP);

  PVector[] colors = new PVector[] {
    YELLOW_METAL, YELLOW_METAL, YELLOW_METAL, YELLOW_METAL, YELLOW_METAL, YELLOW_METAL
  };

  // Cadre gauche
  PShape frameLeft = new CubeMagique(metalTextures, colors)
    .withSpecular(255.0, 255.0, 255.0)
    .build(FRAME_THICKNESS, ASSISE_CHAISE_H, ASSISE_CHAISE_D);
  frameLeft.translate(-(ASSISE_CHAISE_W + FRAME_THICKNESS), 0, 0);
  frame.addChild(frameLeft);

  // Cadre droit
  PShape frameRight = new CubeMagique(metalTextures, colors)
    .withSpecular(255.0, 255.0, 255.0)
    .build(FRAME_THICKNESS, ASSISE_CHAISE_H, ASSISE_CHAISE_D);
  frameRight.translate((ASSISE_CHAISE_W + FRAME_THICKNESS), 0, 0);
  frame.addChild(frameRight);

  return frame;
}

PShape createFrameDossier() {
  PShape frame = createShape(GROUP);

  PVector[] colors = new PVector[] {
    YELLOW_METAL, YELLOW_METAL, YELLOW_METAL, YELLOW_METAL, YELLOW_METAL, YELLOW_METAL
  };

  // Barres latérales gauche et droite du dossier
  PShape frameLeftDossier = new CubeMagique(metalTextures, colors)
    .withSpecular(255.0, 255.0, 255.0)
    .build(FRAME_THICKNESS, DOSSIER_CHAISE_H, DOSSIER_CHAISE_D);
  frameLeftDossier.translate(-(DOSSIER_CHAISE_W + FRAME_THICKNESS), 0, 0);
  frame.addChild(frameLeftDossier);

  PShape frameRightDossier = new CubeMagique(metalTextures, colors)
    .withSpecular(255.0, 255.0, 255.0)
    .build(FRAME_THICKNESS, DOSSIER_CHAISE_H, DOSSIER_CHAISE_D);
  frameRightDossier.translate((DOSSIER_CHAISE_W + FRAME_THICKNESS), 0, 0);
  frame.addChild(frameRightDossier);

  // Barre supérieure du dossier
  PShape frameTopDossier = new CubeMagique(metalTextures, colors)
    .withSpecular(255.0, 255.0, 255.0)
    .build(DOSSIER_CHAISE_W, FRAME_THICKNESS, DOSSIER_CHAISE_D);
  frameTopDossier.translate(0, -(DOSSIER_CHAISE_H + FRAME_THICKNESS), 0);
  frame.addChild(frameTopDossier);

  return frame;
}
