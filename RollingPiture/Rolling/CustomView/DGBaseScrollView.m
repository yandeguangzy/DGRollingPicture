//
//  DGBaseScrollView.m
//  RollingPiture
//
//  Created by FSLB on 16/3/24.
//  Copyright © 2016年 FSLB. All rights reserved.
//

#import "DGBaseScrollView.h"
#import "UIImageView+WebCache.h"

@implementation DGBaseScrollView{
    BOOL mdirection;//NO:横向  YES:纵向
    
    //NSInteger currentIndex;
}

- (instancetype) initWithFrame:(CGRect)frame andURLs:(NSArray *)urls andPlaceholderImage:(UIImage *)placeholderImage andScrollDirection:(UICollectionViewScrollDirection)direction{
    self = [super initWithFrame:frame];
    if(self){
        self.urls = urls;
        self.placeholderImage = placeholderImage;
        
        self.contentSize = CGSizeMake(self.bounds.size.width*3, self.bounds.size.height);
        self.delegate = self;
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        switch (direction) {
            case UICollectionViewScrollDirectionHorizontal:
                mdirection = NO;
                [self setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:NO];
                 [self initializeWithHorizontal];
                break;
            case UICollectionViewScrollDirectionVertical:
                mdirection = YES;
                [self setContentOffset:CGPointMake(0, self.bounds.size.height) animated:NO];
                 [self initializeWithVertical];
                break;
            default:
                [self initializeWithHorizontal];
                break;
        }
       
    }
    return self;
}
- (void) initializeWithHorizontal{
    for (int i = 0; i<3; i++) {
        _mImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width * i, 0, self.bounds.size.width, self.bounds.size.height)];
        
        NSString *URlPath;
        switch (i) {
            case 0:
                URlPath = [self.urls[i-1 < 0?self.urls.count - 1:i - 1] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                break;
            case 1:
                URlPath = [self.urls[i] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                break;
            case 2:
                URlPath = [self.urls[i+1 >= self.urls.count?0:i + 1] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                break;
            default:
                break;
        }
        [_mImageView sd_setImageWithURL:[NSURL URLWithString:URlPath] placeholderImage:_placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        [self addSubview:_mImageView];
    }
    [self updateData:0];
}


- (void) initializeWithVertical{
    for (int i = 0; i<3; i++) {
        _mImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height * i, self.bounds.size.width, self.bounds.size.height)];
        _mImageView.tag = i;
         NSString *URlPath = [self.urls[i] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [_mImageView sd_setImageWithURL:[NSURL URLWithString:URlPath] placeholderImage:_placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        [self addSubview:_mImageView];
    }
}

- (void) updateData:(NSInteger)currentIndex{
    
    }

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
