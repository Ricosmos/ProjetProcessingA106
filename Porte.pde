final int PORTE_W = 92 / 2;
final int PORTE_H = 190 / 2;
final int PORTE_D = 4 / 2;

PShape porte;
PImage porteTexture;

PShape createPorte() {
  PImage[] textures = new PImage[] {
    noTexture,
    noTexture,
    noTexture,
    noTexture,
    noTexture,
    noTexture
  };

  PShape porte = new CubeMagique(textures, defaultColors).withCharniere().build(PORTE_W, PORTE_H, PORTE_D);

  porte.translate(0, SALLE_H - PORTE_H, 0);

  return porte;
};

void loadPorteTextures() {
  porteTexture = loadImage("textures/porte_diffuse.jpg");
}
