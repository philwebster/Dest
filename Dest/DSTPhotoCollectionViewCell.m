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
    NSString *coordinateString = [NSString stringWithFormat:@"%f, %f", cellMedia.location.latitude, cellMedia.location.longitude];
    [self.destinationDataView.coordLabel setText:coordinateString];
}

@end
