//
//  MapEngine.m
//  Dest
//
//  Created by Philip Webster on 2/28/15.
//  Copyright (c) 2015 phil. All rights reserved.
//

#import "MapEngine.h"

@implementation MapEngine

+ (id)singleton {
    static MapEngine *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

+ (NSString *)stringFromTimeInterval:(CGFloat)timeInSeconds {
    long seconds = lroundf(timeInSeconds); // Modulo (%) operator below needs int or long
    int hour = seconds / 3600;
    int mins = (seconds % 3600) / 60;
    return [NSString stringWithFormat:@"%d %@ %d %@ drive", hour, @"hour", mins, @"minute"];
}

- (void)directionsToLocation:(CLLocationCoordinate2D)toLocation completion:(void (^)(MKRoute *))completion{
    [self directionsToLocation:toLocation fromLocation:CLLocationCoordinate2DMake(-1, -1) completion:completion];
}

- (void)directionsToLocation:(CLLocationCoordinate2D)toLocation fromLocation:(CLLocationCoordinate2D)fromLocation completion:(void (^)(MKRoute *))completion{
    MKMapItem *origin = CLLocationCoordinate2DIsValid(fromLocation) ? [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:fromLocation addressDictionary:nil]] : [MKMapItem mapItemForCurrentLocation];
    MKMapItem *destination = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:toLocation addressDictionary:nil]];
    MKDirectionsRequest *directionsRequest = [[MKDirectionsRequest alloc] init];
    [directionsRequest setDestination:destination];
    [directionsRequest setSource:origin];
    
    MKDirections *directions = [[MKDirections alloc] initWithRequest:directionsRequest];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if (response.routes.count > 0) {
            MKRoute *route = [response.routes firstObject];
            if (completion) {
                completion(route);
            }
        }
    }];

}



@end
