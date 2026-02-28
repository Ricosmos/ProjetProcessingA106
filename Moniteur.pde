final int MONITEUR_W = 54 / 2;
final int MONITEUR_H = 32 / 2;
final int MONITEUR_D = 2 / 2;

PImage moniteurTexture;

PVector[] colorMoniteur = new PVector[] {
  new PVector(255, 255, 255),
  new PVector(50, 50, 50),
  new PVector(50, 50, 50),
  new PVector(50, 50, 50),
  new PVector(50, 50, 50),
  new PVector(50, 50, 50)
};

PVector[] colorBordureMoniteur = new PVector[] {
  new PVector(50, 50, 50),
  new PVector(50, 50, 50),
  new PVector(50, 50, 50),
  new PVector(50, 50, 50),
  new PVector(50, 50, 50),
  new PVector(50, 50, 50)
};

PShape createMoniteur(float w, float h, float d, PImage screenTexture, float luminosity) {
  PImage[] textures = new PImage[] {
    screenTexture,
    noTexture,
    noTexture,
    noTexture,
    noTexture,
    noTexture
  };

  PShape ecranSpeechi = createShape(GROUP);

  PShape ecran = new CubeMagique(textures, colorMoniteur).withEmissive(luminosity).build(w - 1, h - 1, 1);
  PShape derriereEcran = new CubeMagique(missingTextures, colorMoniteur).build(w, h, d);
  PShape bordureEcranTop = new CubeMagique(missingTextures, colorBordureMoniteur).build(w, 1, d);
  PShape bordureEcranBottom = new CubeMagique(missingTextures, colorBordureMoniteur).build(w, 1, d);
  PShape bordureEcranLeft = new CubeMagique(missingTextures, colorBordureMoniteur).build(1, h, d);
  PShape bordureEcranRight = new CubeMagique(missingTextures, colorBordureMoniteur).build(1, h, d);

  derriereEcran.translate(0, 0, -d);
  bordureEcranTop.translate(0, -h, 0);
  bordureEcranBottom.translate(0, h, 0);
  bordureEcranLeft.translate(-w, 0, 0);
  bordureEcranRight.translate(w, 0, 0);

  ecranSpeechi.addChild(ecran);
  ecranSpeechi.addChild(derriereEcran);
  ecranSpeechi.addChild(bordureEcranTop);
  ecranSpeechi.addChild(bordureEcranBottom);
  ecranSpeechi.addChild(bordureEcranLeft);
  ecranSpeechi.addChild(bordureEcranRight);

  return ecranSpeechi;
}

void loadImagesMoniteur() {
  moniteurTexture = loadImage("asset/table/ubuntu.png");
}
