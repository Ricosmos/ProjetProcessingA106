PShape createSalle() {
	PImage[] textures = new PImage[] {
		bottom,
		bottom,
		bottom,
		bottom,
		bottom,
		bottom
	};

	PShape salle = createCube(textures, defaultColors, true);

	salle.scale(600, 280, 980);

	return salle;
}