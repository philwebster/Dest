//
//  ExpediaEngine.m
//  Dest
//
//  Created by Philip Webster on 2/28/15.
//  Copyright (c) 2015 phil. All rights reserved.
//

#import "ExpediaEngine.h"

@implementation ExpediaEngine

+ (id)singleton {
    static ExpediaEngine *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

- (void)airportIDForLocation:(CLLocationCoordinate2D)location completion:(void (^)(NSDictionary *))completion {
    CLLocationCoordinate2D loc = location;
    if (!CLLocationCoordinate2DIsValid(loc)) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [locationManager startUpdatingLocation];
        loc = [[locationManager location] coordinate];
//        loc = CLLocationCoordinate2DMake(37.808034, -122.429994);
    }
    
    NSString *latitude = [NSString stringWithFormat:@"%f", loc.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", loc.longitude];

    NSURL *expediaRequestURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://terminal2.expedia.com:80/geo/features?within=150km&lat=%@&lng=%@&type=airport&verbose=4&apikey=r3aSGXEhBIJfo6Wm3acwkOZBd3grah7B", latitude, longitude]];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:expediaRequestURL
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                if (error) {
                    NSLog(@"error with expedia airport id request: %@", error);
                    return;
                }
                // handle response
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSDictionary *closestAirport;
                for (NSDictionary *airport in json) {
                    NSInteger bestPopularity = [closestAirport[@"tags"][@"score"][@"computedPopularity"][@"value"] integerValue];
                    NSInteger thisPopularity = [airport[@"tags"][@"score"][@"computedPopularity"][@"value"] integerValue];

                    NSInteger thisDistance = [airport[@"geoContext"][@"directDistance"][@"value"] integerValue];
                    NSInteger bestDistance = [closestAirport[@"geoContext"][@"directDistance"][@"value"] integerValue];
                    
                    if (!closestAirport) {
                        closestAirport = airport;
                        continue;
                    }

                    if (thisPopularity >= bestPopularity && thisDistance < bestDistance && ![airport[@"name"] containsString:@"Heli"]) {
                        closestAirport = airport;
                    }
                }
                NSLog(@"closest airport: %@", closestAirport);
                if (completion) {
                    completion(closestAirport);
                }
            }] resume];
}

- (void)regionIDForAirport:(NSDictionary *)airport completion:(void (^)(NSString *))completion {
    NSString *airportCode = airport[@"tags"][@"iata"][@"airportCode"][@"value"];
    NSURL *expediaRequestURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://terminal2.expedia.com:80/suggestions/regions?query=%@&apikey=r3aSGXEhBIJfo6Wm3acwkOZBd3grah7B", airportCode]];
    NSLog(@"region ID request url: %@", expediaRequestURL);
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:expediaRequestURL
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                // handle response
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                if (error) {
                    NSLog(@"error with expedia regionID request: %@\n%@", error, json);
                    return;
                }

                if (completion) {
                    completion(json[@"sr"][0][@"id"]);
                }
            }] resume];
}

- (void)tripInfoForOriginAirport:(NSDictionary *)originAirport destination:(NSDictionary *)destinationAirport destinationID:(NSString *)destID completion:(void (^)(NSDictionary *))completion {
    NSString *departureDate = @"2015-03-02";
    NSString *returnDate = @"2015-03-07";
    NSString *regionID = destID;
    
    NSURL *expediaRequestURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://terminal2.expedia.com/packages?departureDate=%@&originAirport=%@&destinationAirport=%@&returnDate=%@&regionid=%@&apikey=r3aSGXEhBIJfo6Wm3acwkOZBd3grah7B", departureDate, originAirport[@"tags"][@"iata"][@"airportCode"][@"value"], destinationAirport[@"tags"][@"iata"][@"airportCode"][@"value"], returnDate, regionID]];
    NSLog(@"URL for trip info: %@", expediaRequestURL);
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:expediaRequestURL
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                // handle response
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                if (error) {
                    NSLog(@"error with expedia package request: %@", error);
                    return;
                }

                NSDictionary *package;
                for (NSDictionary *p in json) {
                    if (!package) {
                        package = p;
                        continue;
                    }
                    NSLog(@"%@", p);
                }
                if (completion) {
                    completion(package);
                }
            }] resume];
}

- (void)tripInfoForOrigin:(CLLocationCoordinate2D)origin destination:(CLLocationCoordinate2D)destination completion:(void (^)(NSDictionary *))completion {
    __block NSDictionary *originAirport;
    __block NSDictionary *destinationAirport;
    [self airportIDForLocation:origin completion:^(NSDictionary *airport) {
        originAirport = airport;
        [self airportIDForLocation:destination completion:^(NSDictionary *airport) {
            destinationAirport = airport;
            [self regionIDForAirport:airport completion:^(NSString *regionID) {
                [self tripInfoForOriginAirport:originAirport destination:destinationAirport destinationID:regionID completion:^(NSDictionary *tripInfo) {
                    if (completion) {
                        completion(tripInfo);
                    }
                }];
            }];
        }];
    }];
}

@end
