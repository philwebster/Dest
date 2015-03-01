//
//  ExpediaEngine.h
//  Dest
//
//  Created by Philip Webster on 2/28/15.
//  Copyright (c) 2015 phil. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@interface ExpediaEngine : NSObject

+ (id)singleton;

- (NSString *)airportIDForLocation:(CLLocationCoordinate2D)location;

@end
