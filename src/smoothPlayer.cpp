
//
//  smoothPlayer.cpp
//  Whispers
//
//  Created by James Bentley on 7/3/15.
//
//

#include "smoothPlayer.h"

smoothPlayer::smoothPlayer(float _nearBound, float _farBound, float _damping = 0.1, float _attraction = 0.08, bool _ambient = true) {
    player = new ofSoundPlayer();
    minVol = 0.0;
    maxVol = 1.0;
    farBound = _farBound;
    nearBound = _nearBound;
    ambient = _ambient;
    vol = Integratorf(0.0f, _damping, _attraction);
    playedOnce = false;
    isActive = false;
    finished = false;
    gates = new vector<smoothPlayer*>();
}

bool smoothPlayer::loadSound(string soundPath) {
    if (player != NULL) {
        bool loaded = player->loadSound(soundPath);
        return loaded;
    }
    ofLogNotice("soundBeacon::loadSound()", "player not initialized");
    return false;
}

void smoothPlayer::update() {
    if(isActive) {
        if(ambient || !playedOnce) {
            vol.update();
        }
        if(vol.val > 0.1 && !player->getIsPlaying() && !playedOnce && !ambient) {
            play();
        }
        player->setVolume(vol.val);
    }
}

void smoothPlayer::setLoop(bool _loopState) {
    player->setLoop(_loopState);
}

void smoothPlayer::setVol(float _vol) {
    vol.set(_vol);
}

void smoothPlayer::tarVol(float _vol) {
    float val = ofxTween::map(_vol, nearBound, farBound, maxVol, minVol, true, easeQuad, ofxTween::easeIn);
    vol.target(val);
}

float smoothPlayer::getVol() {
    return vol.val;
}

void smoothPlayer::play() {
    if(isActive) {
        if(player != NULL) {
            if(gates->size() == 0) {
                if(!ambient) {
                    player->setVolume(maxVol);
                    vol.set(maxVol);
                }
                else {
                    player->setVolume(minVol);
                    vol.set(minVol);
                }
                player->play();
                player->setPaused(false);
                vol.update();
                playedOnce = true;
                return;
            }
            bool blocked = false;
            for(auto gate : *gates) {
                if(gate->player->getIsPlaying()) {
                    blocked = true;
                }
            }
            if(!blocked) {
                if(!ambient) {
                    player->setVolume(maxVol);
                    vol.set(maxVol);
                }
                else {
                    player->setVolume(minVol);
                    vol.set(minVol);
                }
                player->play();
                player->setPaused(false);
                vol.update();
                playedOnce = true;
                return;
            }
        }
    }
}

void smoothPlayer::pause() {
    player->setPaused(true);
}

void smoothPlayer::setDamping(float _val) {
    vol.setDamping(_val);
}

void smoothPlayer::setAttraction(float _val) {
    vol.setAttraction(_val);
}

void smoothPlayer::setMaxVol(float _maxVol) {
    maxVol = _maxVol;
}

void smoothPlayer::setMinVol(float _minVol) {
    minVol = _minVol;
}

void smoothPlayer::setAmbient(bool _ambient) {
    ambient = _ambient;
}

void smoothPlayer::setFarBound(float _farBound) {
    farBound = _farBound;
}

void smoothPlayer::setIsActive(bool _isActive) {
    isActive = _isActive;
}

void smoothPlayer::addGate(smoothPlayer * _gate) {
    gates->push_back(_gate);
}
