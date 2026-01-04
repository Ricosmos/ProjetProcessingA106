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
    popMatrix();
  }
  emissive(0, 0, 0);
}