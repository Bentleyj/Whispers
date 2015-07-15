#pragma once

#include "ofMain.h"
#include "ofxiOS.h"
#include "ofxiOSExtras.h"
#include "estimoteDistanceManager.h"
#include "soundBeacon.h"
#include "ofxPd.h"
#include "Button.h"
#include "ofxGui.h"

#define NUMBEACONS 8

class ofApp : public ofxiOSApp {
	
public:
    void setup();
    void update();
    void draw();
    void exit();
	
    void touchDown(ofTouchEventArgs & touch);
    void touchMoved(ofTouchEventArgs & touch);
    void touchUp(ofTouchEventArgs & touch);
    void touchDoubleTap(ofTouchEventArgs & touch);
    void touchCancelled(ofTouchEventArgs & touch);

    void lostFocus();
    void gotFocus();
    void gotMemoryWarning();
    void deviceOrientationChanged(int newOrientation);

    void setupAmbientBeacon(int major);
    void setupTriggeredBeacon(int major);
    void paramChanged(ofAbstractParameter & param);
    
    void beginExperience();
    
    // the audio callbacks
    void audioIn(float *input, int bufferSize, int numChannels);
    void audioOut(float *output, int bufferSize, int numChannels);

    
    template<typename A, typename B>
    std::multimap<B,A> flip_map(const std::map<A,B> &src);
    
    distanceManager *manager;
    map<int, soundBeacon*> beacons;
    
    ofxPd* pd;
    
    ofxPanel * gui;
    
    ofParameter<float> farBounds[NUMBEACONS*NUMPLAYERSPERBEACON];
    ofParameter<float> maxVols[NUMBEACONS*NUMPLAYERSPERBEACON];
    
    ofParameterGroup group;
    
    smoothPlayer * intro;
    smoothPlayer * outro;
    ofImage image;
    
    int numNarratives;
    bool active;
    
    Button * start;
    int alpha = 0;
    
    ofImage logo;
    
    ofTrueTypeFont font;
    
    const static int beaconMajors[];
};




