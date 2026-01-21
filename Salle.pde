final int SALLE_W = 600 / 2;
final int SALLE_H = 280 / 2;
final int SALLE_D = 980 / 2;
final int EPAISSEUR = 10 / 2;
final int LONGUEUR_PILLIER_MUR = SALLE_W / 8;
final int MUR_GAUCHE_HAUT_H = 20 / 2;

final int MUR_UV_TILING = 4;

PShape salle;
PShape murAvant, murArriere, murGauche, murDroit, plafond, sol;
PImage bottom, wall, roof;

PShape createSalle() {
  PShape salle = createShape(GROUP);

  sol = createSol();
  plafond = createPlafond();
  murGauche = createMurGauche();
  murDroit = createMurDroit();
  murAvant = createMurAvant();
  murArriere = createMurArriere();

  sol.translate(0, SALLE_H + EPAISSEUR, 0);
  plafond.translate(0, -SALLE_H - EPAISSEUR, 0);
  murGauche.translate(-SALLE_W - EPAISSEUR, 0, 0);
  murDroit.translate(SALLE_W + EPAISSEUR, 0, 0);
  murAvant.translate(0, 0, SALLE_D + EPAISSEUR);
  murArriere.translate(0, 0, -SALLE_D - EPAISSEUR);

  salle.addChild(sol);
  salle.addChild(plafond);
  salle.addChild(murGauche);
  salle.addChild(murDroit);
  salle.addChild(murAvant);
  salle.addChild(murArriere);

  return salle;
}

void loadSalleImages() {
  bottom = loadImage("asset/salle/laminate_floor_02_diff_1k.jpg");
  wall = loadImage("asset/salle/wall.jpg");
  roof = loadImage("asset/salle/demountable-ceiling-tile-stack-2440-mm.jpg");
}

PShape createSol() {
  PImage[] textures = new PImage[] {
    noTexture,
    noTexture,
    noTexture,
    noTexture,
    noTexture,
    bottom
  };

  PShape sol = new CubeMagique(textures, defaultColors).withUVTiling(MUR_UV_TILING).withShininess(100).withSpecular(255).build();
  sol.scale(SALLE_W, EPAISSEUR, SALLE_D);

  return sol;
}

PShape createPlafond() {
  PImage[] textures = new PImage[] {
    noTexture,
    noTexture,
    noTexture,
    noTexture,
    roof,
    noTexture
  };

  PShape plafond = new CubeMagique(textures, defaultColors).withUVTiling(2).build();
  plafond.scale(SALLE_W, EPAISSEUR, SALLE_D);

  return plafond;
}

PShape createMurGauche() {
  PShape murGaucheEntier = createShape(GROUP);
  murGaucheEntier.translate(0, SALLE_H, 0);

  PImage[] textures = new PImage[] {
    noTexture,
    noTexture,
    wall,
    noTexture,
    noTexture,
    noTexture
  };

  PVector[] colors = new PVector[] {
    new PVector(255, 255, 255),
    new PVector(255, 255, 255),
    new PVector(255, 255, 255),
    new PVector(255, 255, 255),
    new PVector(255, 255, 255),
    new PVector(0, 0, 0),
  };

  PShape murGaucheBas = new CubeMagique(textures, colors).withUVTiling(MUR_UV_TILING).build();
  PShape murGaucheHaut = new CubeMagique(textures, colors).build();

  murGaucheBas.scale(EPAISSEUR, SALLE_H / 3, SALLE_D);
  murGaucheHaut.scale(EPAISSEUR, MUR_GAUCHE_HAUT_H, SALLE_D);

  murGaucheBas.translate(0, -SALLE_H / 3, 0);
  murGaucheHaut.translate(0, (-SALLE_H * 2) + MUR_GAUCHE_HAUT_H, 0);

  murGaucheEntier.addChild(murGaucheBas);
  murGaucheEntier.addChild(murGaucheHaut);

  for (int i : new int[] {SALLE_D - LONGUEUR_PILLIER_MUR, 0, -SALLE_D + LONGUEUR_PILLIER_MUR}) {
    PShape pillier = createPillierMur(LONGUEUR_PILLIER_MUR);
    pillier.translate(0, (-SALLE_H * 2) + (SALLE_H - SALLE_H / 3 - MUR_GAUCHE_HAUT_H) + MUR_GAUCHE_HAUT_H * 2, i);
    murGaucheEntier.addChild(pillier);
  }

  return murGaucheEntier;
}

PShape createPillierMur(int longueur) {
  PImage[] textures = new PImage[] {
    noTexture,
    noTexture,
    wall,
    noTexture,
    noTexture,
    noTexture
  };

  PShape pillierMur = new CubeMagique(textures, defaultColors).withUVTiling(MUR_UV_TILING).build();
  pillierMur.scale(EPAISSEUR, SALLE_H - SALLE_H / 3 - MUR_GAUCHE_HAUT_H, longueur);

  return pillierMur;
}

PShape createMurDroit() {
  PImage[] textures = new PImage[] {
    noTexture,
    noTexture,
    noTexture,
    wall,
    noTexture,
    noTexture
  };

  PShape murDroit = new CubeMagique(textures, defaultColors).withUVTiling(MUR_UV_TILING).build();
  murDroit.scale(EPAISSEUR, SALLE_H, SALLE_D);

  return murDroit;
}

PShape createMurAvant() {
  PImage[] textures = new PImage[] {
    noTexture,
    wall,
    noTexture,
    noTexture,
    noTexture,
    noTexture
  };

  PShape murAvant = new CubeMagique(textures, defaultColors).withUVTiling(MUR_UV_TILING).build();
  murAvant.scale(SALLE_W, SALLE_H, EPAISSEUR);

  return murAvant;
}

PShape createMurArriere() {
  PImage[] textures = new PImage[] {
    wall,
    noTexture,
    noTexture,
    noTexture,
    noTexture,
    noTexture
  };

  PShape murArriere = new CubeMagique(textures, defaultColors).withUVTiling(MUR_UV_TILING).build();
  murArriere.scale(SALLE_W, SALLE_H, EPAISSEUR);

  return murArriere;
}
