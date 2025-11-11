final int PLANCHE_W = 80 / 2;
final int PLANCHE_H = 2 / 2;
final int PLANCHE_D = 80 / 2;

final int SUPPORT_W = 80 / 2;
final int SUPPORT_H = 73 / 2;
final int SUPPORT_D = 21 / 2;

PImage wood, woodTop, bureau;
PShape table;

PShape createTable() {
  PShape table = createShape(GROUP);

  PShape planche = createPlancheTable();
  PShape support = createSupportTable();

  planche.translate(0, -SUPPORT_H * 2 + PLANCHE_H / 2, 0);
//   support.translate(0, SUPPORT_H * 2, 0);

  table.addChild(planche);
  table.addChild(support);

  return table;
}

PShape createPlancheTable() {
  PImage[] textures = new PImage[] {
	wood,
	wood,
	wood,
	wood,
	wood,
	woodTop
  };

  PShape plancheTable = createCubeMagique(textures, defaultColors);

  plancheTable.scale(PLANCHE_W, PLANCHE_H, PLANCHE_D);

  return plancheTable;
}

PShape createSupportTable() {
  PImage[] textures = new PImage[] {
	bureau,
	bureau,
	bureau,
	bureau,
	noTexture,
	noTexture
  };

  PShape supportTable = createCubeMagique(textures, defaultColors);

  supportTable.scale(SUPPORT_W, SUPPORT_H, SUPPORT_D);

  return supportTable;
}