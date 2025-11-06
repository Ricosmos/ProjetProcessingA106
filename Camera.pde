

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

void bougerCamera() {
  // Calcul de la position cartésienne sur le
  // plan XZ :
  theta += (pmouseX - mouseX) / 100f % TWO_PI;
  phi += (mouseY - pmouseY) / 100f % TWO_PI;

  centerX = rayon * cos(phi) * sin(theta);
  centerY = rayon * sin(phi);
  centerZ = rayon * cos(phi) * cos(theta);
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

void cameraKeyReleased() {
  movingXPos = keyAction('z', movingXPos, false);
  movingXNeg = keyAction('s', movingXNeg, false);
  movingZPos = keyAction('q', movingZPos, false);
  movingZNeg = keyAction('d', movingZNeg, false);
  movingYPos = keyAction('a', movingYPos, false);
  movingYNeg = keyAction('e', movingYNeg, false);
}

void cameraKeyPressed() {
  movingXPos = keyAction('z', movingXPos, true);
  movingXNeg = keyAction('s', movingXNeg, true);
  movingZPos = keyAction('q', movingZPos, true);
  movingZNeg = keyAction('d', movingZNeg, true);
  movingYPos = keyAction('a', movingYPos, true);
  movingYNeg = keyAction('e', movingYNeg, true);
}