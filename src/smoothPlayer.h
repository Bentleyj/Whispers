//
//  smoothPlayer.h
//  Whispers
//
//  Created by James Bentley on 7/3/15.
//
//

#ifndef __Whispers__smoothPlayer__
#define __Whispers__smoothPlayer__

#include "ofMain.h"
#include "Integratorf.h"
#include "ofxTween.h"

class smoothPlayer {
public:
    smoothPlayer(float _farBound, float _nearBound, float _damping, float _attraction, bool _ambient);
    bool loadSound(string _soundPath);
    void setLoop(bool _loopState);
    void tarVol(float _vol);
    void setVol(float _vol);
    float getVol();
    void play();
    void pause();
    void update();
    void setDamping(float _val);
    void setAttraction(float _val);
    void setMaxVol(float _maxVol);
    void setMinVol(float _minVol);
    void setAmbient(bool _ambient);
    void setFarBound(float _farBound);
    void setIsActive(bool _isActive);
    void addGate(smoothPlayer * _gate);
    //bool getFinished();
    
    bool ambient;
    bool finished;
    vector<smoothPlayer*> *gates;
    bool isActive;
    Integratorf vol;
    bool playedOnce;
    float minVol, nearBound, farBound, maxVol;
    ofSoundPlayer* player;
    ofxEasingQuad easeQuad;
};

#endif /* defined(__Whispers__smoothPlayer__) */
