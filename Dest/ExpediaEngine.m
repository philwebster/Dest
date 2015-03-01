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

- (NSString *)airportIDForLocation:(CLLocationCoordinate2D)location {
    return @"SFO";
}

//            NSURL *expediaRequestURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://terminal2.expedia.com:80/packages?originAirport=SEA&destinationAirport=ORL&departureDate=2015-03-15&returnDate=2015-03-20&regionid=178294&apikey=%@", @"r3aSGXEhBIJfo6Wm3acwkOZBd3grah7B"]];
//            NSURLSession *session = [NSURLSession sharedSession];
//            [[session dataTaskWithURL:expediaRequestURL
//                    completionHandler:^(NSData *data,
//                                        NSURLResponse *response,
//                                        NSError *error) {
//                        if (error) {
//                            NSLog(@"error with expedia request");
//                            return;
//                        } else {
//                            NSLog(@"got response");
//                        }
//                        // handle response
//                        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//                        self.bestPackage = [[[json[@"PackageSearchResultList"] objectForKey:@"PackageSearchResult"] firstObject] copy];
//                        [self.delegate expediaUrlAdded];
//                    }] resume];
//            NSLog(@"expedia request");
//        }



@end
