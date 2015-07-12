
//
//  smoothPlayer.cpp
//  Whispers
//
//  Created by James Bentley on 7/3/15.
//
//

#include "smoothSender.h"

smoothSender::smoothSender(string _name, float _nearBound, float _farBound, float _damping = 0.1, float _attraction = 0.08, bool _ambient = true) {
    pd = NULL;
    minVal = 0.0;
    maxVal = 1.0;
    farBound = _farBound;
    nearBound = _nearBound;
    ambient = _ambient;
    val = Integratorf(0.0f, _damping, _attraction);
    name = _name;
    mappingFunc = NULL;
}

void smoothSender::setPd(ofxPd *_pd) {
    pd = _pd;
}

void smoothSender::update() {
    val.update();
    if(pd != NULL && mappingFunc != NULL) {
        pd->sendFloat(name, val.val);
    }
}

void smoothSender::setVal(float _val) {
    val.set(_val);
}

void smoothSender::tarVal(float _val) {
    if(mappingFunc != NULL) {
        float value = mappingFunc(_val, nearBound, farBound, maxVal, minVal, true);
        val.target(value);
    }
}

float smoothSender::getVal() {
    return val.val;
}

void smoothSender::setDamping(float _val) {
    val.setDamping(_val);
}

void smoothSender::setAttraction(float _val) {
    val.setAttraction(_val);
}

void smoothSender::setMaxVal(float _maxVal) {
    maxVal = _maxVal;
}

void smoothSender::setMinVal(float _minVal) {
    minVal = _minVal;
}

void smoothSender::setFarBound(float _farBound) {
    farBound = _farBound;
}

void smoothSender::setMap(float (*myMap)(float _valToMap, float lowInput, float highInput, float lowOutput, float highOutput, bool clamp)) {
    mappingFunc = myMap;
}
