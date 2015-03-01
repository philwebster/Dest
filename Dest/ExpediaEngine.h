//
//  ExpediaEngine.h
//  Dest
//
//  Created by Philip Webster on 2/28/15.
//  Copyright (c) 2015 phil. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@interface ExpediaEngine : NSObject {
    CLLocationManager *locationManager;
}

+ (id)singleton;

- (void)airportIDForLocation:(CLLocationCoordinate2D)location completion:(void (^)(NSDictionary *))completion;
- (void)tripInfoForOrigin:(CLLocationCoordinate2D)origin destination:(CLLocationCoordinate2D)destination completion:(void (^)(NSDictionary *))completion;
- (void)tripInfoForOriginAirport:(NSDictionary *)originAirport destination:(NSDictionary *)destinationAirport destinationID:(NSString *)destID completion:(void (^)(NSDictionary *))completion;

@end
