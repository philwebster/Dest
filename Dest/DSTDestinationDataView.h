//
//  DSTDestinationDataView.h
//  Dest
//
//  Created by Philip Webster on 2/27/15.
//  Copyright (c) 2015 phil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstagramKit.h"

@interface DSTDestinationDataView : UIView

@property (nonatomic, weak) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *travelButton;
@property (weak, nonatomic) InstagramMedia *media;

@end
