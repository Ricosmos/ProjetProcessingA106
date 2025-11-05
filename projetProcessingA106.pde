final int MOVE_SPEED = 25;

float angle = 0f;
float s = 500 / 2.0;
PShape salle, skybox;
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

// Distance de la camera au sujet.
float rayon = 200;

// Angle de la camera avec le sujet sur le plan XZ.
float theta = 0;
float phi = 10;

// Position cartésienne de la camera
// calculée à partir du rayon et de l'angle.
float camX, camY, camZ = 0;

boolean movingXPos, movingXNeg, movingYPos, movingYNeg, movingZPos, movingZNeg = false;
float centerX, centerY, centerZ = 0;

float vitesseX = 0;
float vitesseY = 0;

PVector[] lightPos = {
  new PVector(700, -700, 700),
  new PVector(-700, 700, 700),
  new PVector(-700, 700, -700),
  new PVector(0, -700, 0)
};

PVector[] lightColor = {
  new PVector(255, 255, 255),
  new PVector(40, 100, 255),
  new PVector(255, 200, 55),
  new PVector(255, 0, 0)
};

void setup() {
  size(800, 800, P3D);
  noStroke();
  loadImages();
  initTexturesArrays();
  colorShader = loadShader("Lambert1DiffuseFrag.glsl", "Lambert1DiffuseVert.glsl");
  initShapes();
}

void initShapes() {
  textureWrap(REPEAT);
  skybox = createSkyBox();
  salle = createSalle();
  debugShapeCam = createDebugShapeCam(50);
}

void loadImages() {
  negx = loadImage("asset/sky_04_cubemap_2k/nx.png");
  posx = loadImage("asset/sky_04_cubemap_2k/px.png");
  negy = loadImage("asset/sky_04_cubemap_2k/ny.png");
  posy = loadImage("asset/sky_04_cubemap_2k/py.png");
  negz = loadImage("asset/sky_04_cubemap_2k/nz.png");
  posz = loadImage("asset/sky_04_cubemap_2k/pz.png");
  bottom = loadImage("asset/bottom.jpg");
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

  frameRate(1000);

  // shader(colorShader);
  // drawLight();

  movePositionCamera();
  bougerCamera();

  camera(
    camX, camY, camZ,
    centerX, centerY, centerZ,
    0, 1, 0);

  drawShape();
}

void drawShape() {
  shape(skybox);
  shape(salle);
  translate(centerX, centerY, centerZ);
  shape(debugShapeCam);
}

void drawLight() {
  ambientLight(10, 10, 10);

  for (int i=0; i<lightPos.length; i++) {
    lightSpecular(lightColor[i].x, lightColor[i].y, lightColor[i].z);
    pointLight(lightColor[i].x, lightColor[i].y, lightColor[i].z,
      lightPos[i].x, lightPos[i].y, lightPos[i].z);
  }

  fill(255);
  for (int i=0; i<lightPos.length; i++) {
    pushMatrix();
    noStroke();
    emissive(lightColor[i].x, lightColor[i].y, lightColor[i].z);
    translate(lightPos[i].x, lightPos[i].y, lightPos[i].z);
    // sphere(5);
    popMatrix();
  }
  emissive(0, 0, 0);
}

void bougerCamera() {
  // Calcul de la position cartésienne sur le
  // plan XZ :
  vitesseX += (pmouseX - mouseX) / 100f % TWO_PI;
  vitesseY += (mouseY - pmouseY) / 100f % TWO_PI;

  theta += vitesseX / 10f;
  phi += vitesseY / 10f;

  // print("theta: " + theta + " phi: " + phi + "\n");

  centerX = rayon * cos(phi) * sin(theta);
  centerY = rayon * sin(phi);
  centerZ = rayon * cos(phi) * cos(theta);

  vitesseX *= 0.9;
  vitesseY *= 0.9;
}

void movePositionCamera() {
  camX += moveCam(movingXPos, true);
  camX += moveCam(movingXNeg, false);
  camY += moveCam(movingYPos, true);
  camY += moveCam(movingYNeg, false);
  camZ += moveCam(movingZPos, true);
  camZ += moveCam(movingZNeg, false);
}

float moveCam(boolean isMoving, boolean positiveDirection) {
  if (!isMoving) {
    return 0;
  }

  if (positiveDirection) {
    return MOVE_SPEED;
  } else {
    return -MOVE_SPEED;
  }
}

void mouseWheel(MouseEvent event) {
  if (event.getCount() > 0) {
    rayon += 20;
  } else {
    rayon -= 20;
  }
}

void keyPressed() {
  movingXPos = keyAction('z', movingXPos, true);
  movingXNeg = keyAction('s', movingXNeg, true);
  movingZPos = keyAction('q', movingZPos, true);
  movingZNeg = keyAction('d', movingZNeg, true);
  movingYPos = keyAction('a', movingYPos, true);
  movingYNeg = keyAction('e', movingYNeg, true);
}

void keyReleased() {
  movingXPos = keyAction('z', movingXPos, false);
  movingXNeg = keyAction('s', movingXNeg, false);
  movingZPos = keyAction('q', movingZPos, false);
  movingZNeg = keyAction('d', movingZNeg, false);
  movingYPos = keyAction('a', movingYPos, false);
  movingYNeg = keyAction('e', movingYNeg, false);
}

boolean keyAction(char keyInput, boolean state, boolean value) {
  if (key == keyInput || key == Character.toUpperCase(keyInput)) {
    return value;
  }
  return state;
}
