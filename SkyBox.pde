PShape createSkyBox() {
	PImage[] textures = new PImage[] {
		posz,
		negz,
		posx,
		negx,
		negy,
		posy
	};

	PShape skyBox = createCube(textures, defaultColors);

	skyBox.scale(3000, 3000, 3000);

	return skyBox;
}
