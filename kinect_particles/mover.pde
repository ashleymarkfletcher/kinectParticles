import java.util.Random;

class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  float noneTrackScale;
  float trackScale;
  private float tx;
  private float ty;
  float x;  
  float y;
  float colour;
  // maximum length of line
  float lengthRange;
  float edgePadding;
  Random r = new Random();

  //constructor
  Mover(float tSpeed, float tScale, float ntScale, float range, float pad) {

    //initial settings per mover
    location = new PVector(random(width), random(height));
    velocity = new PVector(0, 0);

    // initial movement params
    topspeed = tSpeed;
    noneTrackScale = ntScale;
    trackScale = tScale;
    lengthRange = range;
    edgePadding = pad;

    //start at a different point on the noise wave
    tx = round(r.nextInt(10000));
    ty =  round(r.nextInt(10000));
    
    println("TX = " + tx + "TY = " + ty);
    
    colour = random(1, 3);
  }

  void update(KJoint joint) {

    float desiredX;
    float desiredY;
    float maxSpeed;
    float scale;

    // null joint passed in == no skeleton
    if (joint == null) {

      // get x and y from noise wave = random position on the screen      
      desiredX = map(noise(tx), 0, 1, width*-4, width*5);
      desiredY = map(noise(ty), 0, 1, height*-4, height*5);
      
      //slow down the topspeed
      maxSpeed = topspeed*0.1;
      scale = noneTrackScale;
    } else {

      // use the joint passed in the find it's X and Y coordinates
      desiredX = joint.getX();
      desiredY = joint.getY();
      maxSpeed = topspeed;
      scale = trackScale;

      //if a joint isn't tracked/off screen, it has a postition of -infinity
      if (desiredX == Float.NEGATIVE_INFINITY || desiredY == Float.NEGATIVE_INFINITY) {

        desiredX = map(noise(tx), 0, 1, width*-4, width*5);
        desiredY = map(noise(ty), 0, 1, height*-4, height*5);
      }
    }
    
    // location to follow
    PVector desiredVector = new PVector(desiredX, desiredY);
    
    // Find vector pointing towards location
    PVector dir = PVector.sub(desiredVector, location);

    dir.normalize();     // Normalize
    dir.mult(scale);       // Scale 
    acceleration = dir;  // Set to acceleration

    // add separation
    //acceleration.add(separate(movers));

    // Motion 101!  Velocity changes by acceleration.  Location changes by velocity.
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);

    // move noise wave along to get next random number
    tx += 0.001;
    ty += 0.001;

    // just in case these get too high, might not be needed
    if (tx > 2100000000 ){
      tx = round(r.nextInt(10000));
      println("TX = " + tx);
    }
    if (ty > 2100000000 ) {
      ty = round(r.nextInt(10000));
      println("TY = " + ty);
    }
  }

  //draw the mover on screen
  void display() {

    // line colour
    stroke(49, 255, 183);

    // line weight
    //strokeWeight(map(noise(tx), 0, 1, -lengthRange, lengthRange));
    strokeWeight(3);

    // random x and y to use for line length and location based on noise
    // should be smoother than random above
    float randX = map(noise(tx), 0, 1, -lengthRange, lengthRange);
    float randY = map(noise(ty), 0, 1, -lengthRange, lengthRange);

    // draw from current location to the random x and y 
    line(location.x, location.y, location.x+randX, location.y+randY);

    // box instead of line
    //pushMatrix();
    //  translate(location.x,  location.y, 0);
    //  rotateX(radians(20));
    //  rotateY(radians(10));
    //  rotateZ(noise(tx));
    //  fill(49, 255, 183);
    //  noStroke();
    //  box(30);
    //popMatrix();
    
  }

  // if mover goes off the screen, bring it back
  void checkEdges() {

    //check width
    if (location.x > width + edgePadding) {
      location.x = 0 - edgePadding;
    } else if (location.x < 0 - edgePadding) {
      location.x = width + edgePadding;
    }

    //check height
    if (location.y > height + edgePadding) {
      location.y = 0 - edgePadding;
    } else if (location.y < 0 - edgePadding) {
      location.y = height + edgePadding;
    }
  }
}