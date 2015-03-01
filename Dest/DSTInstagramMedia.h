//
//  DSTInstagramMedia.h
//  Dest
//
//  Created by Philip Webster on 2/28/15.
//  Copyright (c) 2015 phil. All rights reserved.
//

#import "InstagramMedia.h"
@import MapKit;

@protocol mediaUpdateDelegate

- (void)expediaUrlAdded;
- (void)directionsAdded;

@end

@interface DSTInstagramMedia : NSObject

@property (nonatomic, readonly) MKMapItem *mapItem;
@property (nonatomic, readonly) MKRoute *route;
@property (nonatomic, readonly) NSDictionary *expediaResponse;
@property (nonatomic, strong) NSDictionary *bestPackage;
@property (nonatomic, strong) id<mediaUpdateDelegate> delegate;
@property (nonatomic, strong) InstagramMedia *media;

- (id)initWithIGMedia:(InstagramMedia *)media;

@end
