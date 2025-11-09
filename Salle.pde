final int SALLE_W = 600;
final int SALLE_H = 280;
final int SALLE_D = 980;

PShape salle;
PShape murAvant, murArriere, murGauche, murDroit, plafond, sol;

PShape createSalle() {
	PImage[] textures = new PImage[] {
		wall,
		wall,
		wall,
		wall,
		bottom,
		bottom
	};

	PShape salle = createCubeMagique(textures, defaultColors, true, 4);

	salle.scale(SALLE_W, SALLE_H, SALLE_D);

	return salle;
}