final int PORTE_W = 92 / 2;
final int PORTE_H = 230 / 2;
final int PORTE_D = 4 / 2;

PShape porte;
PImage porteTexture;

PShape createPorte() {
  PImage[] textures = new PImage[] {
    porteTexture,
    porteTexture,
    noTexture,
    noTexture,
    noTexture,
    noTexture
  };

  PShape porte = new CubeMagique(textures, defaultColors).build(PORTE_W, PORTE_H, PORTE_D);

  return porte;
};

void loadPorteTextures() {
  porteTexture = loadImage("textures/porte_diffuse.jpg");
}
