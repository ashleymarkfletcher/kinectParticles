import KinectPV2.KJoint;
import KinectPV2.*;

KinectPV2 kinect;

//skeleton variables
int numBones = bones.length;
//int numJoints = 26;
static int numParticles = 300;

// global particle vars
float topspeed = 15;
float noneTrackScale = 1;
float trackScale = 3;
float lengthRange = 30;
float edgePadding = 100;

// toggle the help text
boolean showHelp = false;

// declare empty array to hold movers
Mover[][] movers;

// background
PImage back;

void setup() {
  
  //setup the screen/application size
  size(1280, 720, P3D);
  
  //set sketch to fullscreen using the P3D renderer
  //fullScreen(P3D);
  
  //intitialise the particles
  setupParticles();
  
  //load the background
  back = loadImage("background.jpg");
  
  //create new kinect object
  kinect = new KinectPV2(this);

  //eneable different maps and images
  kinect.enableSkeletonColorMap(true);
  kinect.enableColorImg(true);
  //kinect.enableDepthMaskImg(true);
  kinect.enableBodyTrackImg(true);  

  //start the kinect tracking
  kinect.init();  
    
}

void draw() {
  
  //set background to black
  background(255);
  
  // background to image
  image(back, 0, 0, 1920, 1080);
  
  //background images straight from kinect
  //image(kinect.getBodyTrackImage(), 0, 0, width, height);
  //image(kinect.getColorImage(), 0, 0, width, height);

  //array of skeletons
  ArrayList<KSkeleton> skeletonArray = kinect.getSkeletonColorMap();

  //individual JOINTS from each skeleton
  for (int i = 0; i < skeletonArray.size(); i++) {
    
    //get the skeleton
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    
    //check if it is being tracked and the first person
    if (skeleton.isTracked() && i == 0) {
 
      //get all the joints
      KJoint[] joints = skeleton.getJoints();
      
      // loop through the bones and update movers to each
      for(int x = 0; x < bones.length; x++) {
        updateMoverToJoints(bones[x], movers[x], joints);
      }      
    }    
  }
  
  //if there is no skeleton
  if (skeletonArray.size() == 0) {
    
    //send movers to random location
    updateMoversToRandom();
    
    // stops the Z plane being rendered, known hack for 2D on top of 3D
    //hint(DISABLE_DEPTH_TEST);
    
  }

  // show the help text if toggled
  if (showHelp) showHelpDisplay();
}

// function calls the update of a mover and gives it a random choice between two joints
// this creates the bone effect
void updateMoverToJoints(int[] bone, Mover[] JointMovers, KJoint[] joints) {
  
  int limit = (bone.length > 2) ? bone[2] : numParticles;
  
  //loop through the movers passed in 
  for (int a = 0; a < limit; a++) {
    
    //random number between 1 and 10
    int num = int(random(1, 10));
    
    //check if random number is even. set the the joint
    int joint = (num%2 == 0) ? bone[0] : bone[1];
    
    //update and display the movers
    JointMovers[a].update(joints[joint]);
    //JointMovers[a].checkEdges();
    JointMovers[a].display(); 
  }
}

void updateMoversToRandom(){
  // loop through bones
  for (int x = 0; x < bones.length; x++) {
    
    // if there has been a particle limit set on a bone
    int limit = (bones[x].length > 2) ? bones[x][2] : numParticles;
  
    // loop through movers
    for (int a = 0; a < limit; a++) {
      
      // send null to show no joint available, mover will pick a random direction
      movers[x][a].update(null);
      movers[x][a].checkEdges();
      movers[x][a].display(); 
    }
  }
}

// initialises all the particles
void setupParticles() {
  
  // set the amount of particles
  movers = new Mover[numBones][numParticles];
  
  // Initializing all the particles
  for (int i = 0; i <numBones; i++) {    
     
    // if there has been a particle limit set on a bone
    int limit = (bones[i].length > 2) ? bones[i][2] : numParticles;
    
    for (int a = 0; a < limit; a++) {
      
      // for each particle pass in it's params
      movers[i][a] = new Mover(topspeed, trackScale, noneTrackScale, lengthRange, edgePadding); 
    }
  }
}