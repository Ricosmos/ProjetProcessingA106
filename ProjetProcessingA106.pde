float angle = 0f;
float s = 500 / 2.0;
PShader colorShader;
PImage noTexture, metal, vide;

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
  surface.setResizable(true);
  camX = SALLE_W;
  camY = -SALLE_H;
  camZ = SALLE_D;
  noStroke();
  loadImages();
  initTexturesArrays();
  initLights();
  colorShader = loadShader("Lambert1DiffuseFrag.glsl", "Lambert1DiffuseVert.glsl");
  initShapes();


  print("Utilisez les touches Z Q S D pour deplacer la camera vers l'avant, a gauche, vers l'arrière, a droite.\n");
  print("Deplacez la souris pour regarder autour.\n\n");
  print("Appuyez sur 't' pour ouvrir/fermer les bureaux");
  print("Appuyez sur 'i' pour afficher les informations de debogage.\n");
}

void initShapes() {
  skybox = createSkyBox();
  salle = createSalle();
  tableClosed = createTable(false);
  tableOpen = createTable(true);
  chaise = createChaise();
  ecranSpeechi = createEcran();
  debugShapeCam = createDebugShapeCam(10);
  debugZeroZero = createZeroZero(20);
  tableau = createTableau();
  tableau.translate(0, -HAUTEUR_TABLEAU, 0);
}

void loadImages() {
  loadSkyboxImages();
  loadTableImages();
  loadSalleImages();
  loadChaiseImages();
  loadTexturesecranSpeechi();
  loadTableauImages();
  loadPorteTextures();
  noTexture = loadImage("asset/default.jpg");
  metal = loadImage("asset/silver-metallic.jpg");
  vide = loadImage("asset/vide.png");
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
  skybox.rotateY(0.0001);
  shape(skybox);
  popMatrix();

  shader(colorShader);
  animateTable();
  drawShape();
  drawDebug();
}

void drawShape() {
  textureWrap(REPEAT);
  pushMatrix();

  translate(SALLE_W, -SALLE_H, SALLE_D);
  drawLight();

  pushMatrix();
  translate(0, SALLE_H, -SALLE_D);

  shape(tableau);

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
  shape(salle);

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
  keyPressedSalle();
  keyPressedTable();
}

void keyReleased() {
  cameraKeyReleased();
}

void drawRangees(float startX, float startZ, int count) {
  for (int i = 0; i < count; i++) {
    pushMatrix();
    translate(startX - PLANCHE_W - i * (PLANCHE_W * 2) - 0.1 *( i + 1), 0, startZ);
    if (supportCurrentHeight < 0) {
      shape(tableOpen);
    } else {
      shape(tableClosed);
    }
    shape(chaise);
    popMatrix();
  }
}
