//
//  estimoteDistanceManager.h
//  WhispersProximity
//
//  Created by James Bentley on 6/10/15.
//
//

#ifndef __WhispersProximity__estimoteDistanceManager__
#define __WhispersProximity__estimoteDistanceManager__

#include "ofMain.h"
#import <EstimoteSDK/EstimoteSDK.h>

@interface estimoteDistanceManager : NSObject<ESTBeaconManagerDelegate>

@property (nonatomic, strong) ESTBeaconManager *beaconManager;
@property (nonatomic, strong) CLBeaconRegion *beaconRegion;

@property vector<std::pair<int, double> >* distances;

- (void) setup;
@end

struct sort_pred {
    bool operator()(const std::pair<int,int> &left, const std::pair<int,int> &right) {
        return left.second < right.second;
    }
};

class distanceManager {
public:
    estimoteDistanceManager *manager;
    distanceManager();
    vector<std::pair<int, double> >* distances;
    void update();
    void setup();
    const static int beaconMajors[];
};




#endif /* defined(__WhispersProximity__estimoteDistanceManager__) */
