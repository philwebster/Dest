//
//  DSTPhotoCollectionViewCell.m
//  Dest
//
//  Created by Philip Webster on 2/27/15.
//  Copyright (c) 2015 phil. All rights reserved.
//

#import "DSTPhotoCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "MapEngine.h"

@interface DSTPhotoCollectionViewCell ()

@end

@implementation DSTPhotoCollectionViewCell

- (void)setCellMedia:(DSTInstagramMedia *)cellMedia {
    _cellMedia = cellMedia;
    [self.imageView setImageWithURL:cellMedia.media.standardResolutionImageURL];
    [self.destinationDataView setMedia:cellMedia];
    [_cellMedia addObserver:self forKeyPath:@"route" options:0 context:NULL];
}

- (void)expediaUrlAdded {
    NSLog(@"expediaUrlAdded");
//    [self.destinationDataView.expediaButton setTitle:[NSString stringWithFormat:@"Expedia: %@", _cellMedia.bestPackage[@"PackagePrice"][@"TotalPrice"][@"Value"]] forState:UIControlStateNormal];
//    self.destinationDataView.expediaButton.hidden = NO;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    
    if ([keyPath isEqual:@"route"]) {
        [self directionsAdded:_cellMedia.route];
    }
}

- (void)directionsAdded:(MKRoute *)route {
    [self.destinationDataView updateButtons];
//    NSString *routeTime = [MapEngine driveTimeFromTimeInterval:[route expectedTravelTime]];
//    [self.destinationDataView.mapButton setTitle:routeTime forState:UIControlStateNormal];
//    NSLog(@"updated directions button");
}

- (void)prepareForReuse {
//    self.destinationDataView.expediaButton.hidden = YES;
//    self.destinationDataView.mapButton.hidden = YES;

    self.imageView.image = nil;
    self.cellMedia.delegate = nil;
}

@end
