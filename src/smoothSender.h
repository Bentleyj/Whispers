//
//  smoothPlayer.h
//  Whispers
//
//  Created by James Bentley on 7/3/15.
//
//

#ifndef __Whispers__smoothSender__
#define __Whispers__smoothSender__

#include "ofMain.h"
#include "Integratorf.h"
#include "ofxPd.h"

class smoothSender {
public:
    smoothSender(string _name, float _farBound, float _nearBound, float _damping, float _attraction, bool _ambient);
    void setPd(ofxPd* _pd);
    void tarVal(float _val);
    void setVal(float _val);
    float getVal();
    void update();
    void setDamping(float _val);
    void setAttraction(float _val);
    void setMaxVal(float _maxVal);
    void setMinVal(float _minVal);
    void setFarBound(float _farBound);
    void setMap(float(*myMap)(float valToMap, float lowInput, float highInput, float lowOutput, float highOutput, bool clamp));
    float (*mappingFunc)(float valToMap, float lowInput, float highInput, float lowOutput, float highOutput, bool clamp);
    
    bool ambient;
    Integratorf val;
    float minVal, maxVal, farBound, nearBound;
    ofxPd* pd;
    string name;
};

#endif /* defined(__Whispers__smoothPlayer__) */
