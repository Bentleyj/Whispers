#pragma once

#include "ofMain.h"
#include "ofxiOS.h"
#include "ofxiOSExtras.h"
#include "estimoteDistanceManager.h"
#include "soundBeacon.h"
#include "ofxPd.h"
#include "Button.h"

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
    
//        void onAttractionChanged(float & newAttraction);
//        void onDampingChanged(float & newDamping);
        void setupAmbientBeacon(int major);
        void setupTriggeredBeacon(int major);
    
    void beginExperience();
    
    // the audio callbacks
    void audioIn(float *input, int bufferSize, int numChannels);
    void audioOut(float *output, int bufferSize, int numChannels);

    
    template<typename A, typename B>
    std::multimap<B,A> flip_map(const std::map<A,B> &src);
    
    distanceManager *manager;
    map<int, soundBeacon*> beacons;
    
    ofxPd* pd;
    
    smoothPlayer * intro;
    smoothPlayer * outro;
    ofImage image;
    
    int numNarratives;
    bool active;
    
    Button * button;
    
    const static int beaconMajors[];
};




