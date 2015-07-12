#include "ofApp.h"

const int ofApp::beaconMajors[] = {20817, 51249, 37272, 35141, 44647, 62213};//3362 ,18303 , 35141, 37272, 44647, 51249, 61986, 62213, 64508};

//35763
//20817

float reverseMap(float val, float inputMin, float inputMax, float outputMin, float outputMax, bool clamp) {
    return ofMap(val, inputMin, inputMax, outputMax, outputMin, clamp);
}

//--------------------------------------------------------------
void ofApp::setup(){
    manager = new distanceManager();
    manager->setup();
    manager->update();
    
    numNarratives = 0;
    
    intro = new smoothPlayer(0, 10, 0.1, 0.08, false);
    outro = new smoothPlayer(0, 10, 0.1, 0.08, false);
    
    intro->loadSound("sounds/MaryLamb0.m4a");
    intro->setMaxVol(1.0);
    intro->setLoop(false);
    intro->setIsActive(true);
    intro->setAmbient(false);
    
    outro->loadSound("sounds/MaryLamb3.m4a");
    outro->setMaxVol(1.0);
    outro->setLoop(false);
    outro->setIsActive(true);

    button = new Button();
    
    button->setup(ofGetWidth()/2 - 200, 450, 400, 200);
    
    image.loadImage("Default@2x~ipad.png");
    
    ofBackground(162, 164, 149);
    
    ofxAccelerometer.setup();
    
    pd = new ofxPd();
    
    for(int i=0; i < 6; i++) {
        soundBeacon *beacon = new soundBeacon(beaconMajors[i]);
        beacons[beaconMajors[i]] = beacon;
    }
    
    beacons[20817]->loadSound("sounds/Battlement/Nordic Bronze Age Lures 1700-500 BC and the Kings grave.mp3", 0);
    beacons[20817]->setLoop(true, 0);
    beacons[20817]->setMaxVal(0.2, 0, 0);
    beacons[20817]->setFarBound(5, 0, 0);
    beacons[20817]->setAmbient(true, 0);
    beacons[20817]->setIsActive(true, 0);
    
    beacons[20817]->loadSound("sounds/MaryLamb1.m4a", 1);
    beacons[20817]->setMaxVal(1.0, 0, 1);
    beacons[20817]->setFarBound(2, 0, 1);
    beacons[20817]->setAmbient(false, 1);
    beacons[20817]->setIsActive(true, 1);
    numNarratives++;
    
    beacons[51249]->loadSound("sounds/Battlement/Medium Horn.mp3", 0);
    beacons[51249]->setLoop(true, 0);
    beacons[51249]->setMaxVal(0.2, 0, 0);
    beacons[51249]->setFarBound(5, 0, 0);
    beacons[51249]->setAmbient(true, 0);
    beacons[51249]->setIsActive(true, 0);

    beacons[37272]->setPd(pd);
    beacons[37272]->addPdVarToSend(&ofMap, "echoVol");
    beacons[37272]->addPdVarToSend(&reverseMap, "windVol");
    beacons[37272]->setMaxVal(0.05, true, 1);
    beacons[37272]->setMaxVal(0.2, true, 0);
    
    beacons[35141]->loadSound("sounds/Salt Tower/Crackling Campfire.mp3", 0);
    beacons[35141]->setLoop(true, 0);
    beacons[35141]->setMaxVal(0.1, 0, 0);
    beacons[35141]->setFarBound(2, 0, 0);
    beacons[35141]->setAmbient(true, 0);
    beacons[35141]->setIsActive(true, 0);
    
    beacons[35141]->loadSound("sounds/MaryLamb2.m4a", 1);
    beacons[35141]->setMaxVal(1.0, 0, 1);
    beacons[35141]->setFarBound(2, 0, 1);
    beacons[35141]->setAmbient(false, 1);
    beacons[35141]->setIsActive(true, 1);
    numNarratives++;
    
    beacons[62213]->addGate(intro, 0);
    beacons[44647]->addGate(intro, 0);
    beacons[62213]->addGate(beacons[44647]->players[0], 0);
    beacons[44647]->addGate(beacons[62213]->players[0], 0);

    //setupAmbientBeacon(44647);
//
//    beacons[64508]->loadSound("sounds/CC03.mp3", 0);
//    setupAmbientBeacon(64508);
//    
//    beacons[35141]->loadSound("sounds/CC05.mp3", 0);
//    setupAmbientBeacon(35141);
//    
    //beacons[51249]->loadSound("sounds/CC04.mp3", 0);
    //setupAmbientBeacon(51249);
//    beacons[51249]->setPd(pd);
//
//    beacons[18303]->loadSound("sounds/MaryLamb0.m4a", 0);
//    setupTriggeredBeacon(18303);
//
//    beacons[61986]->loadSound("sounds/MaryLamb1.m4a", 0);
//    setupTriggeredBeacon(61986);
//
//    beacons[62213]->loadSound("sounds/MaryLamb2.m4a", 0);
//    setupTriggeredBeacon(62213);
//
//    beacons[37272]->loadSound("sounds/MaryLamb3.m4a", 0);
//    setupTriggeredBeacon(37272);
    
    for(auto beacon : beacons) {
        for(int i=0; i < NUMPLAYERSPERBEACON; i++) {
            beacon.second->setVal(0, 0, i);
            for(auto player : beacon.second->players) {
                if(player->ambient) {
                    player->play();
                }
            }
        }
    }
    
    ofSetColor(255);
    
    // puredata works on sounds in chunks of 64 samples (called a tick)
    // 8 ticks per buffer corresponds to 8 * 64 sample buffer size (512 samples)
    int ticksPerBuffer = 8;
    
    // note here we've changed the number of inputs (second parameter) to 1.
    pd->init(2, 1, 44100, ticksPerBuffer);
    
    // open the patch (relative to the data folder)
    //pd->openPatch("whiteNoise.pd");
    pd->openPatch("echochamber.pd");
    
    // start pd
    
    ofSoundStreamSetup(2, 1, this, 44100, ofxPd::blockSize()*ticksPerBuffer, 1);
}

