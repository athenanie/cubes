colorMode(RGB,100);
int n;
int oldDimension;
float length;
color left = color(30);
color right = color(55);
color top = color(80);
int[] height = new int[1000];
int delta;
int i;
int j;
int k;
float r3 = 1.732;

void setup() {
	size(500,500);
	stroke(100);
}

void draw() {
	background(95);
	n = round(mouseX/25)+2;
	length = 231/n;
	if (n != oldDimension) {
		recalculate();
	}
	
	drawCubes();
	oldDimension = n;
}

void recalculate() {
	for (i=0;i<1000;i++) {
		height[i]=0;
	}
	
	height[n*n-1]=round(random(0,2));
	k=1;
	for (i=(n*n-n-1);i>0;i=i-n) {
		k++;
		for (j=0;j<k;j++) {
			delta = floor(pow(1.1,random(-30,10)));
			if (max(getLeft(i+(n-1)*j),getRight(i+(n-1)*j))+delta > n) {
				height[i+(n-1)*j] = n;
			} else {
				height[i+(n-1)*j] = max(getLeft(i+(n-1)*j),getRight(i+(n-1)*j))+delta;
			}
		}
	}
	
	k=n;
	for (i=n-2;i>=0;i--) {
		k--;
		for (j=0;j<k;j++) {
			delta = floor(pow(1.1,random(-30,10)));
			if (max(getLeft(i+(n-1)*j),getRight(i+(n-1)*j))+delta > n) {
				height[i+(n-1)*j] = n;
			} else {
				height[i+(n-1)*j] = max(getLeft(i+(n-1)*j),getRight(i+(n-1)*j))+delta;
			}
		}
	}
}

void drawCubes() {
	fill(right);
	quad(250,250,50,365,50,135,250,19);
	fill(left);
	quad(250,250,450,365,450,135,250,19);
	fill(top);
	quad(250,250,50,365,250,481,450,365);
	
	//vertical: left, right
	for (i=1;i<n;i++) {
		line(250-i/n*200,19+i/n*116,250-i/n*200,250+i/n*116);
	}
	for (i=1;i<n;i++) {
		line(250+i/n*200,19+i/n*116,250+i/n*200,250+i/n*116);
	}
	
	//the rest of them: left, right, left-to-right, right-to-left
	for (i=1;i<n;i++) {
		line(250,250-i/n*231,50,365-i/n*231);
	}
	for (i=1;i<n;i++) {
		line(250,250-i/n*231,450,365-i/n*231);
	}
	for (i=1;i<n;i++) {
		line(250-i/n*200,250+i/n*116,450-i/n*200,365+i/n*116);
	}
	for (i=1;i<n;i++) {
		line(250+i/n*200,250+i/n*116,50+i/n*200,365+i/n*116);
	}
	
	for (i=0;i<(n*n);i++) {
		for (j=1;j<height[i]+1;j++) {
			cube(i,j);
		}
	}
}

void cube(int place, int height) {
	whydidihavetodothis(250+(place%n)*length/2*r3-floor(place/n)*length/2*r3, 250+(place%n)*length/2+floor(place/n)*length/2-(height-1)*length);
}

void whydidihavetodothis(float x, float y) {
	fill(left);
	quad(x,y,x,y+length,x-length/2*r3,y+length/2,x-length/2*r3,y-length/2);
	fill(right);
	quad(x,y,x,y+length,x+length/2*r3,y+length/2,x+length/2*r3,y-length/2);
	fill(top);
	quad(x,y,x-length/2*r3,y-length/2,x,y-length,x+length/2*r3,y-length/2);
}

int max(int n1, int n2) {
	if (n1>n2) {
		return n1;
	} else {
		return n2;
	}
}

int getLeft(int place) {
	if (place > n*n-n-1) {
		return 0;
	} else {
		return height[place+n];
	}
}

int getRight(int place) {
	if ((place+1)%n == 0) {
		return 0;
	} else {
		return height[place+1];
	}
}