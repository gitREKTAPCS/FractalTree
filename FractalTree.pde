Snowflake[] snowSwag = new Snowflake[100];
private double fractionLength = .8; 
private int smallestBranch = 1; 
private double branchAngle = .4; 
private color randomColor = color((int)(Math.random()*255),(int)(Math.random()*255),(int)(Math.random()*255)); 

public void setup() 
{   
	size(640,480); 
	for(int j=0; j<snowSwag.length; j++){
  		snowSwag[j] = new Snowflake();
	}    
} 

public void draw() 
{   
	background(0);
	stroke(randomColor);   
	strokeWeight(1.5);
	line(320,480,320,380);   
	drawBranches(320,380,100,3*Math.PI/2);

	noStroke();
	for(int x=0; x<snowSwag.length; x++){
  		snowSwag[x].lookDown();
  		snowSwag[x].move();
  		snowSwag[x].wrap();
  		snowSwag[x].show();
  		
	}
} 

public void mouseClicked(){
	
		for(int x=0; x<snowSwag.length; x++){
  			if(snowSwag[x].isMoving==false){
  				if(snowSwag[x].x < 320){
  					snowSwag[x].x-=10;
  					snowSwag[x].y+=10;
  				}
  				if(snowSwag[x].x >= 320){
  					snowSwag[x].x+=10;
  					snowSwag[x].y+=10;
  				}
  				
		}
	}
	
}

public void drawBranches(int x,int y, double branchLength, double angle) 
{   

	double angle1 = angle + branchAngle;
	double angle2 = angle - branchAngle;

	branchLength*=fractionLength;

	int endX1 = (int)(branchLength*Math.cos(angle1) + x);
	int endY1 = (int)(branchLength*Math.sin(angle1) + y);
	int endX2 = (int)(branchLength*Math.cos(angle2) + x);
	int endY2 = (int)(branchLength*Math.sin(angle2) + y);

	strokeWeight(1.5);
	line(x,y,endX1,endY1);
	line(x,y,endX2, endY2);

	if(branchLength > smallestBranch){
		drawBranches(endX1,endY1,branchLength*fractionLength,angle1);
		drawBranches(endX2,endY2,branchLength*fractionLength,angle2);
	}
} 


class Snowflake
{
  //class member variable declarations
  int x, y;
  boolean isMoving;

  public Snowflake()
  {
    x = (int)(Math.random()*640);
    y = (int)(Math.random()*480);
    isMoving = true;
  }

  public void show()
  {
    noStroke();
    fill(255);
    ellipse(x, y, 7, 7);
  }

  public void lookDown()
  {
    if(y<=480 && y>=0 && (get(x, y+5) != color(0))){
      isMoving=false;
    }else{
      isMoving=true;
    }

  }

  public void move()
  {
    if(isMoving==true){
      y++;
    }
  }

  public void wrap()
  {
    if(y>=475){
      y = 0;
      x = (int)(Math.random()*640);
    }
  }
}