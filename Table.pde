final int PLANCHE_W = 80 / 2;
final int PLANCHE_H = 2 / 2;
final int PLANCHE_D = PLANCHE_W;

final int TARGET_SUPPORT_HEIGHT_OPEN = 40;

final int SUPPORT_W = 80 / 2;
final int SUPPORT_H = 73 / 2;
final int SUPPORT_D = 25 / 2;

final int PIED_TABLE_W = 10 / 2;
final int PIED_TABLE_H = 5 / 2;
final int PIED_TABLE_D = 70 / 2;

// SUPPORT MONITEUR

final int PLANCHE_TROU_W = PLANCHE_W - 8;
final int PLANCHE_TROU_H = PLANCHE_H;
final int PLANCHE_TROU_D = 25 / 2;

final int PILLIER_SUPPORT_W = 8 / 2;
final int PILLIER_SUPPORT_H = SUPPORT_H;
final int PILLIER_SUPPORT_D = 4 / 2;

PImage wood, woodTopClosed, woodTopOpen, woodTopOpenInvert, woodTopMoniteur, bureau, bureauSide;
PShape tableOpen, tableClosed, supportMoniteurDynamique;

boolean isTableOpen = false;
boolean isTableMoving = false;
float supportCurrentHeight = 0;

PShape createTable(boolean isOpen) {
  PShape table = createShape(GROUP);

  PShape planche = createPlancheTable(isOpen);
  PShape support = createSupportTable();
  PShape piedLeft = createPiedTable();
  PShape piedRight = createPiedTable();
  PShape supportMoniteur = createSupportMoniteur();
  supportMoniteur.setName("SupportMoniteur");

  planche.translate(0, -PLANCHE_H, 0);
  support.translate(0, SUPPORT_H, -PLANCHE_W + 22);
  piedLeft.translate(-SUPPORT_W + PIED_TABLE_W, SUPPORT_H * 2 + PIED_TABLE_H, 0);
  piedRight.translate(SUPPORT_W - PIED_TABLE_W, SUPPORT_H * 2 + PIED_TABLE_H, 0);

  supportMoniteur.translate(0, 0, -PLANCHE_W + 22);

  if (isOpen) {
    table.addChild(supportMoniteur);
    supportMoniteurDynamique = table.getChild("SupportMoniteur");
  }
  table.addChild(support);
  table.addChild(piedLeft);
  table.addChild(piedRight);
  table.addChild(planche);

  // descend le centre de la table au niveau du sol
  table.translate(0, -(SUPPORT_H + PIED_TABLE_H) * 2, 0);

  return table;
}

PShape createPlancheTable(boolean isOpen) {
  PImage[] textures;
  if (isOpen) {
    textures = new PImage[] {
      wood,
      wood,
      wood,
      wood,
      woodTopOpenInvert,
      woodTopOpen
    };
  } else {
    textures = new PImage[] {
      wood,
      wood,
      wood,
      wood,
      woodTopClosed,
      woodTopClosed
    };
  }

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

PShape createSupportMoniteur() {
  PImage[] textures = new PImage[] {
    wood,
    wood,
    wood,
    wood,
    woodTopMoniteur,
    woodTopMoniteur
  };

  PVector grey = new PVector(120, 120, 120);
  PVector[] supportColors = new PVector[] {
    grey,
    grey,
    grey,
    grey,
    grey,
    grey
  };

  PShape supportMoniteur = createShape(GROUP);

  PShape supportDessus = new CubeMagique(textures, defaultColors).build(PLANCHE_TROU_W, PLANCHE_TROU_H, PLANCHE_TROU_D);
  PShape supportPillier = new CubeMagique(missingTextures, supportColors).build(PILLIER_SUPPORT_W, PILLIER_SUPPORT_H, PILLIER_SUPPORT_D);
  PShape supportBase = new CubeMagique(missingTextures, supportColors).build(PLANCHE_TROU_W, PLANCHE_TROU_H, PLANCHE_TROU_D);

  supportDessus.translate(0, -PLANCHE_TROU_H, 0);
  supportPillier.translate(0, PILLIER_SUPPORT_H, 0);
  supportBase.translate(0, PILLIER_SUPPORT_H * 2 + PLANCHE_TROU_H, 0);

  supportMoniteur.addChild(supportDessus);
  supportMoniteur.addChild(supportPillier);
  supportMoniteur.addChild(supportBase);

  return supportMoniteur;
}

void loadTableImages() {
  bureau = loadImage("asset/table/bureau.jpg");
  bureauSide = loadImage("asset/table/bureauSide.jpg");
  wood = loadImage("asset/table/woodTable.jpg");
  woodTopClosed = loadImage("asset/table/woodTableTop.jpg");
  woodTopOpen = loadImage("asset/table/woodTableTop.png");
  woodTopOpenInvert = loadImage("asset/table/woodTableTopInvert.png");
  woodTopMoniteur = loadImage("asset/table/woodTableTopEcran.png");
}

void animateTable() {
  if (!isTableMoving)
    return;

  // print("Animating table support. Current height: " + supportCurrentHeight + ", target height: " + (isTableOpen ? -TARGET_SUPPORT_HEIGHT_OPEN : 0));
  int targetHeight = isTableOpen ? -TARGET_SUPPORT_HEIGHT_OPEN : 0;
  float speed = isTableOpen ? -0.5 : 0.5;
  supportCurrentHeight += speed;

  if ((speed > 0 && supportCurrentHeight > targetHeight) ||
    (speed < 0 && supportCurrentHeight < targetHeight)) {
    supportCurrentHeight = targetHeight;
    isTableMoving = false;
    return;
  }

  supportMoniteurDynamique.translate(0, speed, 0);
}

void keyPressedTable() {
  if (key == 't' || key == 'T') {
    isTableOpen = !isTableOpen;
    isTableMoving = true;
  }
}