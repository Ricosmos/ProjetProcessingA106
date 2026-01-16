PVector[] lightPos;
PVector[] lightColor;

void initLights() {
  lightPos = new PVector[] {
    new PVector(SALLE_W/3, -SALLE_H - 20, SALLE_D/3),
    new PVector(-SALLE_W/3, -SALLE_H, SALLE_D/3),
    new PVector(-SALLE_W/3, -SALLE_H, -SALLE_D/3),
    new PVector(SALLE_W/3, -SALLE_H, -SALLE_D/3)
  };

  lightColor = new PVector[] {
    new PVector(255, 241, 224).mult(0.3),
    new PVector(255, 241, 224).mult(0.3),
    new PVector(255, 241, 224).mult(0.3),
    new PVector(255, 241, 224).mult(0.3),
  };
}

void drawLight() {
  ambientLight(15, 15, 15);
  for (int i=0; i<lightPos.length; i++) {
    lightSpecular(lightColor[i].x, lightColor[i].y, lightColor[i].z);
    pointLight(lightColor[i].x, lightColor[i].y, lightColor[i].z,
      lightPos[i].x, lightPos[i].y, lightPos[i].z);
  }
}
