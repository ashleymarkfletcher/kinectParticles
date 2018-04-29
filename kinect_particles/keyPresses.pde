void keyPressed() {
  switch (key) {
    case '1': {

      numParticles += 10;
      setupParticles();
      break;
    }
    case '2': {
      if (numParticles >= 60) {
        numParticles -= 10;
        setupParticles();
      }
      break;
    }
    case '3': {
      trackScale += 1;
      setupParticles();
      break;
    }
    case '4': {
      if (trackScale >= 2) {
        trackScale -= 1;
        setupParticles();
      }
      break;
    }
    case '5': {
      noneTrackScale += 1;
      setupParticles();
      break;
    }
    case '6': {
      if (noneTrackScale >= 2) {
        noneTrackScale -= 1;
        setupParticles();
      }
      break;
    }
    case '7': {
      lengthRange += 1;
      setupParticles();
      break;
    }
    case '8': {
      if (lengthRange >= 2) {
        lengthRange -= 1;
        setupParticles();
      }
      break;
    }
    case '9': {
      topspeed += 1;
      setupParticles();
      break;
    }
    case '0': {
      topspeed -= 1;
      setupParticles();
      break;
    }
    case 'h': {
      showHelp = !showHelp;
      print(showHelp);
      break;
    }
  }
}
