//
//  DSTPhotoCollectionViewCell.m
//  Dest
//
//  Created by Philip Webster on 2/27/15.
//  Copyright (c) 2015 phil. All rights reserved.
//

#import "DSTPhotoCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface DSTPhotoCollectionViewCell ()

@end

@implementation DSTPhotoCollectionViewCell

- (void)setCellMedia:(InstagramMedia *)cellMedia {
    _cellMedia = cellMedia;
    
    [self.imageView setImageWithURL:cellMedia.standardResolutionImageURL];
    [self.destinationDataView setMedia:cellMedia];
}

- (void)expediaUrlAdded {
    self.destinationDataView.expediaButton.hidden = NO;
}

- (void)directionsAdded {
    self.destinationDataView.mapButton.hidden = YES;
}

- (void)prepareForReuse {
    self.destinationDataView.expediaButton.hidden = YES;
    self.destinationDataView.mapButton.hidden = YES;
}

@end
