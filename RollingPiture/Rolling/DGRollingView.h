//
//  DGRollingView.h
//  RollingPiture
//
//  Created by FSLB on 16/3/22.
//  Copyright © 2016年 FSLB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DGRollingDelagate.h"


@interface DGRollingView : UIView <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>


@property (nonatomic, assign) id<DGRollingViewDataSource> dataSource;
@property (nonatomic, assign) id<DGRollingViewDelegate> delegate;

typedef void(^CompleteBlock)(void);

- (void)reloadDataWithCompleteBlock:(CompleteBlock)competeBlock;


- (instancetype) initWithFrame:(CGRect)frame placeholderImage:(UIImage *)image;

@end
