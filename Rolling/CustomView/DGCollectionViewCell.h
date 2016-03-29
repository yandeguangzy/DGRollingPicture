//
//  DGCollectionViewCell.h
//  RollingPiture
//
//  Created by FSLB on 16/3/24.
//  Copyright © 2016年 FSLB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DGZoomScrollView.h"

@interface DGCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) UIImage *placehoderImage;

@property (nonatomic, strong) DGZoomScrollView *zoomScrollView;

@end
