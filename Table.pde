final int PLANCHE_W = 80 / 2;
final int PLANCHE_H = 2 / 2;
final int PLANCHE_D = PLANCHE_W;

final int SUPPORT_W = 80 / 2;
final int SUPPORT_H = 73 / 2;
final int SUPPORT_D = 25 / 2;

final int PIED_TABLE_W = 10 / 2;
final int PIED_TABLE_H = 5 / 2;
final int PIED_TABLE_D = 70 / 2;

PImage wood, woodTop, woodTopInvert, woodTopMoniteur, bureau, bureauSide;
PShape table, supportMoniteur;

PShape createTable() {
  PShape table = createShape(GROUP);

  PShape planche = createPlancheTable();
  PShape support = createSupportTable();
  PShape piedLeft = createPiedTable();
  PShape piedRight = createPiedTable();

  planche.translate(0, -PLANCHE_H, 0);
  support.translate(0, SUPPORT_H, -PLANCHE_W + 22);
  piedLeft.translate(-SUPPORT_W + PIED_TABLE_W, SUPPORT_H * 2 + PIED_TABLE_H, 0);
  piedRight.translate(SUPPORT_W - PIED_TABLE_W, SUPPORT_H * 2 + PIED_TABLE_H, 0);

  table.addChild(support);
  table.addChild(piedLeft);
  table.addChild(piedRight);
  table.addChild(planche);

  // descend le centre de la table au niveau du sol
  table.translate(0, -(SUPPORT_H + PIED_TABLE_H) * 2, 0);

  return table;
}

PShape createPlancheTable() {
  PImage[] textures = new PImage[] {
    wood,
    wood,
    wood,
    wood,
    woodTopInvert,
    woodTop
  };

  PShape plancheTable = new CubeMagique(textures, defaultColors).build(PLANCHE_W, PLANCHE_H, PLANCHE_D);

  return plancheTable;
}

PShape createSupportTable() {
  PImage[] textures = new PImage[] {
    bureau,
    bureau,
    bureauSide,
    bureauSide,
    noTexture,
    vide
  };

  PShape supportTable = new CubeMagique(textures, defaultColors).build(SUPPORT_W, SUPPORT_H, SUPPORT_D);

  return supportTable;
}

PShape createPiedTable() {
  PImage[] textures = new PImage[] {
    noTexture,
    noTexture,
    noTexture,
    noTexture,
    noTexture,
    noTexture
  };

  PVector grey = new PVector(150, 150, 150);
  PVector[] piedColors = new PVector[] {
    grey,
    grey,
    grey,
    grey,
    grey,
    grey
  };

  PShape piedTable = new CubeMagique(textures, piedColors).build(PIED_TABLE_W, PIED_TABLE_H, PIED_TABLE_D);

  return piedTable;
}

void loadTableImages() {
  bureau = loadImage("asset/table/bureau.jpg");
  bureauSide = loadImage("asset/table/bureauSide.jpg");
  wood = loadImage("asset/table/woodTable.jpg");
  woodTop = loadImage("asset/table/woodTableTop.png");
  woodTopInvert = loadImage("asset/table/woodTableTopInvert.png");
  woodTopMoniteur = loadImage("asset/table/woodTableTopEcran.png");
}
