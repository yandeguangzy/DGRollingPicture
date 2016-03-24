//
//  DGCollectionViewCell.m
//  RollingPiture
//
//  Created by FSLB on 16/3/24.
//  Copyright © 2016年 FSLB. All rights reserved.
//

#import "DGCollectionViewCell.h"

@implementation DGCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.zoomScrollView];
        self.zoomScrollView.successBlock = ^(UIImage *image){
            NSLog(@"下载成功");
        };
    }
    return self;
}

- (void) setImageURL:(NSString *)imageURL{
    _imageURL = imageURL;
    self.zoomScrollView.imageURL = _imageURL;
    self.zoomScrollView.placehoderImage = _placehoderImage;
}

- (DGZoomScrollView *)zoomScrollView{
    if(!_zoomScrollView){
        _zoomScrollView = [[DGZoomScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    }
    return _zoomScrollView;
}
@end
