final int ECRAN_W = 170 / 2;
final int ECRAN_H = 102 / 2;
final int ECRAN_D = 4 / 2;

final int PIED_ECRAN_W = 20 / 2;
final int PIED_ECRAN_H = 111 / 2;
final int PIED_ECRAN_D = 15 / 2;

final int SUPPORT_PIED_ECRAN_W = 140 / 2;
final int SUPPORT_PIED_ECRAN_H = 10 / 2;
final int SUPPORT_PIED_ECRAN_D = 20 / 2;

final int SUPPORT_PIED_ECRAN_LATERAL_W = 10 / 2;
final int SUPPORT_PIED_ECRAN_LATERAL_H = SUPPORT_PIED_ECRAN_H;
final int SUPPORT_PIED_ECRAN_LATERAL_D = 100 / 2;


PShape ecranSpeechi;
PImage screenTexture;

PShape createEcran() {
  PShape ecranSpeechi = createShape(GROUP);

  PShape ecran = createEcranSpeechi();
  PShape pied = createPiedEcran();
  PShape supportPied = createSupportPiedEcran();

  ecran.translate(0, -ECRAN_H, -SUPPORT_PIED_ECRAN_LATERAL_D / 3);
  pied.translate(0, PIED_ECRAN_H, -SUPPORT_PIED_ECRAN_LATERAL_D / 3);
  supportPied.translate(0, PIED_ECRAN_H * 2 + SUPPORT_PIED_ECRAN_H, 0);

  ecranSpeechi.addChild(ecran);
  ecranSpeechi.addChild(pied);
  ecranSpeechi.addChild(supportPied);

  ecranSpeechi.translate(0, -(PIED_ECRAN_H * 2 + SUPPORT_PIED_ECRAN_H * 2), 0);

  return ecranSpeechi;
}

PShape createEcranSpeechi() {
  PImage[] textures = new PImage[] {
    noTexture,
    noTexture,
    noTexture,
    noTexture,
    noTexture,
    noTexture
  };

  PShape ecran = new CubeMagique(textures, defaultColors).build();

  ecran.scale(ECRAN_W, ECRAN_H, ECRAN_D);

  return ecran;
}

PShape createPiedEcran() {
  PShape piedEcran = new CubeMagique(missingTextures, defaultColors).build();

  piedEcran.scale(PIED_ECRAN_W, PIED_ECRAN_H, PIED_ECRAN_D);

  return piedEcran;
}

PShape createSupportPiedEcran() {
  PShape supportPiedEcran = createShape(GROUP);

  PShape supportPiedEcranCentral = new CubeMagique(missingTextures, defaultColors).build();
  PShape supportPiedEcranLateralLeft = new CubeMagique(missingTextures, defaultColors).build();
  PShape supportPiedEcranLateralRight = new CubeMagique(missingTextures, defaultColors).build();

  supportPiedEcranCentral.scale(SUPPORT_PIED_ECRAN_W, SUPPORT_PIED_ECRAN_H, SUPPORT_PIED_ECRAN_D);
  supportPiedEcranLateralLeft.scale(SUPPORT_PIED_ECRAN_LATERAL_W, SUPPORT_PIED_ECRAN_LATERAL_H, SUPPORT_PIED_ECRAN_LATERAL_D);
  supportPiedEcranLateralRight.scale(SUPPORT_PIED_ECRAN_LATERAL_W, SUPPORT_PIED_ECRAN_LATERAL_H, SUPPORT_PIED_ECRAN_LATERAL_D);

  supportPiedEcranCentral.translate(0, 0, -SUPPORT_PIED_ECRAN_LATERAL_D / 3);
  supportPiedEcranLateralLeft.translate(- (SUPPORT_PIED_ECRAN_W + SUPPORT_PIED_ECRAN_LATERAL_W), 0, 0);
  supportPiedEcranLateralRight.translate((SUPPORT_PIED_ECRAN_W + SUPPORT_PIED_ECRAN_LATERAL_W), 0, 0);

  supportPiedEcran.addChild(supportPiedEcranCentral);
  supportPiedEcran.addChild(supportPiedEcranLateralLeft);
  supportPiedEcran.addChild(supportPiedEcranLateralRight);

  return supportPiedEcran;
}

void loadTexturesecranSpeechi() {
  screenTexture = loadImage("asset/ecranSpeechi/screen_texture.jpg");
}
