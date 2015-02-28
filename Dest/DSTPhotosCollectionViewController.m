//
//  DSTPhotosCollectionViewController.m
//  Dest
//
//  Created by Philip Webster on 2/27/15.
//  Copyright (c) 2015 phil. All rights reserved.
//

#import "DSTPhotosCollectionViewController.h"
#import "InstagramKit.h"
#import "DSTPhotoCollectionViewCell.h"
@import CoreLocation;

@interface DSTPhotosCollectionViewController ()

@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) InstagramPaginationInfo *currentPaginationInfo;

@end

@implementation DSTPhotosCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"DSTPhotoCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];

    // Do any additional setup after loading the view.
    [self loadPhotos];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadPhotos {
    InstagramEngine *sharedEngine = [InstagramEngine sharedEngine];
    if (sharedEngine.accessToken)
    {
        [[InstagramEngine sharedEngine] getSelfFeedWithCount:15 maxId:self.currentPaginationInfo.nextMaxId success:^(NSArray *media, InstagramPaginationInfo *paginationInfo) {
            self.currentPaginationInfo = paginationInfo;
            
            [self.photos addObjectsFromArray:media];
            
            [self reloadData];
        } failure:^(NSError *error) {
            NSLog(@"Request Self Feed Failed");
        }];
    }
}

- (void)reloadData {
    [self.collectionView reloadData];
}

- (NSMutableArray *)photos {
    if (!_photos) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



#pragma mark <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.frame.size.width, self.view.frame.size.width + 100);
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DSTPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.cellMedia = [self.photos objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
