//
//  soundBeacon.cpp
//  Whispers
//
//  Created by James Bentley on 7/2/15.
//
//

#include "soundBeacon.h"

soundBeacon::soundBeacon() {
    major = 0;
    for(int i=0; i < NUMPLAYERSPERBEACON; i++) {
        players[i] = new smoothPlayer(0, 2+2*i, 0.1*i, 0.08, true);
        plots[i] = new ofxHistoryPlot( &players[i]->vol.val, ofToString(major), 100, true);
        plots[i]->setRange(players[i]->minVol, players[i]->maxVol);
        plots[i]->setShowNumericalInfo(true);
        int r = (i == 0) ? 255 : 0;
        int g = (i == 1) ? 255 : 0;
        int b = (i == 2) ? 255 : 0;
        plots[i]->setColor(ofColor(r, g, b));
        plots[i]->setRespectBorders(true);
        plots[i]->setLineWidth(1);
        plots[i]->setShowSmoothedCurve(false);
        plots[i]->update(0);
    }
    senders[0] = new smoothSender("echoVal", 0, 5, 0.1, 0.08, true);
    senders[1] = new smoothSender("windVal", 0, 5, 0.1, 0.08, true);
    senders[2] = new smoothSender("center", 0, 5, 0.1, 0.08, true);
    senders[3] = new smoothSender("q", 0, 5, 0.1, 0.08, true);
}

soundBeacon::soundBeacon(int _major) {
    major = _major;
    for(int i=0; i < NUMPLAYERSPERBEACON; i++) {
        players[i] = new smoothPlayer(0, 2, 0.1, 0.08, true);
        plots[i] = new ofxHistoryPlot( &players[i]->vol.val, ofToString(major), 100, true);
        plots[i]->setDrawBackground(false);
        plots[i]->setRange(players[i]->minVol, players[i]->maxVol);
        plots[i]->setShowNumericalInfo(true);
        int r = (i == 0) ? 255 : 0;
        int g = (i == 1) ? 255 : 0;
        int b = (i == 2) ? 255 : 0;
        plots[i]->setColor(ofColor(r, g, b));
        plots[i]->setRespectBorders(true);
        plots[i]->setLineWidth(1);
        plots[i]->setShowSmoothedCurve(false);
        plots[i]->update(0);
    }
    senders[0] = new smoothSender("echoVol", 0, 5, 0.1, 0.08, true);
    senders[1] = new smoothSender("windVol", 0, 5, 0.1, 0.08, true);
    senders[2] = new smoothSender("center", 0, 5, 0.1, 0.08, true);
    senders[3] = new smoothSender("q", 0, 5, 0.1, 0.08, true);}

bool soundBeacon::loadSound(string soundPath, int index = 0) {
    if (players[index] != NULL) {
        bool loaded = players[index]->loadSound(soundPath);
        return loaded;
    }
    ofLogNotice("soundBeacon::loadSound()", "player not initialized");
    return false;
}

void soundBeacon::addPdVarToSend(float(*myMap)(float valToMap, float lowInput, float highInput, float lowOutput, float highOutput, bool clamp), int index) {
    senders[index]->setMap(myMap);
}

void soundBeacon::addPdVarToSend(float(*myMap)(float valToMap, float lowInput, float highInput, float lowOutput, float highOutput, bool clamp), string _name) {
    for(int i=0; i < NUMSENDERSPERBEACON; i++) {
        if(senders[i]->name == _name) {
            senders[i]->setMap(myMap);
        }
    }
}

void soundBeacon::update() {
    for(int i = 0; i < NUMPLAYERSPERBEACON; i++) {
        players[i]->update();
    }
    for(int i = 0; i < NUMSENDERSPERBEACON; i++) {
        senders[i]->update();
    }
}

void soundBeacon::setLoop(bool _loopState, int index = 0) {
    players[index]->setLoop(_loopState);
}

void soundBeacon::tarVal(float _val, bool _senders, int index = 0) {
    if(_senders) senders[index]->tarVal(_val);
    else players[index]->tarVol(_val);
}

void soundBeacon::setVal(float _val, bool _senders, int index = 0) {
    if(_senders) senders[index]->setVal(_val);
    else players[index]->setVol(_val);
}

void soundBeacon::setMaxVal(float _val, bool _senders, int index = 0) {
    if(_senders) senders[index]->setMaxVal(_val);
    else players[index]->setMaxVol(_val);}

void soundBeacon::setMinVal(float _val, bool _senders, int index = 0) {
    if(_senders) senders[index]->setMinVal(_val);
    else players[index]->setMinVol(_val);
}

float soundBeacon::getVal(bool _senders, int index = 0) {
    if(_senders) return senders[index]->getVal();
    else return players[index]->getVol();
}

int soundBeacon::getMajor() {
    return major;
}

void soundBeacon::play(int index = 0) {
    if(players[index] != NULL) {
        players[index]->play();
        return;
    }
    ofLogNotice("soundBeacon::play()", "player not initialized");
}

void soundBeacon::display(int x, int y, int index = 0) {
    for(int i=0; i<NUMPLAYERSPERBEACON; i++) {
        plots[i]->draw(x, y, ofGetWidth() - 20, 100);
        ofSetColor(plots[i]->getColor());
        ofDrawBitmapString(ofToString(players[i]->farBound), x, y + (i + 1) * 20);
    }
    
}

void soundBeacon::pause(int index = 0) {
    players[index]->pause();
}

void soundBeacon::setDamping(float _val, bool _senders, int index = 0) {
    if(_senders) senders[index]->setDamping(_val);
    else players[index]->setDamping(_val);
}

void soundBeacon::setAttraction(float _val, bool _senders, int index = 0) {
    if(_senders) senders[index]->setAttraction(_val);
    else players[index]->setAttraction(_val);
}

void soundBeacon::setAmbient(float _ambient, int index = 0) {
    players[index]->setAmbient(_ambient);
}

void soundBeacon::setFarBound(float _val, bool _senders, int index = 0) {
    if(_senders) senders[index]->setFarBound(_val);
    else players[index]->setFarBound(_val);
}

void soundBeacon::setIsActive(bool _isActive, int index = 0) {
    players[index]->setIsActive(_isActive);
}

void soundBeacon::setPd(ofxPd* _pd) {
    for(int i=0; i < NUMSENDERSPERBEACON; i++) {
        senders[i]->setPd(_pd);
    }
}

void soundBeacon::addGate(smoothPlayer * _gate, int index) {
    players[index]->addGate(_gate);
}