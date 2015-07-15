//
//  soundBeacon.h
//  Whispers
//
//  Created by James Bentley on 7/2/15.
//
//

#ifndef __Whispers__soundBeacon__
#define __Whispers__soundBeacon__

#define NUMPLAYERSPERBEACON 3
#define NUMSENDERSPERBEACON 4

#include "ofMain.h"
#include "ofxHistoryPlot.h"
#include "smoothPlayer.h"
#include "smoothSender.h"
#include "ofxPd.h"

class soundBeacon {
public:
    soundBeacon();
    soundBeacon(int _major);
    bool loadSound(string _soundPath, int index);
    void setLoop(bool _loopState, int index);
    void tarVal(float _val, bool senders, int index);
    void setVal(float _val, bool senders, int index);

    float getVal(bool senders, int index);
    int getMajor();
    void play(int index);
    void pause(int index);
    void update();
    void display(int _x, int _y, int index);
    void setDamping(float _val, bool senders, int index);
    void setAttraction(float _val, bool senders, int index);
    void setMaxVal(float _maxVal, bool senders, int index);
    void setMinVal(float _minVal, bool senders, int index);
    void setAmbient(float _ambient, int index);
    void setFarBound(float _farBound, bool senders, int index);
    void setIsActive(bool _isActive, int index);
    void setPd(ofxPd* _pd);
    void addGate(smoothPlayer * _gate, int index);
    void addPdVarToSend(float(*myMap)(float valToMap, float lowInput, float highInput, float lowOutput, float highOutput, bool clamp), int index);
    void addPdVarToSend(float(*myMap)(float valToMap, float lowInput, float highInput, float lowOutput, float highOutput, bool clamp), string _name);
    
    int major;
    
    smoothPlayer* players[NUMPLAYERSPERBEACON];
    ofxHistoryPlot* plots[NUMPLAYERSPERBEACON + NUMSENDERSPERBEACON];
    smoothSender* senders[NUMSENDERSPERBEACON];
};

#endif /* defined(__Whispers__soundBeacon__) */
