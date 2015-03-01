//
//  DSTDestinationDataView.h
//  Dest
//
//  Created by Philip Webster on 2/27/15.
//  Copyright (c) 2015 phil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSTInstagramMedia.h"

@interface DSTDestinationDataView : UIView

@property (nonatomic, weak) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *mapButton;
@property (weak, nonatomic) IBOutlet UIButton *expediaButton;
@property (weak, nonatomic) IBOutlet UILabel *photographerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *starImageView;
@property (weak, nonatomic) IBOutlet UIImageView *planeImageView;
@property (weak, nonatomic) DSTInstagramMedia *media;

- (void)updateButtons;

@end
