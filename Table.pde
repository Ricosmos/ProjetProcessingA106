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

// PC

final int COMPUTER_W = 10 / 2;
final int COMPUTER_H = 28 / 2;
final int COMPUTER_D = 25 / 2;

final int COMPUTER_BOX_W = 12 / 2;
final int COMPUTER_BOX_H = 30 / 2;
final int COMPUTER_BOX_D = 27 / 2;
final float COMPUTER_BOX_EPAISSEUR = 1 / 2;

// KEYBOARD AND MOUSE

final int KEYBOARD_W = 45 / 2;
final int KEYBOARD_H = 2 / 2;
final int KEYBOARD_D = 20 / 2;
final int KEYBOARD_OFFSET_X = 10;
final int KEYBOARD_OFFSET_Z = 20;

final int MOUSE_W = 8 / 2;
final int MOUSE_H = 2 / 2;
final int MOUSE_D = 12 / 2;
final int MOUSE_OFFSET_X = 10;
final int MOUSE_OFFSET_Z = 20;

// Offsets and spacing
final int SUPPORT_MONITOR_OFFSET_Z = 22;
final int COMPUTER_OFFSET_X = 10;
final int MONITEUR_SHININESS = 150;

// Animation speeds
final float TABLE_OPEN_SPEED = -0.2;
final float TABLE_CLOSE_SPEED = 0.2;

// Colors
final int PIED_COLOR_VALUE = 150;
final int SUPPORT_MONITOR_COLOR_VALUE = 120;
final int COMPUTER_BOX_COLOR_VALUE = 10;
final int COMPUTER_SIDE_COLOR_VALUE = 40;
final int KEYBOARD_DARK_COLOR_VALUE = 20;
final int MOUSE_DARK_COLOR_VALUE = 40;

ArrayList<Table> tables = new ArrayList<Table>();

PImage wood, woodTopClosed, woodTopOpen, woodTopOpenInvert, woodTopMoniteur, bureau, bureauSide, caseFace, keyboardTexture, mouseTexture;
PShape tableOpen, tableClosed, supportMoniteurDynamique;

PVector computerBoxColor = new PVector(COMPUTER_BOX_COLOR_VALUE, COMPUTER_BOX_COLOR_VALUE, COMPUTER_BOX_COLOR_VALUE);
PVector[] boxComputerColors = new PVector[] {
  computerBoxColor,
  computerBoxColor,
  computerBoxColor,
  computerBoxColor,
  computerBoxColor,
  computerBoxColor
};

PVector computerColor = new PVector(COMPUTER_SIDE_COLOR_VALUE, COMPUTER_SIDE_COLOR_VALUE, COMPUTER_SIDE_COLOR_VALUE);
PVector[] computerColors = new PVector[] {
  new PVector(255, 255, 255),
  computerColor,
  computerColor,
  computerColor,
  computerColor,
  computerColor
};

