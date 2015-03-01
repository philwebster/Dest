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

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.contentView.translatesAutoresizingMaskIntoConstraints = YES;
}

- (void)setCellMedia:(DSTInstagramMedia *)cellMedia {
    _cellMedia = cellMedia;
    [self.imageView setImageWithURL:cellMedia.media.standardResolutionImageURL];
    [self.destinationDataView setMedia:cellMedia];
    [_cellMedia addObserver:self forKeyPath:@"route" options:0 context:NULL];
    [_cellMedia addObserver:self forKeyPath:@"tripInfo" options:0 context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([keyPath isEqual:@"route"]) {
            NSLog(@"notification for route");
            [self.destinationDataView updateButtons];
        }
        if ([keyPath isEqual:@"tripInfo"]) {
            NSLog(@"notification for tripInfo");
                [self.destinationDataView updateButtons];
        }
    });
}

- (void)prepareForReuse {
    [self.destinationDataView.expediaButton setTitle:@"Retrieving Flights" forState:UIControlStateDisabled];
    [self.destinationDataView.mapButton setTitle:@"Road trip" forState:UIControlStateDisabled];
    self.imageView.image = nil;
}

@end
