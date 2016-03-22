//
//  DGRollingView.h
//  RollingPiture
//
//  Created by FSLB on 16/3/22.
//  Copyright © 2016年 FSLB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DGRollingDelagate.h"


@interface DGRollingView : UIView

typedef void(^CompleteBlock)(void);
- (void)reloadDataWithCompleteBlock:(CompleteBlock)competeBlock;






- (instancetype) initWithFrame:(CGRect)frame placeholderImage:(UIImage *)image;

@end
