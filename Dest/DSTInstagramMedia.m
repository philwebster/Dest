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
        [[MapEngine singleton] directionsToLocation:_media.location completion:^(MKRoute *route) {
            _route = route;
        }];
    }
    return self;
}

@end