PShape createTable(boolean isOpen) {
  PShape table = createShape(GROUP);

  PShape planche = createPlancheTable(isOpen);
  PShape support = createSupportTable();
  PShape piedLeft = createPiedTable();
  PShape piedRight = createPiedTable();
  PShape supportMoniteur = createSupportMoniteur();
  PShape computer = createComputer();
  PShape keyboard = createKeyboard();
  PShape mouse = createMouse();
  supportMoniteur.setName("SupportMoniteur");

  planche.translate(0, -PLANCHE_H, 0);
  support.translate(0, SUPPORT_H, -PLANCHE_W + SUPPORT_MONITOR_OFFSET_Z);
  piedLeft.translate(-SUPPORT_W + PIED_TABLE_W, SUPPORT_H * 2 + PIED_TABLE_H, 0);
  piedRight.translate(SUPPORT_W - PIED_TABLE_W, SUPPORT_H * 2 + PIED_TABLE_H, 0);

  supportMoniteur.translate(0, 0, -PLANCHE_W + SUPPORT_MONITOR_OFFSET_Z);
  computer.translate(PLANCHE_W - COMPUTER_BOX_W - COMPUTER_OFFSET_X, COMPUTER_BOX_H, COMPUTER_BOX_D);
  keyboard.translate(-PLANCHE_W + KEYBOARD_W + KEYBOARD_OFFSET_X, -PLANCHE_H * 2, PLANCHE_D - KEYBOARD_D - KEYBOARD_OFFSET_Z);
  mouse.translate(PLANCHE_W - MOUSE_W - MOUSE_OFFSET_X, -PLANCHE_H * 2, PLANCHE_D - MOUSE_D - KEYBOARD_D / 2 - MOUSE_OFFSET_Z);

  if (isOpen) {
    table.addChild(supportMoniteur);
    table.addChild(keyboard);
    table.addChild(mouse);
    supportMoniteurDynamique = table.getChild("SupportMoniteur");
  }

  table.addChild(support);
  table.addChild(piedLeft);
  table.addChild(piedRight);
  table.addChild(planche);
  table.addChild(computer);

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

  PVector grey = new PVector(PIED_COLOR_VALUE, PIED_COLOR_VALUE, PIED_COLOR_VALUE);
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

  PVector grey = new PVector(SUPPORT_MONITOR_COLOR_VALUE, SUPPORT_MONITOR_COLOR_VALUE, SUPPORT_MONITOR_COLOR_VALUE);
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
  PShape moniteur = createMoniteur(MONITEUR_W, MONITEUR_H, MONITEUR_D, moniteurTexture, MONITEUR_SHININESS);

  supportDessus.translate(0, -PLANCHE_TROU_H, 0);
  supportPillier.translate(0, PILLIER_SUPPORT_H, 0);
  supportBase.translate(0, PILLIER_SUPPORT_H * 2, 0);
  moniteur.translate(0, MONITEUR_H, PILLIER_SUPPORT_D * 2);

  supportMoniteur.addChild(moniteur);
  supportMoniteur.addChild(supportDessus);
  supportMoniteur.addChild(supportPillier);
  supportMoniteur.addChild(supportBase);

  return supportMoniteur;
}

PShape createComputer() {
  PImage[] computerTextures = new PImage[] {
    caseFace,
    noTexture,
    noTexture,
    noTexture,
    noTexture,
    noTexture
  };

  PShape computerBox = createShape(GROUP);

  PShape boxLeft = new CubeMagique(missingTextures, boxComputerColors).build(COMPUTER_BOX_EPAISSEUR, COMPUTER_BOX_H, COMPUTER_BOX_D);
  PShape boxRight = new CubeMagique(missingTextures, boxComputerColors).build(COMPUTER_BOX_EPAISSEUR, COMPUTER_BOX_H, COMPUTER_BOX_D);
  PShape boxTop = new CubeMagique(missingTextures, boxComputerColors).build(COMPUTER_BOX_W, COMPUTER_BOX_EPAISSEUR, COMPUTER_BOX_D);
  PShape boxBottom = new CubeMagique(missingTextures, boxComputerColors).build(COMPUTER_BOX_W, COMPUTER_BOX_EPAISSEUR, COMPUTER_BOX_D);
  PShape boxBack = new CubeMagique(missingTextures, boxComputerColors).build(COMPUTER_BOX_W, COMPUTER_BOX_H, COMPUTER_BOX_EPAISSEUR);

  PShape computer = new CubeMagique(computerTextures, computerColors).build(COMPUTER_W, COMPUTER_H, COMPUTER_D);

  boxLeft.translate(-COMPUTER_BOX_W, 0, 0);
  boxRight.translate(COMPUTER_BOX_W, 0, 0);
  boxTop.translate(0, -COMPUTER_BOX_H, 0);
  boxBottom.translate(0, COMPUTER_BOX_H, 0);
  boxBack.translate(0, 0, -COMPUTER_BOX_D);

  computerBox.addChild(boxLeft);
  computerBox.addChild(boxRight);
  computerBox.addChild(boxTop);
  computerBox.addChild(boxBottom);
  computerBox.addChild(boxBack);
  computerBox.addChild(computer);

  return computerBox;
}

