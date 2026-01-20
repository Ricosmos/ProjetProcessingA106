final int TABLEAU_W = 400 / 2;
final int TABLEAU_H = 122 / 2;
final int TABLEAU_D = 4 / 2;

final int HAUTEUR_TABLEAU = 81 / 2;

final int CADRE_TABLEAU_EPAISSEUR_HAUT = 4 / 2;
final int CADRE_TABLEAU_EPAISSEUR_LATERAL = CADRE_TABLEAU_EPAISSEUR_HAUT;
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
  PShape table = createShape(GROUP);

  PShape cadre = createCadreTableau();
  PShape tableauVert = createTableauVert();

  tableauVert.translate(0, 0, TABLEAU_D / 2 + 0.1f);
  table.addChild(cadre);
  table.addChild(tableauVert);
  table.translate(0, HAUTEUR_TABLEAU, -SALLE_D / 2 + TABLEAU_D);

  return table;
}

PShape createCadreTableau() {
  PShape cadreTableau = createShape(GROUP);

  PVector[] colors = new PVector[] {
    new PVector(255, 255, 255),
    new PVector(255, 255, 255),
    new PVector(139, 69, 19),
    new PVector(139, 69, 19),
    new PVector(139, 69, 19),
    new PVector(139, 69, 19)
  };

  PShape cadreTableauHaut = new CubeMagique(missingTextures, colors).build();
  PShape cadreTableauBas = new CubeMagique(missingTextures, colors).build();
  PShape cadreTableauGauche = new CubeMagique(missingTextures, colors).build();
  PShape cadreTableauDroite = new CubeMagique(missingTextures, colors).build();

  cadreTableauHaut.scale(TABLEAU_W + CADRE_TABLEAU_EPAISSEUR_LATERAL * 2, CADRE_TABLEAU_EPAISSEUR_HAUT, CADRE_TABLEAU_EPAISSEUR_LATERAL);
  cadreTableauBas.scale(TABLEAU_W + CADRE_TABLEAU_EPAISSEUR_BAS * 2, CADRE_TABLEAU_EPAISSEUR_BAS, CADRE_TABLEAU_EPAISSEUR_LATERAL);
  cadreTableauGauche.scale(CADRE_TABLEAU_EPAISSEUR_LATERAL, TABLEAU_H, CADRE_TABLEAU_EPAISSEUR_LATERAL);
  cadreTableauDroite.scale(CADRE_TABLEAU_EPAISSEUR_LATERAL, TABLEAU_H, CADRE_TABLEAU_EPAISSEUR_LATERAL);

  cadreTableauHaut.translate(0, - (TABLEAU_H / 2 + CADRE_TABLEAU_EPAISSEUR_HAUT / 2), 0);
  cadreTableauBas.translate(0, TABLEAU_H / 2 + CADRE_TABLEAU_EPAISSEUR_BAS / 2, 0);
  cadreTableauGauche.translate(- (TABLEAU_W / 2 + CADRE_TABLEAU_EPAISSEUR_BAS / 2), 0, 0);
  cadreTableauDroite.translate(TABLEAU_W / 2 + CADRE_TABLEAU_EPAISSEUR_BAS / 2, 0, 0);

  cadreTableau.addChild(cadreTableauHaut);
  cadreTableau.addChild(cadreTableauBas);
  cadreTableau.addChild(cadreTableauGauche);
  cadreTableau.addChild(cadreTableauDroite);

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
