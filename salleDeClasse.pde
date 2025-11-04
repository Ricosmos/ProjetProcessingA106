float GOLDEN_RATIO = 1.6180339887;

float angle = 0f;
float c = 500 / 2.0;
PShape cube;
PShader colorShader;
PImage top, bottom, left, right, front, back;

// Distance de la camera au sujet.
float rayon = 800;

// Nombre de subdivision
int nDivision = 3;

// Angle de la camera avec le sujet sur le plan XZ.
float theta = 0; 
float phi = 10; 

// Position cartésienne de la camera
// calculée à partir du rayon et de l'angle.
float camX = 0;
float camY = 0;
float camZ = 0;

float vitesseX = 0;
float vitesseY = 0;

PVector[] lightPos = { 
  new PVector(700, -700, 700),
  new PVector(-700, 700, 700),
  new PVector(-700, 700, -700),
  new PVector(0, -700, 0)
};

PVector[] lightColor = {
  new PVector(255, 255, 255),
  new PVector(40, 100, 255),
  new PVector(255, 200, 55),
  new PVector(255, 0, 0)
};

void setup() {
	size(800, 800, P3D);
	noStroke();
	loadImages();
	colorShader = loadShader("Lambert1DiffuseFrag.glsl", "Lambert1DiffuseVert.glsl");
	cube = createCube();
}

void loadImages() {
	top = loadImage("asset/top.jpg");
	bottom = loadImage("asset/bottom.jpg");
	left = loadImage("asset/left.jpg");
	right = loadImage("asset/right.jpg");
	front = loadImage("asset/front.jpg");
	back = loadImage("asset/back.jpg");
}

void draw() {  
	background(0);

	frameRate(1000);

	// shader(colorShader);
  	// drawLight();

	bougerCamera();
		
	camera(
		camX, camY, camZ,
		0, 0, 0,
		0, 1, 0);
	
	shape(cube);
}

void drawLight() {
	ambientLight(10, 10, 10);
  
	for(int i=0; i<lightPos.length; i++) {
		lightSpecular(lightColor[i].x, lightColor[i].y, lightColor[i].z);
		pointLight(lightColor[i].x, lightColor[i].y, lightColor[i].z, 
			lightPos[i].x, lightPos[i].y, lightPos[i].z);
	}

	fill(255);
	for(int i=0; i<lightPos.length; i++) {
		pushMatrix();
			noStroke();        
			emissive(lightColor[i].x, lightColor[i].y, lightColor[i].z);
			translate(lightPos[i].x, lightPos[i].y, lightPos[i].z);
			// sphere(5);
		popMatrix();
	}
	emissive(0, 0, 0);
}

void bougerCamera() {
  // Calcul de la position cartésienne sur le
  // plan XZ :
  vitesseX += (pmouseX - mouseX) / 100f % TWO_PI;
  vitesseY += (mouseY - pmouseY) / 100f % TWO_PI;

  theta += vitesseX / 10f;
  phi += vitesseY / 10f;

  camX = rayon * cos(phi) * sin(theta);
  camY = rayon * sin(phi);
  camZ = rayon * cos(phi) * cos(theta);

  vitesseX *= 0.9;
  vitesseY *= 0.9;
}

void mouseWheel(MouseEvent event) {
	if (event.getCount() > 0) {
		rayon += 20;
	} else {
		rayon -= 20;
	}
}

PShape createCube() {
	PShape cube = createShape(GROUP);
	cube.addChild( createCubeFrontFace() );
	cube.addChild( createCubeBackFace() );
	cube.addChild( createCubeRightFace() );
	cube.addChild( createCubeLeftFace() );
	cube.addChild( createCubeBottomFace() );
	cube.addChild( createCubeTopFace() );

	return cube;
}

PShape createCubeInitFace() {
	PShape face = createShape();
	face.beginShape(QUAD);
		face.textureMode(NORMAL);
		face.shininess(200.0);
		face.emissive(0, 0, 0);
	face.endShape();

	return face;
}

PShape createCubeFrontFace() {
	PShape face = createCubeInitFace();
	face.beginShape(QUAD);
		face.texture(front);
		face.tint(255, 0, 0);
		face.vertex(-c, c, c, 0, 1);
		face.vertex( c, c, c, 1, 1);
		face.vertex( c,-c, c, 1, 0);
		face.vertex(-c,-c, c, 0, 0);
	face.endShape(CLOSE);

	return face;
}

PShape createCubeBackFace() {
	PShape face = createCubeInitFace();
	face.beginShape(QUAD);
		face.texture(back);
		face.tint(0, 0, 255);
		face.vertex( c, c,-c, 0, 1);
		face.vertex(-c, c,-c, 1, 1);
		face.vertex(-c,-c,-c, 1, 0);
		face.vertex( c,-c,-c, 0, 0);
	face.endShape(CLOSE);

	return face;
}

PShape createCubeRightFace() {
	PShape face = createCubeInitFace();
	face.beginShape(QUAD);
		face.texture(right);
		face.tint(0, 255, 255);
		face.vertex( c, c, c, 0, 1);
		face.vertex( c, c,-c, 1, 1);
		face.vertex( c,-c,-c, 1, 0);
		face.vertex( c,-c, c, 0, 0);
	face.endShape(CLOSE);

	return face;
}

PShape createCubeLeftFace() {
	PShape face = createCubeInitFace();
	face.beginShape(QUAD);
		face.texture(left);
		face.tint(255, 255, 0);
		face.vertex(-c, c,-c, 0, 1);
		face.vertex(-c, c, c, 1, 1);
		face.vertex(-c,-c, c, 1, 0);
		face.vertex(-c,-c,-c, 0, 0);
	face.endShape(CLOSE);

	return face;
}

PShape createCubeBottomFace() {
	PShape face = createCubeInitFace();
	face.beginShape(QUAD);
		face.texture(bottom);
		face.tint(100, 100, 100);
		face.vertex(-c, c, c, 0, 1);
		face.vertex( c, c, c, 1, 1);
		face.vertex( c, c,-c, 1, 0);
		face.vertex(-c, c,-c, 0, 0);
	face.endShape(CLOSE);

	return face;
}

PShape createCubeTopFace() {
	PShape face = createCubeInitFace();
	face.beginShape(QUAD);
		face.texture(top);
		face.tint(255, 255, 255);
		face.vertex(-c, -c,-c, 0, 1);
		face.vertex( c, -c,-c, 1, 1);
		face.vertex( c, -c, c, 1, 0);
		face.vertex(-c, -c, c, 0, 0);
	face.endShape(CLOSE);
 
	return face;
}




// boolean isStrokeEnabled = true;

void keyPressed() {
	// reload cube
	if (key == 'r' || key == 'R') {
		cube = createCube();
	}
}
