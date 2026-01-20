final int TABLEAU_W = 400 / 2;
final int TABLEAU_H = 122 / 2;
final int TABLEAU_D = 4 / 2;

final int HAUTEUR_TABLEAU = 81;

final int CADRE_TABLEAU_EPAISSEUR_HAUT = 4 / 2;
final int CADRE_TABLEAU_EPAISSEUR_BAS = 10 / 2;

PShape tableau;
PImage textureTableau;

PVector[] colorTableau = new PVector[] {
  new PVector(255, 255, 255),
  new PVector(255, 255, 255),
  new PVector(255, 255, 255),
  new PVector(255, 255, 255),
  new PVector(255, 255, 255),
  new PVector(255, 255, 255)
};

PShape createTableau() {
  PShape tableau = createShape(GROUP);

  PShape cadre = createCadreTableau();
  PShape tableauVert = createTableauVert();

  tableau.addChild(cadre);
  tableau.addChild(tableauVert);
  tableau.translate(0, -(TABLEAU_H + CADRE_TABLEAU_EPAISSEUR_BAS * 2), 0);

  return tableau;
}

PShape createCadreTableau() {
  PShape cadreTableau = createShape(GROUP);

  PImage[] missingTextures = new PImage[] {
    metal,
    metal,
    metal,
    metal,
    metal,
    metal
  };

  PShape cadreTableauHaut = new CubeMagique(missingTextures, defaultColors).withUVTiling(4).build();
  PShape cadreTableauBas = new CubeMagique(missingTextures, defaultColors).withUVTiling(4).build();

  cadreTableauHaut.scale(TABLEAU_W, CADRE_TABLEAU_EPAISSEUR_HAUT, TABLEAU_D + 1);
  cadreTableauBas.scale(TABLEAU_W, CADRE_TABLEAU_EPAISSEUR_BAS, TABLEAU_D + 1);

  cadreTableauHaut.translate(0, - (TABLEAU_H + CADRE_TABLEAU_EPAISSEUR_HAUT), 0);
  cadreTableauBas.translate(0, TABLEAU_H + CADRE_TABLEAU_EPAISSEUR_BAS, 0);

  cadreTableau.addChild(cadreTableauHaut);
  cadreTableau.addChild(cadreTableauBas);

  return cadreTableau;
}

PShape createTableauVert() {
  PImage[] textures = new PImage[] {
    textureTableau,
    noTexture,
    noTexture,
    noTexture,
    noTexture,
    noTexture
  };

  PShape tableauVert = new CubeMagique(textures, colorTableau).build();

  tableauVert.scale(TABLEAU_W, TABLEAU_H, TABLEAU_D);

  return tableauVert;
}

void loadTableauImages() {
  textureTableau = loadImage("asset/tableau/tableau.jpg");
}
