final int ECRAN_W = 170 / 2;
final int ECRAN_H = 102 / 2;
final int ECRAN_D = 4 / 2;

final int PIED_ECRAN_W = 20 / 2;
final int PIED_ECRAN_H = 160 / 2;
final int PIED_ECRAN_D = 15 / 2;

final int SUPPORT_PIED_ECRAN_W = 140 / 2;
final int SUPPORT_PIED_ECRAN_H = 10 / 2;
final int SUPPORT_PIED_ECRAN_D = 20 / 2;

final int SUPPORT_PIED_ECRAN_LATERAL_W = 10 / 2;
final int SUPPORT_PIED_ECRAN_LATERAL_H = SUPPORT_PIED_ECRAN_H;
final int SUPPORT_PIED_ECRAN_LATERAL_D = 100 / 2;


PShape ecranSpeechi;
PImage speechiTexture;

PVector[] colorEcranSpeechi = new PVector[] {
  new PVector(50, 50, 50),
  new PVector(50, 50, 50),
  new PVector(50, 50, 50),
  new PVector(50, 50, 50),
  new PVector(50, 50, 50),
  new PVector(50, 50, 50)
};

PShape createEcran() {
  PShape ecranSpeechi = createShape(GROUP);

  PShape ecran = createMoniteur(ECRAN_W, ECRAN_H, ECRAN_D, speechiTexture, 0);
  PShape pied = createPiedEcran();
  PShape supportPied = createSupportPiedEcran();

  ecran.translate(0, PIED_ECRAN_H / 2, -SUPPORT_PIED_ECRAN_LATERAL_D / 3 + SUPPORT_PIED_ECRAN_D);
  pied.translate(0, PIED_ECRAN_H, -SUPPORT_PIED_ECRAN_LATERAL_D / 3);
  supportPied.translate(0, PIED_ECRAN_H * 2 + SUPPORT_PIED_ECRAN_H, 0);

  ecranSpeechi.addChild(ecran);
  ecranSpeechi.addChild(pied);
  ecranSpeechi.addChild(supportPied);

  ecranSpeechi.translate(0, -(PIED_ECRAN_H * 2 + SUPPORT_PIED_ECRAN_H * 2), 0);

  return ecranSpeechi;
}

PShape createPiedEcran() {
  PShape piedEcran = new CubeMagique(missingTextures, colorEcranSpeechi).build(PIED_ECRAN_W, PIED_ECRAN_H, PIED_ECRAN_D);

  return piedEcran;
}

PShape createSupportPiedEcran() {
  PShape supportPiedEcran = createShape(GROUP);

  PShape supportPiedEcranCentral = new CubeMagique(missingTextures, colorEcranSpeechi).build(SUPPORT_PIED_ECRAN_W, SUPPORT_PIED_ECRAN_H, SUPPORT_PIED_ECRAN_D);
  PShape supportPiedEcranLateralLeft = new CubeMagique(missingTextures, colorEcranSpeechi).build(SUPPORT_PIED_ECRAN_LATERAL_W, SUPPORT_PIED_ECRAN_LATERAL_H, SUPPORT_PIED_ECRAN_LATERAL_D);
  PShape supportPiedEcranLateralRight = new CubeMagique(missingTextures, colorEcranSpeechi).build(SUPPORT_PIED_ECRAN_LATERAL_W, SUPPORT_PIED_ECRAN_LATERAL_H, SUPPORT_PIED_ECRAN_LATERAL_D);

  supportPiedEcranCentral.translate(0, 0, -SUPPORT_PIED_ECRAN_LATERAL_D / 3);
  supportPiedEcranLateralLeft.translate(- (SUPPORT_PIED_ECRAN_W + SUPPORT_PIED_ECRAN_LATERAL_W), 0, 0);
  supportPiedEcranLateralRight.translate((SUPPORT_PIED_ECRAN_W + SUPPORT_PIED_ECRAN_LATERAL_W), 0, 0);

  supportPiedEcran.addChild(supportPiedEcranCentral);
  supportPiedEcran.addChild(supportPiedEcranLateralLeft);
  supportPiedEcran.addChild(supportPiedEcranLateralRight);

  return supportPiedEcran;
}

void loadTexturesecranSpeechi() {
  speechiTexture = loadImage("asset/yellowstone-NationalGeographic_1743804.jpg");
}
