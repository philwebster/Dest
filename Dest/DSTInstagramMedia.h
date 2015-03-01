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
- (void)directionsAdded:(MKRoute *)route;

@end

@interface DSTInstagramMedia : NSObject

@property (nonatomic, readonly) MKMapItem *mapItem;
@property (nonatomic, strong) MKRoute *route;
@property (nonatomic, strong) NSDictionary *tripInfo;
@property (nonatomic, strong) id<mediaUpdateDelegate> delegate;
@property (nonatomic, strong) InstagramMedia *media;

- (id)initWithIGMedia:(InstagramMedia *)media;
- (void)populateDirections;
- (void)populateTripInfo;

@end
