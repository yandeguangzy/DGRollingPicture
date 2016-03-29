//
//  DGZoomScrollView.m
//  RollingPiture
//
//  Created by FSLB on 16/3/24.
//  Copyright © 2016年 FSLB. All rights reserved.
//

#import "DGZoomScrollView.h"
#import "UIImageView+WebCache.h"

@implementation DGZoomScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        [self addSubview:self.mImageView];
    }
    return self;
}

- (UIImageView *)mImageView{
    if(!_mImageView){
        _mImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _mImageView.backgroundColor = [UIColor cyanColor];
    }
    return _mImageView;
}

- (void) setImageURL:(NSString *)imageURL{
    _imageURL = imageURL;
    _imageURL = [_imageURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.mImageView sd_setImageWithURL:[NSURL URLWithString:_imageURL] placeholderImage:_placehoderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (_successBlock){
            _successBlock(image);
        }
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
