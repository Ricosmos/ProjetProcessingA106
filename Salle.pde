final int SALLE_W = 600 / 2;
final int SALLE_H = 280 / 2;
final int SALLE_D = 980 / 2;

PShape salle;
PShape murAvant, murArriere, murGauche, murDroit, plafond, sol;
PImage bottom, wall;

PShape createSalle() {
  PImage[] textures = new PImage[] {
    wall,
    wall,
    wall,
    wall,
    bottom,
    bottom
  };

  PShape salle = new CubeMagique(textures, defaultColors).invertUVs().invertNormals().withUVTiling(4).build();

  salle.scale(SALLE_W, SALLE_H, SALLE_D);

  return salle;
}

void loadSalleImages() {
  bottom = loadImage("asset/salle/laminate_floor_02_diff_1k.jpg");
  wall = loadImage("asset/salle/wall.jpg");
}