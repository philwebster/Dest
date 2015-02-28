//
//  DSTDestinationDataView.m
//  Dest
//
//  Created by Philip Webster on 2/27/15.
//  Copyright (c) 2015 phil. All rights reserved.
//

#import "DSTDestinationDataView.h"
@import MapKit;

@implementation DSTDestinationDataView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {        
        NSString *className = NSStringFromClass([self class]);
        self.container = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] firstObject];
        self.container.frame = self.bounds;
        [self addSubview:self.container];
        [self.mapButton setTitle:@"Road trip" forState:UIControlStateNormal];
        [self.mapButton addTarget:self action:@selector(openInMaps) forControlEvents:UIControlEventTouchUpInside];
        [self.mapButton setHidden:YES];
        [self.expediaButton setTitle:@"Expedia" forState:UIControlStateNormal];
        [self.expediaButton addTarget:self action:@selector(openExpedia) forControlEvents:UIControlEventTouchUpInside];

        return self;
    }
    return nil;
}

- (void)setMedia:(InstagramMedia *)media {
    _media = media;
    [self.nameLabel setText:media.locationName];
    if (_media.bestPackage[@"DetailsUrl"]) {
        self.expediaButton.hidden = NO;
    }
    if (_media.directions || YES) {
        self.mapButton.hidden = YES;
    }
}

- (void)setDataForMedia:(InstagramMedia *)cellMedia {
    [self.nameLabel setText:cellMedia.locationName];
    
//    if (cellMedia.directions.routes.count > 0 && [cellMedia.directions.routes.firstObject expectedTravelTime] < 18000 || YES) {
//        MKRoute *firstRoute = cellMedia.directions.routes.firstObject;
//        CGFloat expectedTimeInSeconds = [firstRoute expectedTravelTime];
//        
//        long seconds = lroundf(expectedTimeInSeconds); // Modulo (%) operator below needs int or long
//        
//        int hour = seconds / 3600;
//        int mins = (seconds % 3600) / 60;
//        
//        NSString *timeString = [NSString stringWithFormat:@"%d %@ %d %@ drive", hour, @"hour", mins, @"minute"];
//        [self.travelButton setTitle:timeString forState:UIControlStateNormal];
//    } else {
//        [self.travelButton setTitle:@"Flights" forState:UIControlStateNormal];
//    }
}

- (void)openInMaps {
    [MKMapItem openMapsWithItems:@[_media.mapItem] launchOptions:@{MKLaunchOptionsDirectionsModeKey : @"hi"}];
}

- (void)openExpedia {
    NSString *urlString = [[_media.bestPackage objectForKey:@"DetailsUrl"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (!urlString) {
        return;
    }
    NSURL *expediaURL = [[NSURL alloc] initWithString:urlString];
    [[UIApplication sharedApplication] openURL:expediaURL];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.google.com"]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
