int n;
int oldDimension;
float length;

// these are now assigned in setup()
color LEFT;
color RIGHT;
color TOP;

int[] heights = new int[1000];
int delta;
float r3 = 1.732;

void setup() {
	size(500,500);
  colorMode(RGB,100);
  LEFT = color(30);
  RIGHT = color(55);
  TOP = color(80);
	stroke(100);
}

void draw() {
	background(90);
	n = round(mouseX/25)+2;
	length = 231.0/n;
	if (n != oldDimension) {
		recalculate();
	}
	
	drawCubes();
	oldDimension = int(n);
}

void recalculate() {
	for (int i=0;i<1000;i++) {
		heights[i]=0;
	}
	
	heights[n*n-1]=round(random(0,2));
	int k=1;
	for (int i=(n*n-n-1);i>0;i=i-n) {
		k++;
		for (int j=0;j<k;j++) {
			delta = floor(pow(1.1,random(-30,10)));
			if (max(getLeft(i+(n-1)*j),getRight(i+(n-1)*j))+delta > n) {
				heights[i+(n-1)*j] = n;
			} else {
				heights[i+(n-1)*j] = max(getLeft(i+(n-1)*j),getRight(i+(n-1)*j))+delta;
			}
		}
	}
	
	k=n;
	for (int i=n-2;i>=0;i--) {
		k--;
		for (int j=0;j<k;j++) {
			delta = floor(pow(1.1,random(-30,10)));
			if (max(getLeft(i+(n-1)*j),getRight(i+(n-1)*j))+delta > n) {
				heights[i+(n-1)*j] = n;
			} else {
				heights[i+(n-1)*j] = max(getLeft(i+(n-1)*j),getRight(i+(n-1)*j))+delta;
			}
		}
	}
}

void drawCubes() {
	fill(RIGHT);
	quad(250,250,50,365,50,135,250,19);
	fill(LEFT);
	quad(250,250,450,365,450,135,250,19);
	fill(TOP);
	quad(250,250,50,365,250,481,450,365);
	
	//vertical: LEFT, RIGHT
	for (float i=1;i<n;i++) {
		line(250-i/n*200,19+i/n*116,250-i/n*200,250+i/n*116);
	}
	for (float i=1;i<n;i++) {
		line(250+i/n*200,19+i/n*116,250+i/n*200,250+i/n*116);
	}
	
	//the rest of them: LEFT, RIGHT, LEFT-to-RIGHT, RIGHT-to-LEFT
	for (float i=1;i<n;i++) {
		line(250,250-i/n*231,50,365-i/n*231);
	}
	for (float i=1;i<n;i++) {
		line(250,250-i/n*231,450,365-i/n*231);
	}
	for (float i=1;i<n;i++) {
		line(250-i/n*200,250+i/n*116,450-i/n*200,365+i/n*116);
	}
	for (float i=1;i<n;i++) {
		line(250+i/n*200,250+i/n*116,50+i/n*200,365+i/n*116);
	}
	
	for (int i=0;i<(n*n);i++) {
		for (int j=1;j<heights[i]+1;j++) {
			cube(i,j);
		}
	}
}

void cube(int place, int heights) {
	whydidihavetodothis(250+(place%n)*length/2*r3-floor(place/n)*length/2*r3, 250+(place%n)*length/2+floor(place/n)*length/2-(heights-1)*length);
}

void whydidihavetodothis(float x, float y) {
	fill(LEFT);
	quad(x,y,x,y+length,x-length/2*r3,y+length/2,x-length/2*r3,y-length/2);
	fill(RIGHT);
	quad(x,y,x,y+length,x+length/2*r3,y+length/2,x+length/2*r3,y-length/2);
	fill(TOP);
	quad(x,y,x-length/2*r3,y-length/2,x,y-length,x+length/2*r3,y-length/2);
}

int getLeft(int place) {
	if (place > n*n-n-1) {
		return 0;
	} else {
		return heights[place+n];
	}
}

int getRight(int place) {
	if ((place+1)%n == 0) {
		return 0;
	} else {
		return heights[place+1];
	}
}
