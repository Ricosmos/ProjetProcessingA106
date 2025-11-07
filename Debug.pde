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