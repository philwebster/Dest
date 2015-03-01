//
//  DSTDestinationDataView.m
//  Dest
//
//  Created by Philip Webster on 2/27/15.
//  Copyright (c) 2015 phil. All rights reserved.
//

#import "DSTDestinationDataView.h"
#import "MapEngine.h"
#import "InstagramKit.h"

@import MapKit;

@interface DSTDestinationDataView ()

@property UITapGestureRecognizer *tapRecognizer;
@property UIImage *starImage;

@end

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
        [self.expediaButton setTitle:@"Expedia" forState:UIControlStateNormal];
        [self.expediaButton addTarget:self action:@selector(openExpedia) forControlEvents:UIControlEventTouchUpInside];
        self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(starTapped)];
        [self.starImageView addGestureRecognizer:self.tapRecognizer];
        [self.starImageView setUserInteractionEnabled:YES];
        self.starImage = [[UIImage imageNamed:@"Star-50"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.starImageView.tintColor = [UIColor colorWithWhite:0.702 alpha:1.000];
        self.planeImageView.tintColor = [UIColor colorWithWhite:0.333 alpha:1.000];
        self.starImageView.image = self.starImage;
        return self;
    }
    return nil;
}

- (void)starTapped {
    if (_media.starred) {
        self.starImageView.tintColor = [UIColor colorWithWhite:0.702 alpha:1.000];
    } else {
        self.starImageView.tintColor = [UIColor colorWithRed:0.996 green:0.824 blue:0.333 alpha:1.000];
    }
    _media.starred = !_media.starred;
}

- (void)setMedia:(DSTInstagramMedia *)media {
    _media = media;
    [self.nameLabel setText:media.media.locationName];
    [self.photographerLabel setText:[NSString stringWithFormat:@"by %@", media.media.user.fullName]];
    [self updateButtons];

    if (media.starred) {
        self.starImageView.tintColor = [UIColor colorWithRed:0.996 green:0.824 blue:0.333 alpha:1.000];
    } else {
        self.starImageView.tintColor = [UIColor colorWithWhite:0.702 alpha:1.000];
    }
}

- (void)updateButtons {
        if (_media.route) {
            NSString *routeTime = [MapEngine driveTimeFromTimeInterval:[_media.route expectedTravelTime]];
            [self.mapButton setTitle:routeTime forState:UIControlStateNormal];
            [self.mapButton setEnabled:YES];
        } else {
            [self.mapButton setTitle:@"" forState:UIControlStateDisabled];
            [self.mapButton setEnabled:NO];
        }
        if (_media.tripInfo) {
            if ([_media.route expectedTravelTime] < 10000) {
                [self.expediaButton setTitle:@"No flights" forState:UIControlStateDisabled];
                [self.expediaButton setEnabled:NO];
            }
            if (_media.tripInfo.count > 0) {
                NSString *flyString = [NSString stringWithFormat:@"$%@", _media.tripInfo[@"PackagePrice"][@"TotalPrice"][@"Value"]];
                [self.expediaButton setEnabled:YES];
                [self.expediaButton setTitle:flyString forState:UIControlStateNormal];
            }
        } else {
            if (!_media.hasFlights) {
                [self.expediaButton setTitle:@"No flights" forState:UIControlStateDisabled];
                [self.expediaButton setEnabled:NO];
            } else {
                [self.expediaButton setTitle:@"Retrieving Flights" forState:UIControlStateDisabled];
                [self.expediaButton setEnabled:NO];
            }
        }
}

- (void)setDataForMedia:(DSTInstagramMedia *)cellMedia {
    [self.nameLabel setText:cellMedia.media.locationName];
    [self updateButtons];
}

- (void)openInMaps {
    [MKMapItem openMapsWithItems:@[_media.mapItem] launchOptions:@{MKLaunchOptionsDirectionsModeKey : @"hi"}];
}

- (void)openExpedia {
    NSString *urlString = [[_media.tripInfo objectForKey:@"DetailsUrl"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (!urlString) {
        return;
    }
    NSURL *expediaURL = [[NSURL alloc] initWithString:urlString];
    [[UIApplication sharedApplication] openURL:expediaURL];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
