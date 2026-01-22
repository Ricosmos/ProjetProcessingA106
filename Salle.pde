final float SALLE_W = 600 / 2;
final float SALLE_H = 280 / 2;
final float SALLE_D = 980 / 2;
final float EPAISSEUR = 10 / 2;
final float EPAISSEUR_GLASS_PANE = 5 / 2;
final float LONGUEUR_PILLIER_MUR = SALLE_D / 8;
final float MUR_GAUCHE_HAUT_H = 20 / 2;
final float LONGUEUR_GLASS_PANE = SALLE_D / 8 * 5 / 2;

final int MUR_UV_TILING = 4;

PShape salle;
PShape murAvant, murArriere, murGauche, murDroit, plafond, sol;
PImage bottom, wall, roof, glassPane;

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
  glassPane = loadImage("asset/salle/glass_pane.png");
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

  float[] positionsPilliers = new float[] {SALLE_D - LONGUEUR_PILLIER_MUR, 0, -SALLE_D + LONGUEUR_PILLIER_MUR};

  for (int i = 0; i < positionsPilliers.length; i++) {
    PShape pillier = createPillierMur(LONGUEUR_PILLIER_MUR);
    pillier.translate(0, (-SALLE_H * 2) + (SALLE_H - SALLE_H / 3 - MUR_GAUCHE_HAUT_H) + MUR_GAUCHE_HAUT_H * 2, positionsPilliers[i]);
    murGaucheEntier.addChild(pillier);

    if (i > 0) {
      PShape glassPane = createGlassPane();
      glassPane.translate(0, (-SALLE_H * 2) + (SALLE_H - SALLE_H / 3 - MUR_GAUCHE_HAUT_H) + MUR_GAUCHE_HAUT_H * 2, positionsPilliers[i] + LONGUEUR_PILLIER_MUR + LONGUEUR_GLASS_PANE);
      murGaucheEntier.addChild(glassPane);
    }
  }

  return murGaucheEntier;
}

PShape createPillierMur(float longueur) {
  PImage[] textures = new PImage[] {
    noTexture,
    noTexture,
    wall,
    noTexture,
    noTexture,
    noTexture
  };

  PVector[] colors = new PVector[] {
    new PVector(0, 0, 0),
    new PVector(0, 0, 0),
    new PVector(255, 255, 255),
    new PVector(255, 255, 255),
    new PVector(0, 0, 0),
    new PVector(0, 0, 0)
  };

  PShape pillierMur = new CubeMagique(textures, colors).withUVTiling(MUR_UV_TILING).build();
  pillierMur.scale(EPAISSEUR, SALLE_H - SALLE_H / 3 - MUR_GAUCHE_HAUT_H, longueur);

  return pillierMur;
}

PShape createGlassPane() {
  PImage[] textures = new PImage[] {
    noTexture,
    noTexture,
    glassPane,
    glassPane,
    noTexture,
    noTexture
  };

  PShape glassPane = new CubeMagique(textures, defaultColors).build();


  glassPane.scale(EPAISSEUR_GLASS_PANE, SALLE_H - SALLE_H / 3 - MUR_GAUCHE_HAUT_H, LONGUEUR_GLASS_PANE);

  return glassPane;
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
