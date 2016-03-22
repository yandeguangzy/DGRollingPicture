//
//  DGRollingView.m
//  RollingPiture
//
//  Created by FSLB on 16/3/22.
//  Copyright © 2016年 FSLB. All rights reserved.
//

#import "DGRollingView.h"
#import "UIImageView+WebCache.h"

@interface DGRollingView ()
//布局完成回调
@property (strong, nonatomic) CompleteBlock completeBlock;

@property (strong, nonatomic) UIImage *placeholderImage;

@end

@implementation DGRollingView

- (instancetype) initWithFrame:(CGRect)frame placeholderImage:(UIImage *)image{
    self = [super initWithFrame:frame];
    if(self){
        self.placeholderImage = image;
    }
    return self;
}


- (void) layoutSubviews{
    [super layoutSubviews];
    NSLog(@"1");
    //先删除所有子subView
    NSArray *subViews = self.subviews;
    [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    
    if (self.completeBlock) {
        self.completeBlock();
    }
}


- (void)reloadDataWithCompleteBlock:(CompleteBlock)competeBlock{
    self.completeBlock = competeBlock;
    [self setNeedsLayout];
}
@end
