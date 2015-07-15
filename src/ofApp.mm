#include "ofApp.h"

const int ofApp::beaconMajors[] = {3362, 18303, 20817, 35141, 35763, 37272, 44647, 51249};//3362 ,18303 , 35141, 37272, 44647, 51249, 61986, 62213, 64508};

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
    
    bool loaded;
    loaded = logo.loadImage("logoWhite.png");
    cout<<loaded<<endl;
    
    loaded = font.loadFont("bembo-bold.ttf", 68);
    cout<<loaded<<endl;

    alpha = 0;
    
    gui = new ofxPanel();
    
    gui->setup("values");
    
    numNarratives = 0;
    
    intro = new smoothPlayer(0, 10, 0.1, 0.08, false);
    outro = new smoothPlayer(0, 10, 0.1, 0.08, false);
    
    intro->loadSound("sounds/Battlement/Distant Roar.mp3");
    intro->setMaxVol(1.0);
    intro->setLoop(false);
    intro->setIsActive(true);
    intro->setAmbient(false);
    
    outro->loadSound("sounds/thanks you.mp3");
    outro->setMaxVol(1.0);
    outro->setLoop(false);
    outro->setIsActive(true);
    
    pd = new ofxPd();

    start = new Button();
    
    start->setup(ofGetWidth()/2 - 200, 450, 400, 200);
    
    image.loadImage("Default@2x~ipad.png");
    
    ofBackground(162, 164, 149);
    
    ofxAccelerometer.setup();
    
    for(int i=0; i < NUMBEACONS; i++) {
        soundBeacon *beacon = new soundBeacon(beaconMajors[i]);
        beacons[beaconMajors[i]] = beacon;
    }
    
    //setup Pd controlling beacon
    beacons[37272]->setPd(pd);
    beacons[37272]->addPdVarToSend(&ofMap, "echoVol");
    beacons[37272]->addPdVarToSend(&reverseMap, "windVol");
    beacons[37272]->setMaxVal(0.1, true, 1);
    beacons[37272]->setMaxVal(0.2, true, 0);
    
    //setup beacons with sounds in order:
    
    //[3362]
    //Ambient: 0 Triggered: 1
    //Ambient: aftermath Triggered: Troll Roar
    
    loaded = beacons[3362]->loadSound("sounds/Long Ambience/aftermath.mp3", 0);
    beacons[3362]->setLoop(true, 0);
    beacons[3362]->setMaxVal(0.5, 0, 0);
    beacons[3362]->setFarBound(8, 0, 0);
    beacons[3362]->setAmbient(true, 0);
    beacons[3362]->setIsActive(true, 0);
    cout<<loaded<<endl;

    
    loaded = beacons[3362]->loadSound("sounds/Long Ambience/caveAmbient.mp3", 1);
    beacons[3362]->setMaxVal(1.0, 0, 1);
    beacons[3362]->setFarBound(6, 0, 1);
    beacons[3362]->setAmbient(false, 1);
    beacons[3362]->setIsActive(true, 1);
    if(loaded) numNarratives++;
    beacons[3362]->addGate(intro, 1);
    cout<<loaded<<endl;

    
    //[18303]
    //Triggered: 0
    //Triggered: Here on the windy battlements...
    
