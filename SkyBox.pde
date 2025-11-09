PShape skybox;

PShape createSkyBox() {
	PImage[] textures = new PImage[] {
		posz,
		negz,
		posx,
		negx,
		negy,
		posy
	};

	PShape skyBox = createCubeMagique(textures, defaultColors);

	skyBox.scale(3000, 3000, 3000);

	return skyBox;
}
