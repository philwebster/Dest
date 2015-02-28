//
//  DSTPhotoCollectionViewCell.h
//  Dest
//
//  Created by Philip Webster on 2/27/15.
//  Copyright (c) 2015 phil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSTDestinationDataView.h"
#import "InstagramKit.h"

@interface DSTPhotoCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet DSTDestinationDataView *destinationDataView;
@property (nonatomic, strong) InstagramMedia *cellMedia;

@end
