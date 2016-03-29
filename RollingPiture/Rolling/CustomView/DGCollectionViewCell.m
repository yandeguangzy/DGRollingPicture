//
//  DGCollectionViewCell.m
//  RollingPiture
//
//  Created by FSLB on 16/3/24.
//  Copyright © 2016年 FSLB. All rights reserved.
//

#import "DGCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface DGCollectionViewCell ()

@property (nonatomic, strong) UIImageView *mImageView;

@end

@implementation DGCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.mImageView];
    }
    return self;
}

- (void) setImageURL:(NSString *)imageURL{
    _imageURL = imageURL;
    _imageURL = [_imageURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.mImageView sd_setImageWithURL:[NSURL URLWithString:_imageURL] placeholderImage:_placehoderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];

}

- (UIImageView *)mImageView{
    if(!_mImageView){
        _mImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _mImageView.backgroundColor = [UIColor cyanColor];
    }
    return _mImageView;
}

@end
