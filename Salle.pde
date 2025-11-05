PShape createSalle() {
	PImage[] textures = new PImage[] {
		wall,
		wall,
		wall,
		wall,
		bottom,
		bottom
	};

	PShape salle = createCube(textures, defaultColors, true);

	salle.scale(600, 280, 980);

	return salle;
}