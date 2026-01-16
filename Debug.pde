PShape debugShapeCam, debugZeroZero;

boolean debugMode = false;
boolean flashlightDebug = false;

PShape createDebugShapeCam(float size) {
  PShape debugShape = new CubeMagique(missingTextures, debugColors).build();

  debugShape.scale(size);

  return debugShape;
}

PShape createZeroZero(float size) {
  PVector[] originColors = new PVector[] {
    new PVector(255, 0, 0), // red
    new PVector(0, 255, 0), // green
    new PVector(0, 0, 255), // blue
    new PVector(255, 255, 0), // yellow
    new PVector(255, 255, 255), // white
    new PVector(255, 255, 255)  // white
  };

  PShape debugShape = new CubeMagique(missingTextures, originColors).build();

  debugShape.scale(size);

  return debugShape;
}

void velocityInformation() {
  pushMatrix();
  hint(DISABLE_DEPTH_TEST);
  camera();
  textSize(16);
  fill(255);
  text("CamX: " + camX + " CamY: " + camY + " CamZ: " + camZ, 10, 20);
  text("CenterX: " + centerX + " CenterY: " + centerY + " CenterZ: " + centerZ, 10, 40);
  text("theta: " + theta + " phi: " + phi, 10, 60);
  text("MOVE_X (1): " + MOVE_X_CAM.apply(1.0), 10, 80);
  text("MOVE_Y (1): " + MOVE_Y_CAM.apply(1.0), 10, 100);
  text("MOVE_Z (1): " + MOVE_Z_CAM.apply(1.0), 10, 120);

  // text("movingXPos: " + movingXPos + " movingXNeg: " + movingXNeg, 10, 140);
  // text("movingYPos: " + movingYPos + " movingYNeg: " + movingYNeg, 10, 160);
  // text("movingZPos: " + movingZPos + " movingZNeg: " + movingZNeg, 10, 180);

  hint(ENABLE_DEPTH_TEST);
  popMatrix();
}

void drawFlashlightDebug() {
  if (flashlightDebug) {
    lightSpecular(255, 255, 255);
    pointLight(100, 100, 100, camX, camY, camZ);
  }
}

void drawDebug() {
  if (debugMode) {
    shape(debugZeroZero);

    for (int i=0; i<lightPos.length; i++) {
      pushMatrix();
      translate(SALLE_W, -SALLE_H, SALLE_D);
      translate(lightPos[i].x, lightPos[i].y, lightPos[i].z);
      shape(debugShapeCam);
      popMatrix();
    }

    pushMatrix();
    translate(centerX, centerY, centerZ);
    // shape(debugShapeCam);
    popMatrix();
    velocityInformation();
  }
}

void keyDebugMode() {
  debugMode = !debugMode;
}

void keyPressedDebug() {
  if (key == 'i' || key == 'I') {
    keyDebugMode();
    print("Debug mode: " + debugMode);
  }

  if (key == 'f' || key == 'F') {
    flashlightDebug = !flashlightDebug;
    print("Flashlight debug: " + flashlightDebug);
  }
}
