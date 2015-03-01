//
//  DSTInstagramMedia.m
//  Dest
//
//  Created by Philip Webster on 2/28/15.
//  Copyright (c) 2015 phil. All rights reserved.
//

#import "DSTInstagramMedia.h"
#import "MapEngine.h"
#import "ExpediaEngine.h"

@implementation DSTInstagramMedia

- (id)initWithIGMedia:(InstagramMedia *)media {
    self = [super init];
    if (self) {
        _media = media;
        _mapItem = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:_media.location addressDictionary:nil]];
        _mapItem.name = _media.locationName;
    }
    return self;
}

- (void)populateDirections {
    if (_route) {
        return;
    }
    [[MapEngine singleton] directionsToLocation:_media.location completion:^(MKRoute *route) {
        [self setRoute:route];
    }];
}

- (void)populateTripInfo {
    if (_tripInfo) {
        return;
    }
    
    [[ExpediaEngine singleton] tripInfoForOrigin:CLLocationCoordinate2DMake(-999, -999) destination:_media.location completion:^(NSDictionary *tripInfo) {
        self.tripInfo = tripInfo;
    }];
}

- (void)setTripInfo:(NSDictionary *)tripInfo {
//    if ([tripInfo class] != [NSDictionary class]) {
//        NSLog(@"bad: %@", tripInfo);
//    }
    _tripInfo = tripInfo;
}

@end
