float angle = 0f;
float s = 500 / 2.0;
PShader colorShader;
PImage noTexture, metal;

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
  initLights();
  colorShader = loadShader("Lambert1DiffuseFrag.glsl", "Lambert1DiffuseVert.glsl");
  initShapes();

  print("Press 'i' to toggle debug info.\n");
}

void initShapes() {
  //textureWrap(REPEAT);
  skybox = createSkyBox();
  salle = createSalle();
  table = createTable();
  chaise = createChaise();
  ecranSpeechi = createEcran();
  debugShapeCam = createDebugShapeCam(10);
  debugZeroZero = createZeroZero(20);
}

void loadImages() {
  loadSkyboxImages();
  loadTableImages();
  loadSalleImages();
  loadChaiseImages();
  noTexture = loadImage("asset/default.jpg");
  metal = loadImage("asset/silver-metallic.jpg");
}

void initTexturesArrays() {
  missingTextures = new PImage[] {
    noTexture,
    noTexture,
    noTexture,
    noTexture,
    noTexture,
    noTexture
  };
}

void draw() {
  background(0, 0, 150);

  movePositionCamera();
  moveCenterCamera();
  camera(
    camX, camY, camZ,
    centerX, centerY, centerZ,
    0, 1, 0);

  resetShader();
  pushMatrix();
  shape(skybox);
  popMatrix();

  shader(colorShader);
  drawShape();
  drawDebug();
}

void drawShape() {
  textureWrap(REPEAT);
  pushMatrix();

  translate(SALLE_W, -SALLE_H, SALLE_D);
  drawLight();

  shape(salle);
  translate(0, SALLE_H, -SALLE_D);

  drawRangees(SALLE_W, 200, 4);
  drawRangees(SALLE_W, 350, 6);
  drawRangees(SALLE_W, 500, 6);
  drawRangees(SALLE_W, 650, 5);
  drawRangees(SALLE_W, 800, 3);

  pushMatrix();
  translate(-SALLE_W / 4.0 * 2.5, 0, 110);
  rotateY(PI / 4);
  shape(ecranSpeechi);
  popMatrix();

  popMatrix();
}

boolean keyAction(char keyInput, boolean state, boolean value) {
  if (key == keyInput || key == Character.toUpperCase(keyInput)) {
    return value;
  }
  return state;
}

void keyPressed() {
  cameraKeyPressed();
  keyPressedDebug();
}

void keyReleased() {
  cameraKeyReleased();
}

void drawRangees(float startX, float startZ, int count) {
  for (int i = 0; i < count; i++) {
    pushMatrix();
    translate(startX - PLANCHE_W - i * (PLANCHE_W * 2), 0, startZ);
    shape(table);
    shape(chaise);
    popMatrix();
  }
}
