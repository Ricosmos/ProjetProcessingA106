PShape skybox;
PImage negx, posx, negy, posy, negz, posz;

PShape createSkyBox() {
  PImage[] textures = new PImage[] {
    posz,
    negz,
    posx,
    negx,
    negy,
    posy
  };

  PShape skyBox = createCubeMagique(textures, defaultColors);

  skyBox.scale(3000, 3000, 3000);

  return skyBox;
}

void loadSkyboxImages() {
  negx = loadImage("asset/sky_04_cubemap_2k/nx.png");
  posx = loadImage("asset/sky_04_cubemap_2k/px.png");
  negy = loadImage("asset/sky_04_cubemap_2k/ny.png");
  posy = loadImage("asset/sky_04_cubemap_2k/py.png");
  negz = loadImage("asset/sky_04_cubemap_2k/nz.png");
  posz = loadImage("asset/sky_04_cubemap_2k/pz.png");
}
