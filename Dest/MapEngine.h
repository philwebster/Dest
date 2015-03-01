//
//  MapEngine.h
//  Dest
//
//  Created by Philip Webster on 2/28/15.
//  Copyright (c) 2015 phil. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@interface MapEngine : NSObject

+ (id)singleton;

+ (NSString *)driveTimeFromTimeInterval:(CGFloat)timeInSeconds;
- (void)directionsToLocation:(CLLocationCoordinate2D)toLocation completion:(void (^)(MKRoute *))completion;
- (void)directionsToLocation:(CLLocationCoordinate2D)toLocation fromLocation:(CLLocationCoordinate2D)fromLocation completion:(void (^)(MKRoute *))completion;

@end