PShape createKeyboard() {
  PImage[] textures = new PImage[] {
    keyboardTexture,
    noTexture,
    noTexture,
    noTexture,
    noTexture,
    keyboardTexture
  };

  PVector darkColor = new PVector(KEYBOARD_DARK_COLOR_VALUE, KEYBOARD_DARK_COLOR_VALUE, KEYBOARD_DARK_COLOR_VALUE);
  PVector[] keyboardColors = new PVector[] {
    darkColor,
    darkColor,
    darkColor,
    darkColor,
    darkColor,
    new PVector(255, 255, 255)
  };

  PShape keyboard = new CubeMagique(textures, keyboardColors).build(KEYBOARD_W, KEYBOARD_H, KEYBOARD_D);

  return keyboard;
}

PShape createMouse() {
  PImage[] textures = new PImage[] {
    noTexture,
    noTexture,
    noTexture,
    noTexture,
    noTexture,
    mouseTexture
  };

  PVector darkColor = new PVector(MOUSE_DARK_COLOR_VALUE, MOUSE_DARK_COLOR_VALUE, MOUSE_DARK_COLOR_VALUE);
  PVector[] mouseColors = new PVector[] {
    darkColor,
    darkColor,
    darkColor,
    darkColor,
    darkColor,
    new PVector(255, 255, 255)
  };

  PShape mouse = new CubeMagique(textures, mouseColors).build(MOUSE_W, MOUSE_H, MOUSE_D);

  return mouse;
}

void loadTableImages() {
  bureau = loadImage("asset/table/bureau.jpg");
  bureauSide = loadImage("asset/table/bureauSide.jpg");
  wood = loadImage("asset/table/woodTable.jpg");
  woodTopClosed = loadImage("asset/table/woodTableTop.jpg");
  woodTopOpen = loadImage("asset/table/woodTableTop.png");
  woodTopOpenInvert = loadImage("asset/table/woodTableTopInvert.png");
  woodTopMoniteur = loadImage("asset/table/woodTableTopEcran.png");
  caseFace = loadImage("asset/table/dell_front_case.png");
  keyboardTexture = loadImage("asset/table/keyboard.jpg");
  mouseTexture = loadImage("asset/table/mouse.png");
}

void keyPressedTable() {
  if (key == 't' || key == 'T') {
    for (Table table : tables)
      table.toggleTable();
  }
}

void animateTable() {
  for (Table table : tables)
    table.animateTable();
}

class Table {
  boolean isTableOpen;
  boolean isTableMoving;
  float supportCurrentHeight;

  float deltaX, deltaZ;

  Table(float deltaX, float deltaZ, boolean isOpen) {
    this.deltaX = deltaX;
    this.deltaZ = deltaZ;
    this.isTableOpen = isOpen;
    this.isTableMoving = false;
    this.supportCurrentHeight = isOpen ? -TARGET_SUPPORT_HEIGHT_OPEN : 0;
  }

  void animateTable() {
    if (!isTableMoving)
      return;

    int targetHeight = isTableOpen ? -TARGET_SUPPORT_HEIGHT_OPEN : 0;
    float speed = isTableOpen ? TABLE_OPEN_SPEED : TABLE_CLOSE_SPEED;
    supportCurrentHeight += speed;

    if ((speed > 0 && supportCurrentHeight > targetHeight) ||
      (speed < 0 && supportCurrentHeight < targetHeight)) {
      supportCurrentHeight = targetHeight;
      isTableMoving = false;
      return;
    }
  }

  void toggleTable() {
    isTableOpen = !isTableOpen;
    isTableMoving = true;
  }

  void drawTable() {
    supportMoniteurDynamique.resetMatrix();
    supportMoniteurDynamique.translate(0, supportCurrentHeight, -PLANCHE_W + SUPPORT_MONITOR_OFFSET_Z);
    shape(isTableOpen || isTableMoving ? tableOpen : tableClosed);
  }

  void randomChange() {
    if (isTableMoving)
      return;

    if (random(10000) < 3)
      toggleTable();
  }
}
