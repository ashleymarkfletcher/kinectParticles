static int HEAD = 1;
static int NECK = 2;
static int SPINE_MID = 3;
static int SPINE_BASE = 4;
static int SHOULDER_RIGHT = 5;
static int SHOULDER_LEFT = 6;
static int HIP_RIGHT = 7;
static int HIP_LEFT = 8;
static int UPPER_ARM_RIGHT = 9;
static int LOWER_ARM_RIGHT = 10;
static int WRIST_RIGHT = 11;
static int HAND_RIGHT = 12;
static int THUMB_RIGHT = 13;
static int UPPER_ARM_LEFT = 14;
static int LOWER_ARM_LEFT = 15;
static int WRIST_LEFT = 16;
static int HAND_LEFT = 17;
static int THUMB_LEFT = 18;
static int UPPER_LEG_RIGHT = 19;
static int LOWER_LEG_RIGHT = 20;
static int FOOT_RIGHT = 21;
static int UPPER_LEG_LEFT = 22;
static int LOWER_LEG_LEFT = 23;
static int FOOT_LEFT = 24;

//extra fake bones
static int BODY_LEFT = 25;
static int BODY_RIGHT = 26;
static int BODY_CROSS_LEFT = 27;
static int BODY_CROSS_RIGHT = 28;

static float LIMIT_FACTOR = 0.5;
static int PARTICLE_LIMIT = round(numParticles * LIMIT_FACTOR);


static int[][] bones = {
  
  //head
  { KinectPV2.JointType_Head, KinectPV2.JointType_Neck },
  
  //neck
  { KinectPV2.JointType_Neck, KinectPV2.JointType_SpineShoulder },
  
  //spine
  { KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_SpineMid },
  { KinectPV2.JointType_SpineMid, KinectPV2.JointType_SpineBase },
  
  //shoulders
  { KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderRight, PARTICLE_LIMIT },
  { KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderLeft, PARTICLE_LIMIT },
  
  //hips
  { KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipRight, PARTICLE_LIMIT },
  { KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipLeft, PARTICLE_LIMIT },
  
  //right arm
  { KinectPV2.JointType_ShoulderRight, KinectPV2.JointType_ElbowRight },
  { KinectPV2.JointType_ElbowRight, KinectPV2.JointType_WristRight },
  { KinectPV2.JointType_WristRight, KinectPV2.JointType_HandRight, PARTICLE_LIMIT },
  { KinectPV2.JointType_HandRight, KinectPV2.JointType_HandTipRight, PARTICLE_LIMIT },
  { KinectPV2.JointType_WristRight, KinectPV2.JointType_ThumbRight, PARTICLE_LIMIT },
  
  //left arm
  { KinectPV2.JointType_ShoulderLeft, KinectPV2.JointType_ElbowLeft },
  { KinectPV2.JointType_ElbowLeft, KinectPV2.JointType_WristLeft },
  { KinectPV2.JointType_WristLeft, KinectPV2.JointType_HandLeft, PARTICLE_LIMIT },
  { KinectPV2.JointType_HandLeft, KinectPV2.JointType_HandTipLeft, PARTICLE_LIMIT },
  { KinectPV2.JointType_WristLeft, KinectPV2.JointType_ThumbLeft, PARTICLE_LIMIT },
  
  //right leg
  { KinectPV2.JointType_HipRight, KinectPV2.JointType_KneeRight },
  { KinectPV2.JointType_KneeRight, KinectPV2.JointType_AnkleRight },
  { KinectPV2.JointType_AnkleRight, KinectPV2.JointType_FootRight },
  
  //left leg
  { KinectPV2.JointType_HipLeft, KinectPV2.JointType_KneeLeft },
  { KinectPV2.JointType_KneeLeft, KinectPV2.JointType_AnkleLeft },
  { KinectPV2.JointType_AnkleLeft, KinectPV2.JointType_FootLeft },
  
  //extra body joints that make the cross
  { KinectPV2.JointType_HipRight, KinectPV2.JointType_ShoulderRight },
  { KinectPV2.JointType_HipLeft, KinectPV2.JointType_ShoulderLeft },
  { KinectPV2.JointType_HipLeft, KinectPV2.JointType_ShoulderRight },
  { KinectPV2.JointType_HipRight, KinectPV2.JointType_ShoulderLeft }

};