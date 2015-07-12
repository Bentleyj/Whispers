//
//  estimoteDistanceManager.cpp
//  WhispersProximity
//
//  Created by James Bentley on 6/10/15.
//
//

#include "estimoteDistanceManager.h"

const int distanceManager::beaconMajors[] = {3362, 18303, 20817, 35141, 35763, 37272, 44647, 51249, 61986, 62213, 64508};

distanceManager::distanceManager() {
    manager = [[estimoteDistanceManager alloc] init];
    distances = new vector<std::pair<int, double> >();
    for(int i=0; i < 10; i++) {
        distances->push_back(make_pair(beaconMajors[i], -1));
    }
}

void distanceManager::setup() {
    [manager setup];
}

void distanceManager::update() {
    for(int i=0; i<10; i++) {
        for(auto distanceFromManager : *[manager distances]) {
            if(distances->operator[](i).first == distanceFromManager.first) {
                distances->operator[](i) = make_pair(distanceFromManager.first, distanceFromManager.second);
            }
        }
    }
    sort(distances->begin(), distances->end(), sort_pred());
}


@implementation estimoteDistanceManager

- (void) setup
{
    [super init];
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID
                                                     identifier:@"EstimoteSampleRegion"];
    
    [self.beaconManager requestAlwaysAuthorization];
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
    self.distances = new vector<pair<int, double> >();
}

-(void) beaconManager:(id)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    self.distances->clear();
    for(id beacon in beacons) {
        int val = [[beacon major] intValue];
        double dist = [beacon accuracy];
        self.distances->push_back(make_pair(val, dist));
    }
}

@end