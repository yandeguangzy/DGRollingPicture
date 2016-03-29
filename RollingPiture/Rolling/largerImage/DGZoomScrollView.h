//
//  DGZoomScrollView.h
//  RollingPiture
//
//  Created by FSLB on 16/3/24.
//  Copyright © 2016年 FSLB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DGZoomScrollView : UIScrollView

@property (nonatomic, strong) UIImageView *mImageView;

@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) UIImage *placehoderImage;

//加载完成回调
@property (nonatomic, strong) void (^successBlock)(UIImage *image);

@end
