import java.util.function.Function;

final float MOVE_SPEED = 10.0;

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
  float moveX = moveCam(movingXPos, true);
  moveX += moveCam(movingXNeg, false);
  float moveY = moveCam(movingYPos, true);
  moveY += moveCam(movingYNeg, false);
  float moveZ = moveCam(movingZPos, true);
  moveZ += moveCam(movingZNeg, false);

  text("moveX + moveZ: " + (moveX + moveZ) + "\n", mouseX, mouseY - 600);

  moveX = (moveX + moveZ) * MOVE_X_CAM.apply(1.0) ;
  moveZ = (moveZ + moveX) * MOVE_Z_CAM.apply(1.0) ;

	text("moveX: " + moveX + " moveY: " + moveY + " moveZ: " + moveZ + "\n", mouseX, mouseY - 150);

  camX += moveX;
  camY += moveY;
  camZ += moveZ;
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
  movingXNeg = keyAction('q', movingXNeg, false);
  movingZNeg = keyAction('s', movingZNeg, false);
  movingXPos = keyAction('d', movingXPos, false);
  movingYPos = keyAction('a', movingYPos, false);
  movingYNeg = keyAction('e', movingYNeg, false);
}

void cameraKeyPressed() {
  movingZPos = keyAction('z', movingZPos, true);
  movingXNeg = keyAction('q', movingXNeg, true);
  movingZNeg = keyAction('s', movingZNeg, true);
  movingXPos = keyAction('d', movingXPos, true);
  movingYPos = keyAction('a', movingYPos, true);
  movingYNeg = keyAction('e', movingYNeg, true);
}
