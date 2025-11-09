PShape debugShapeCam, debugZeroZero;

boolean debugMode = false;

PShape createDebugShapeCam(float size) {
  PShape debugShape = createCubeMagique(missingTextures, debugColors, false);

  debugShape.scale(size, size, size);

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

  PShape debugShape = createCubeMagique(missingTextures, originColors, false);

  debugShape.scale(size, size, size);

  return debugShape;
}

void velocityInformation() {
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
}

void drawDebug() {
  if (debugMode) {
    shape(debugZeroZero);
    pushMatrix();
    translate(centerX, centerY, centerZ);
    shape(debugShapeCam);
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
}