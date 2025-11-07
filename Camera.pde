import java.util.function.Function;

final float MOVE_SPEED = 50.0;

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

void bougerCamera() {
  // Calcul de la position cartésienne sur le
  // plan XZ :
  theta += (pmouseX - mouseX) / 100f % TWO_PI;
  phi += (mouseY - pmouseY) / 100f % TWO_PI;

  centerX = camX + MOVE_X_CAM.apply(rayon);
  centerY = camY + MOVE_Y_CAM.apply(rayon);
  centerZ = camZ + MOVE_Z_CAM.apply(rayon);
}

void movePositionCamera() {
  float moveX = moveCam(movingXPos, true, MOVE_X_CAM);
  moveX += moveCam(movingXNeg, false, MOVE_X_CAM);
  float moveY = moveCam(movingYPos, true, MOVE_Y_CAM);
  moveY += moveCam(movingYNeg, false, MOVE_Y_CAM);
  float moveZ = moveCam(movingZPos, true, MOVE_Z_CAM);
  moveZ += moveCam(movingZNeg, false, MOVE_Z_CAM);

  //   centerX = moveX;
  //   centerY = moveY;
  //   centerZ = moveZ;
	print("moveX: " + moveX + " moveY: " + moveY + " moveZ: " + moveZ + "\n");

  camX += moveX;
  camY += moveY;
  camZ += moveZ;
}

float moveCam(boolean isMoving, boolean positiveDirection, Function<Float, Float> moveFunction) {
  if (!isMoving) {
    return 0;
  }

  if (positiveDirection) {
    return moveFunction.apply(MOVE_SPEED);
  } else {
    return -moveFunction.apply(MOVE_SPEED);
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
