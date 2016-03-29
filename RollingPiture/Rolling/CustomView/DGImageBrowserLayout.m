//
//  DGImageBrowserLayout.m
//  RollingPiture
//
//  Created by FSLB on 16/3/23.
//  Copyright © 2016年 FSLB. All rights reserved.
//

#import "DGImageBrowserLayout.h"

@implementation DGImageBrowserLayout

- (instancetype)initWithItemSize:(CGSize)size andScrollDirection:(UICollectionViewScrollDirection)direction{
    self = [super init];
    if(self){
        self.itemSize = size;
        [self setScrollDirection:direction];
        self.minimumInteritemSpacing = 0.0f;
        self.minimumLineSpacing = 0.0f;
        self.sectionInset = UIEdgeInsetsZero;
        self.footerReferenceSize = CGSizeZero;
        self.headerReferenceSize = CGSizeZero;
        
    }
    return self;
}

//- (CGSize) collectionViewContentSize{
//    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
//    
//    CGFloat contentSize_W = self.itemSize.width * itemCount;
//    CGSize contentSize = CGSizeMake(contentSize_W, self.itemSize.height);
//    return contentSize;
//}

@end
