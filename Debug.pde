PShape debugShapeCam;

PShape createDebugShapeCam(float size) {
  PShape debugShape = createCube(missingTextures, debugColors, false);

  debugShape.scale(size, size, size);

  return debugShape;
}