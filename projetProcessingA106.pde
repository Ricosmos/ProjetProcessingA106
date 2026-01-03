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
  colorShader = loadShader("Lambert1DiffuseFrag.glsl", "Lambert1DiffuseVert.glsl");
  initShapes();
}

void initShapes() {
  //textureWrap(REPEAT);
  skybox = createSkyBox();
  salle = createSalle();
  table = createTable();
  chaise = createChaise();
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
  translate(0, SALLE_H, 0);
  shape(table);
  shape(chaise);
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
