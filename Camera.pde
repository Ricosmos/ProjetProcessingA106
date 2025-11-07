import java.util.function.Function;

float MOVE_SPEED = 25.0;

// Distance de la camera au sujet.
float rayon = 300;

// Angle de la camera avec le sujet sur le plan XZ.
float theta = 0;
float phi = 10;

// Position cartésienne de la camera
// calculée à partir du rayon et de l'angle.
float camX, camY, camZ = 0;

boolean movingXPos, movingXNeg, movingYPos, movingYNeg, movingZPos, movingZNeg = false;
float centerX, centerY, centerZ = 0;

Function<Float, Float> MOVE_X_CAM = (Float a) -> a * cos(phi) * sin(theta);
Function<Float, Float> MOVE_Y_CAM = (Float a) -> a * sin(phi);
Function<Float, Float> MOVE_Z_CAM = (Float a) -> a * cos(phi) * cos(theta);

void moveCenterCamera() {
  theta += (pmouseX - mouseX) / 100f % TWO_PI;
  phi += (mouseY - pmouseY) / 100f % TWO_PI;

  centerX = camX + MOVE_X_CAM.apply(rayon);
  centerY = camY + MOVE_Y_CAM.apply(rayon);
  centerZ = camZ + MOVE_Z_CAM.apply(rayon);
}

void movePositionCamera() {
  float inputX = moveCam(movingXPos, true) + moveCam(movingXNeg, false);
  float moveY = moveCam(movingYPos, true) + moveCam(movingYNeg, false);
  float inputZ = moveCam(movingZPos, true) + moveCam(movingZNeg, false);

  float forwardX = MOVE_X_CAM.apply(1.0);
  float forwardZ = MOVE_Z_CAM.apply(1.0);

  float rightX = cos(theta);
  float rightZ = -sin(theta);

  float dx = inputX * rightX + inputZ * forwardX;
  float dz = inputX * rightZ + inputZ * forwardZ;

  camX += dx;
  camY += moveY;
  camZ += dz;
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
  movingZPos = keyAction('z', movingZPos, false);
  movingXPos = keyAction('q', movingXPos, false);
  movingZNeg = keyAction('s', movingZNeg, false);
  movingXNeg = keyAction('d', movingXNeg, false);
  movingYPos = keyAction('a', movingYPos, false);
  movingYNeg = keyAction('e', movingYNeg, false);
}

void cameraKeyPressed() {
  movingZPos = keyAction('z', movingZPos, true);
  movingXPos = keyAction('q', movingXPos, true);
  movingZNeg = keyAction('s', movingZNeg, true);
  movingXNeg = keyAction('d', movingXNeg, true);
  movingYPos = keyAction('a', movingYPos, true);
  movingYNeg = keyAction('e', movingYNeg, true);
}