//    loaded = beacons[18303]->loadSound("sounds/Battlement/Distant Roar whispers.mp3", 0);
//    beacons[18303]->setMaxVal(1.0, 0, 0);
//    beacons[18303]->setFarBound(4, 0, 0);
//    beacons[18303]->setAmbient(false, 0);
//    beacons[18303]->setIsActive(true, 0);
//    if(loaded) numNarratives++;
//    beacons[18303]->addGate(beacons[3362]->players[1], 0);
//    cout<<loaded<<endl;


    
    //[20817]
    //Ambient: 0 Triggered: 1
    //Triggered: Listen as the last known Ambient: monsterDrone
    
    loaded = beacons[20817]->loadSound("sounds/Battlement/Gogg Magog/monsterDrone.mp3", 0);
    beacons[20817]->setLoop(true, 0);
    beacons[20817]->setMaxVal(0.5, 0, 0);
    beacons[20817]->setFarBound(8, 0, 0);
    beacons[20817]->setAmbient(true, 0);
    beacons[20817]->setIsActive(true, 0);
    cout<<loaded<<endl;

    
    loaded = beacons[20817]->loadSound("sounds/Battlement/Last known giants.mp3", 1);
    beacons[20817]->setMaxVal(1.0, 0, 1);
    beacons[20817]->setFarBound(6, 0, 1);
    beacons[20817]->setAmbient(false, 1);
    beacons[20817]->setIsActive(true, 1);
    if(loaded) numNarratives++;
    beacons[20817]->addGate(beacons[18303]->players[0], 1);
    cout<<loaded<<endl;

    
    loaded = beacons[20817]->loadSound("sounds/Battlement/Gogg Magog/TwoGroans.mp3", 2);
    beacons[20817]->setMaxVal(1.0, 0, 2);
    beacons[20817]->setFarBound(6, 0, 2);
    beacons[20817]->setAmbient(false, 2);
    beacons[20817]->setIsActive(true, 2);
    beacons[20817]->addGate(beacons[20817]->players[1], 2);
    cout<<loaded<<endl;

    
    //[35141]
    //Ambient: 0 Triggered: 1
    //Triggered: The armies have heard them too Ambient: Our Horns
    
    loaded = beacons[35141]->loadSound("sounds/Battlement/Nordic Bronze Age Lures 1700-500 BC and the Kings grave.mp3", 0);
    beacons[35141]->setLoop(true, 0);
    beacons[35141]->setMaxVal(0.5, 0, 0);
    beacons[35141]->setFarBound(8, 0, 0);
    beacons[35141]->setAmbient(true, 0);
    beacons[35141]->setIsActive(true, 0);
    cout<<loaded<<endl;

    
    loaded = beacons[35141]->loadSound("sounds/Battlement/Armies of brutus.mp3", 1);
    beacons[35141]->setMaxVal(1.0, 0, 1);
    beacons[35141]->setFarBound(6, 0, 1);
    beacons[35141]->setAmbient(false, 1);
    beacons[35141]->setIsActive(true, 1);
    if(loaded) numNarratives++;
    beacons[35141]->addGate(beacons[20817]->players[2], 1);
    cout<<loaded<<endl;


    
    //[35763]
    //Ambient: 0
    //Ambient: Soldier sounds
    loaded = beacons[35763]->loadSound("sounds/Battlement/Medieval battle sound effect - infantry.mp3", 0);
    beacons[35763]->setLoop(true, 0);
    beacons[35763]->setMaxVal(0.5, 0, 0);
    beacons[35763]->setFarBound(5, 0, 0);
    beacons[35763]->setAmbient(true, 0);
    beacons[35763]->setIsActive(true, 0);
    cout<<loaded<<endl;

    
    //[37272]
    //Triggered: 0
    //Triggere: Salt Tower intro
    loaded = beacons[37272]->loadSound("sounds/Salt Tower/Salt Tower intro whispers.mp3", 0);
    beacons[37272]->setMaxVal(0.8, 0, 0);
    beacons[37272]->setFarBound(6, 0, 0);
    beacons[37272]->setAmbient(false, 0);
    beacons[37272]->setIsActive(true, 0);
    if(loaded) numNarratives++;
    cout<<loaded<<endl;
    beacons[37272]->addGate(beacons[35141]->players[1], 0);
    cout<<loaded<<endl;

    
    //[44647]
    //Ambient: 0 Triggered 1
    //Ambient: Crackling Fire Triggered: Henry Walpole angry 1
    loaded = beacons[44647]->loadSound("sounds/Salt Tower/Crackling Campfire.mp3", 0);
    beacons[44647]->setLoop(true, 0);
    beacons[44647]->setMaxVal(0.05, 0, 0);
    beacons[44647]->setFarBound(8, 0, 0);
    beacons[44647]->setAmbient(true, 0);
    beacons[44647]->setIsActive(true, 0);
    cout<<loaded<<endl;

    
    loaded = beacons[44647]->loadSound("sounds/Salt Tower/Walpole one.mp3", 1);
    beacons[44647]->setMaxVal(0.8, 0, 1);
    beacons[44647]->setFarBound(4, 0, 1);
    beacons[44647]->setAmbient(false, 1);
    beacons[44647]->setIsActive(true, 1);
    if(loaded) numNarratives++;
    beacons[44647]->addGate(beacons[37272]->players[0], 1);
    beacons[44647]->addGate(beacons[51249]->players[1], 1);
    cout<<loaded<<endl;



    //[51249]
    //Ambient: 0 Triggered: 1
    //Ambient: Crackling Fire Triggered: Henry Walpole angry 1
    loaded = beacons[51249]->loadSound("sounds/Salt Tower/scaryGhosts.mp3", 0);
    beacons[51249]->setLoop(true, 0);
    beacons[51249]->setMaxVal(0.08, 0, 0);
    beacons[51249]->setFarBound(8, 0, 0);
    beacons[51249]->setAmbient(true, 0);
    beacons[51249]->setIsActive(true, 0);
    cout<<loaded<<endl;

    
    loaded = beacons[51249]->loadSound("sounds/Salt Tower/Walpole two.mp3", 1);
    beacons[51249]->setMaxVal(0.8, 0, 1);
    beacons[51249]->setFarBound(4, 0, 1);
    beacons[51249]->setAmbient(false, 1);
    beacons[51249]->setIsActive(true, 1);
    if(loaded) numNarratives++;
    beacons[51249]->addGate(beacons[37272]->players[0], 1);
    beacons[51249]->addGate(beacons[44647]->players[1], 1);
    cout<<loaded<<endl;


    
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
    
    // puredata works on sounds in chunks of 64 samples (called a tick)
    // 8 ticks per buffer corresponds to 8 * 64 sample buffer size (512 samples)
    int ticksPerBuffer = 8;
    
    // note here we've changed the number of inputs (second parameter) to 1.
    pd->init(2, 1, 44100, ticksPerBuffer);
    
    // open the patch (relative to the data folder)
    //pd->openPatch("whiteNoise.pd");
    pd->openPatch("echochamber.pd");
    
    ofSetColor(255);
    
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
    }
}

