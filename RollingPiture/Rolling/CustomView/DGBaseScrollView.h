//
//  DGBaseScrollView.h
//  RollingPiture
//
//  Created by FSLB on 16/3/24.
//  Copyright © 2016年 FSLB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DGBaseScrollView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *urls;
@property (nonatomic, strong) UIImage *placeholderImage;
@property (nonatomic, strong) UIImageView *mImageView;

- (instancetype) initWithFrame:(CGRect)frame andURLs:(NSArray *)urls andPlaceholderImage:(UIImage *)placeholderImage andScrollDirection:(UICollectionViewScrollDirection)direction;

@end
