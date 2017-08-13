void showHelpDisplay() {
  fill(0);
  
  text("framerate : " + frameRate, 50, 50);
  
  text("( 1 | 2 ) numParticles: " + numParticles, 50, 70);
  text("( 3 | 4 ) trackScale: " + trackScale, 50, 85);
  text("( 5 | 6 ) noneTrackScale: " + noneTrackScale, 50, 100);
  text("( 7 | 8 ) lengthRange: " + lengthRange, 50, 115);
  text("( 9 | 0 ) topspeed: " + topspeed, 50, 130);
}