//--------------------------------------------------------------
void ofApp::draw(){
    ofSetColor(255);
    image.draw(0, 0, ofGetWidth(), ofGetHeight());
    start->display();
    if(outro->playedOnce) {
        ofSetColor(255, 255, 253, alpha);
        string thanks = "Thanks!";
        font.drawString(thanks, ofGetWidth()/2 - font.getStringBoundingBox(thanks, 0, 0).width/2, ofGetHeight()/2 - font.getStringBoundingBox(thanks, 0, 0).height/2 + 30);
        int width = 200;
        logo.draw(ofGetWidth()/2 - width/2, ofGetHeight()/2 - width/2 + 200, width, width);
        alpha += 2;
        if(alpha > 255) alpha = 255;
    }
//    int y = 10;
//    for(auto distance: *manager->distances) {
//        if(distance.second > 0 && beacons.find(distance.first) != beacons.end()) {
//            beacons[distance.first]->display(10, y, 0);
//            y += 110;
//        }
//    }
    //gui->draw();
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
    gui->saveToFile("settings.xml");
    delete gui;
    delete intro;
    delete outro;
    delete manager;
    delete start;
    delete pd;
    for(auto beacon : beacons) {
        delete beacon.second;
    }
}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    if(start->isInside(touch.x, touch.y)) {
        pd->start();
        active = true;
        start->clicked = true;
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

//--------------------------------------------------------------
void ofApp::paramChanged(ofAbstractParameter & param) {
    cout<<param.getName()<<endl;
    cout<<param<<endl;
}