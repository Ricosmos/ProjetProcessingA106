PVector[] lightPos;
PVector[] lightColor;

PShape light;

void initLights() {
  int LIGHT_ROOF_Y = -SALLE_H + 100;

  lightPos = new PVector[] {
    new PVector(SALLE_W/3, LIGHT_ROOF_Y, SALLE_D/2),
    new PVector(-SALLE_W/3, LIGHT_ROOF_Y, SALLE_D/2),
    new PVector(SALLE_W/3, LIGHT_ROOF_Y, 0),
    new PVector(-SALLE_W/3, LIGHT_ROOF_Y, 0),
    new PVector(-SALLE_W/3, LIGHT_ROOF_Y, -SALLE_D/2),
    new PVector(SALLE_W/3, LIGHT_ROOF_Y, -SALLE_D/2),
    new PVector(-2000, -250, 200) // Soleil
  };

  lightColor = new PVector[] {
    new PVector(255, 241, 224).mult(0.2),
    new PVector(255, 241, 224).mult(0.2),
    new PVector(255, 241, 224).mult(0.2),
    new PVector(255, 241, 224).mult(0.2),
    new PVector(255, 241, 224).mult(0.2),
    new PVector(255, 241, 224).mult(0.2),
    new PVector(255, 147, 41).mult(0.5),
  };

  light = createLightShape();
}

void drawLight() {
  ambientLight(15, 15, 15);
  for (int i=0; i<lightPos.length; i++) {
    pushMatrix();
    lightSpecular(lightColor[i].x, lightColor[i].y, lightColor[i].z);
    pointLight(lightColor[i].x, lightColor[i].y, lightColor[i].z,
      lightPos[i].x, lightPos[i].y, lightPos[i].z);

    if (i == lightPos.length - 1) { // Soleil
      popMatrix();
      continue;
    }

    translate(lightPos[i].x, lightPos[i].y - 100, lightPos[i].z);
    shape(light);

    popMatrix();
  }
}

PShape createLightShape() {
  PShape light = new CubeMagique(missingTextures, defaultColors).withEmissive(255, 255, 255).build();
  light.scale(20, 5, 50);

  return light;
}
