final int PIED_CHAISE_W = 2 / 2;
final int PIED_CHAISE_H = 42 / 2;
final int PIED_CHAISE_D = 2 / 2;

final int ASSISE_CHAISE_W = 40 / 2;
final int ASSISE_CHAISE_H = 4 / 2;
final int ASSISE_CHAISE_D = 45 / 2;

final int DOSSIER_CHAISE_W = 40 / 2;
final int DOSSIER_CHAISE_H = 50 / 2;
final int DOSSIER_CHAISE_D = 4 / 2;

PShape chaise;
PImage woodChaise;

PShape createChaise() {
  PShape chaise = createShape(GROUP);

  PShape assise = createAssiseChaise();
  PShape dossier = createDossierChaise();
  PShape piedFrontLeft = createPiedChaise();
  PShape piedFrontRight = createPiedChaise();
  PShape piedBackLeft = createPiedChaise();
  PShape piedBackRight = createPiedChaise();

  assise.translate(0, - ASSISE_CHAISE_H, 0);
  dossier.translate(0, - (ASSISE_CHAISE_H * 2 + DOSSIER_CHAISE_H), (ASSISE_CHAISE_D - DOSSIER_CHAISE_D));
  piedFrontLeft.translate(- (ASSISE_CHAISE_W - PIED_CHAISE_D), PIED_CHAISE_H, (ASSISE_CHAISE_D - PIED_CHAISE_D));
  piedFrontRight.translate((ASSISE_CHAISE_W - PIED_CHAISE_D), PIED_CHAISE_H, (ASSISE_CHAISE_D - PIED_CHAISE_D));
  piedBackLeft.translate(- (ASSISE_CHAISE_W - PIED_CHAISE_D), PIED_CHAISE_H, - (ASSISE_CHAISE_D - PIED_CHAISE_D));
  piedBackRight.translate((ASSISE_CHAISE_W - PIED_CHAISE_D), PIED_CHAISE_H, - (ASSISE_CHAISE_D - PIED_CHAISE_D));

  chaise.addChild(assise);
  chaise.addChild(dossier);
  chaise.addChild(piedFrontLeft);
  chaise.addChild(piedFrontRight);
  chaise.addChild(piedBackLeft);
  chaise.addChild(piedBackRight);

  // descend le centre de la chaise au niveau du sol
  chaise.translate(0, -PIED_CHAISE_H * 2, 0);

  return chaise;
}

PShape createAssiseChaise() {
  PImage[] textures = new PImage[] {
    woodChaise,
    woodChaise,
    woodChaise,
    woodChaise,
    woodChaise,
    woodChaise
  };

  PShape assiseChaise = new CubeMagique(textures, defaultColors).build();

  assiseChaise.scale(ASSISE_CHAISE_W, ASSISE_CHAISE_H, ASSISE_CHAISE_D);

  return assiseChaise;
}

PShape createDossierChaise() {
  PImage[] textures = new PImage[] {
    woodChaise,
    woodChaise,
    woodChaise,
    woodChaise,
    woodChaise,
    woodChaise
  };

  PShape dossierChaise = new CubeMagique(textures, defaultColors).invertUVs().build();

  dossierChaise.scale(DOSSIER_CHAISE_W, DOSSIER_CHAISE_H, DOSSIER_CHAISE_D);

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

  PShape piedChaise = new CubeMagique(textures, defaultColors).withSpecular(255.0, 255.0, 255.0).build();

  piedChaise.scale(PIED_CHAISE_W, PIED_CHAISE_H, PIED_CHAISE_D);

  return piedChaise;
}

void loadChaiseImages() {
  woodChaise = loadImage("asset/chaise/woodChair.jpg");
}
