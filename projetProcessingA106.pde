float angle = 0f;
float s = 500 / 2.0;
PShader colorShader;
PImage negx, posx, negy, posy, negz, posz;
PImage bottom, wall;

PVector[] defaultColors = new PVector[] {
  new PVector(255, 255, 255),
  new PVector(255, 255, 255),
  new PVector(255, 255, 255),
  new PVector(255, 255, 255),
  new PVector(255, 255, 255),
  new PVector(255, 255, 255)
};

PVector[] debugColors = new PVector[] {
  new PVector(255, 0, 0), // red
  new PVector(0, 255, 0), // green
  new PVector(0, 0, 255), // blue
  new PVector(255, 255, 0), // yellow
  new PVector(0, 255, 255), // cyan
  new PVector(255, 0, 255) // magenta
};

PImage[] missingTextures;

void setup() {
  size(800, 800, P3D);
  camX = SALLE_W;
  camY = -SALLE_H;
  camZ = SALLE_D;
  noStroke();
  loadImages();
  initTexturesArrays();
  colorShader = loadShader("Lambert1DiffuseFrag.glsl", "Lambert1DiffuseVert.glsl");
  initShapes();
}

void initShapes() {
  //textureWrap(REPEAT);
  skybox = createSkyBox();
  salle = createSalle();
  debugShapeCam = createDebugShapeCam(50);
  debugZeroZero = createZeroZero(20);
}

void loadImages() {
  negx = loadImage("asset/sky_04_cubemap_2k/nx.png");
  posx = loadImage("asset/sky_04_cubemap_2k/px.png");
  negy = loadImage("asset/sky_04_cubemap_2k/ny.png");
  posy = loadImage("asset/sky_04_cubemap_2k/py.png");
  negz = loadImage("asset/sky_04_cubemap_2k/nz.png");
  posz = loadImage("asset/sky_04_cubemap_2k/pz.png");
  bottom = loadImage("asset/laminate_floor_02_diff_1k.jpg");
  wall = loadImage("asset/wall.jpg");
}

void initTexturesArrays() {
  missingTextures = new PImage[] {
    wall,
    wall,
    wall,
    wall,
    wall,
    wall
  };
}

void draw() {
  background(0, 0, 150);

  // shader(colorShader);
  // drawLight();

  movePositionCamera();
  moveCenterCamera();

  camera(
    camX, camY, camZ,
    centerX, centerY, centerZ,
    0, 1, 0);

  drawShape();
  drawDebug();
}

void drawShape() {
  textureWrap(REPEAT);
  pushMatrix();
  shape(skybox);
  translate(SALLE_W, -SALLE_H, SALLE_D);
  shape(salle);
  popMatrix();
}

boolean keyAction(char keyInput, boolean state, boolean value) {
  if (key == keyInput || key == Character.toUpperCase(keyInput)) {
    return value;
  }
  return state;
}

void mouseWheel(MouseEvent event) {
  if (event.getCount() > 0) {
    rayon += 20;
  } else {
    rayon -= 20;
  }
}


void keyPressed() {
  cameraKeyPressed();
  keyPressedDebug();
}

void keyReleased() {
  cameraKeyReleased();
}
