PShape debugShapeCam, debugZeroZero;

PShape createDebugShapeCam(float size) {
  PShape debugShape = createCube(missingTextures, debugColors, false);

  debugShape.scale(size, size, size);

  return debugShape;
}

PShape createZeroZero(float size) {
  PVector[] originColors = new PVector[] {
    new PVector(255, 0, 0), // red
    new PVector(0, 255, 0), // green
    new PVector(0, 0, 255), // blue
    new PVector(255, 255, 255), // white
    new PVector(255, 255, 255), // white
    new PVector(255, 255, 255)  // white
  };

  PShape debugShape = createCube(missingTextures, originColors, false);

  debugShape.scale(size, size, size);

  return debugShape;
}

void velocityInformation() {
  pushMatrix();
  textSize(128);	
  fill(255);
  text("CamX: " + camX + " CamY: " + camY + " CamZ: " + camZ + "\n", mouseX, mouseY - 300, 0);
  text("CenterX: " + centerX + " CenterY: " + centerY + " CenterZ: " + centerZ + "\n", mouseX, mouseY - 450, 0);
  text("theta: " + theta + " phi: " + phi + "\n", mouseX, mouseY, 0);
  text("MOVE_X (1): " + MOVE_X_CAM.apply(1.0) + "\n", mouseX, mouseY + 150, 0);
  text("MOVE_Y (1): " + MOVE_Y_CAM.apply(1.0) + "\n", mouseX, mouseY + 300, 0);
  text("MOVE_Z (1): " + MOVE_Z_CAM.apply(1.0) + "\n", mouseX, mouseY + 450, 0);

  text("movingXPos: " + movingXPos + " movingXNeg: " + movingXNeg + "\n", -mouseX, mouseY + 600, 0);
  text("movingYPos: " + movingYPos + " movingYNeg: " + movingYNeg + "\n", -mouseX, mouseY + 750, 0);
  text("movingZPos: " + movingZPos + " movingZNeg: " + movingZNeg + "\n", -mouseX, mouseY + 900, 0);
  popMatrix();
}