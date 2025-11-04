float angle = 0f;
float s = 500 / 2.0;
PShape cube;
PShader colorShader;
PImage bottom;

// Distance de la camera au sujet.
float rayon = 800;

// Angle de la camera avec le sujet sur le plan XZ.
float theta = 0;
float phi = 10;

// Position cartésienne de la camera
// calculée à partir du rayon et de l'angle.
float camX = 0;
float camY = 0;
float camZ = 0;

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
  colorShader = loadShader("Lambert1DiffuseFrag.glsl", "Lambert1DiffuseVert.glsl");
  cube = createSalle();
}

void loadImages() {
  bottom = loadImage("asset/bottom.jpg");
}

void draw() {
  background(0, 0, 150);

  frameRate(1000);

  // shader(colorShader);
  // drawLight();

  bougerCamera();

  camera(
    camX, camY, camZ,
    0, 0, 0,
    0, 1, 0);

  shape(cube);
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

  camX = rayon * cos(phi) * sin(theta);
  camY = rayon * sin(phi);
  camZ = rayon * cos(phi) * cos(theta);

  vitesseX *= 0.9;
  vitesseY *= 0.9;
}

void mouseWheel(MouseEvent event) {
  if (event.getCount() > 0) {
    rayon += 20;
  } else {
    rayon -= 20;
  }
}

// boolean isStrokeEnabled = true;

void keyPressed() {
  // reload cube
  if (key == 'r' || key == 'R') {
    cube = createCube();
  }
}