//--------------------------------------------------------------
void ofApp::update(){
    manager->update();
    for(auto beacon : beacons) {
        beacon.second->update();
    }
    if(active) {
        for (auto distance: *manager->distances) {
            if(beacons.find(distance.first) != beacons.end()) {
                for(int i=0; i < NUMPLAYERSPERBEACON; i++) {
                    if(distance.second < 0){
                        beacons[distance.first]->tarVal(100, false, i);
                    } else{
                        beacons[distance.first]->tarVal(distance.second, false, i);
                    }
                }
                for(int i=0; i < NUMSENDERSPERBEACON; i++) {
                    if(distance.second < 0){
                        beacons[distance.first]->tarVal(100, true, i);
                    } else {
                        beacons[distance.first]->tarVal(distance.second, true, i);
                    }
                }
            }
        }
        ofVec3f accel = ofxAccelerometer.getForce();
        float val = ofMap(accel.x, -1, 1, 1, 5, true);
        //cout<<val<<endl;
        pd->sendFloat("q", val);
        pd->sendFloat("center", ofMap(accel.y, -1, 1, 200, 1000, true));
        int count  = 0;
        for(auto beacon : beacons) {
            for(auto player : beacon.second->players) {
                if(!player->ambient) {
                    if(player->playedOnce && !player->player->getIsPlaying()) {
                        count++;
                    }
                }
            }
        }
        if (count == numNarratives) {
            outro->play();
            numNarratives = 0;
        }
        ofDrawBitmapString(ofToString(count), 20, 20);
        ofDrawBitmapString(ofToString(numNarratives), 20, 40);
    }
}

//--------------------------------------------------------------
void ofApp::draw(){
    ofSetColor(255);
    image.draw(0, 0, ofGetWidth(), ofGetHeight());
    button->display();
//    int y = 10;
//    for(auto distance: *manager->distances) {
//        if(distance.second > 0 && beacons.find(distance.first) != beacons.end()) {
//            beacons[distance.first]->display(10, y, 0);
//            y += 110;
//        }
//    }
    //ofDrawBitmapString(ofToString(beacons[51249]->senders[0]->name) + ofToString(beacons[51249]->senders[0]->val.val), 20, 20);
    //ofDrawBitmapString(ofToString(beacons[51249]->senders[1]->name) + ofToString(beacons[51249]->senders[1]->val.val), 20, 40);

    //gui.draw();
}

////--------------------------------------------------------------
//void ofApp::onAttractionChanged(float & newAttraction) {
//    for(auto beacon : beacons) {
//        beacon.second->setAttraction(newAttraction, 0);
//    }
//}
//
////--------------------------------------------------------------
//void ofApp::onDampingChanged(float & newDamping) {
//    for(auto beacon : beacons) {
//        beacon.second->setDamping(newDamping, 0);
//    }
//}

//--------------------------------------------------------------
void ofApp::setupAmbientBeacon(int _major) {

}

//--------------------------------------------------------------
void ofApp::setupTriggeredBeacon(int _major) {
    beacons[_major]->setMaxVal(1.0, 0, 0);
    beacons[_major]->setFarBound(2, 0, 0);
    beacons[_major]->setAmbient(false, 0);
    beacons[_major]->setIsActive(true, 0);
}

// this is how you get audio into pd
//--------------------------------------------------------------
void ofApp::audioIn(float *input, int bufferSize, int numChannels) {
    pd->audioIn(input, bufferSize, numChannels);
}

// this is where the openframeworks sound stream connects to ofxPd
// it's also where the audio processing is done
//--------------------------------------------------------------
void ofApp::audioOut(float *output, int bufferSize, int numChannels) {
    pd->audioOut(output, bufferSize, numChannels);
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    if(button->isInside(touch.x, touch.y)) {
        pd->start();
        active = true;
        button->clicked = true;
        image.loadImage("backgroundImage.png");
        intro->play();
        intro->setVol(1.0);
    }
    //pd->sendFloat("vol", touch.x/(float)ofGetWidth());
    //pd->sendFloat("center", ofMap(touch.x/(float)ofGetWidth(), 0, 1, 0, 1000));
    //pd->sendFloat("q", ofMap(touch.y/(float)ofGetHeight(), 0, 1, 0, 10));

}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    //pd.sendFloat("vol", touch.x/(float)ofGetWidth());
    //pd->sendFloat("center", ofMap(touch.x/(float)ofGetWidth(), 0, 1, 0, 1000));
    //pd->sendFloat("q", ofMap(touch.y/(float)ofGetHeight(), 0, 1, 0, 10));
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){

}

//--------------------------------------------------------------
void ofApp::gotFocus(){

}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){

}
