//
//  DGRollingView.m
//  RollingPiture
//
//  Created by FSLB on 16/3/22.
//  Copyright © 2016年 FSLB. All rights reserved.
//

#import "DGRollingView.h"
#import "UIImageView+WebCache.h"
#import "DGImageBrowserLayout.h"
#import "DGCollectionViewCell.h"
#import "Masonry.h"
#import "DGBaseScrollView.h"

@interface DGRollingView ()

@property (nonatomic, strong) NSArray *URLs;


//布局完成回调
@property (strong, nonatomic) CompleteBlock completeBlock;
//默认图
@property (strong, nonatomic) UIImage *placeholderImage;
@property (nonatomic, strong) UIImageView *placeholderImageView;

//滚动控件
@property (nonatomic, strong) UICollectionView *mCollectionView;
@property (nonatomic, strong) DGBaseScrollView *mScrollView;


@end

static NSString *DGImageBrowserCellItemIdentifier = @"DGImageBrowserCellItemIdentifier";

@implementation DGRollingView{
    UICollectionViewScrollDirection mDirection;
}

- (instancetype) initWithFrame:(CGRect)frame placeholderImage:(UIImage *)image andPictuerURL:(NSArray *)URLs{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        self.placeholderImage = image;
        self.URLs = URLs;
    }
    return self;
}


- (void) layoutSubviews{
    [super layoutSubviews];
    //先删除所有子subView
    NSArray *subViews = self.subviews;
    [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self initialize];
    
    if (self.completeBlock) {
        self.completeBlock();
    }
}

- (void)initialize{
    if(self.URLs.count == 0){
        [self addSubview:self.placeholderImageView];
        return;
    }
    mDirection = UICollectionViewScrollDirectionHorizontal;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(DGRollingViewDirection)]){
        mDirection = [self.dataSource DGRollingViewDirection];
    }
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(DGRollingAllowCircle)]){
        if([self.dataSource DGRollingAllowCircle]){
            [self initializeCircleScrollView];
            return;
        }
    }
    [self initializeScrollView];
}
- (void) initializeCircleScrollView{
    [self addSubview:self.mScrollView];
}
- (void) initializeScrollView {
    [self addSubview:self.mCollectionView];
}


#pragma mark - 懒加载
- (UIImageView *) placeholderImageView{
    if(!_placeholderImageView){
        _placeholderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _placeholderImageView.image = _placeholderImage;
    }
    return _placeholderImageView;
}

- (UICollectionView *)mCollectionView{
    if(!_mCollectionView){

        //实例化布局模式
        DGImageBrowserLayout *layout = [[DGImageBrowserLayout alloc] initWithItemSize:CGSizeMake(self.bounds.size.width, self.bounds.size.height) andScrollDirection:mDirection];
        _mCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) collectionViewLayout:layout];
        _mCollectionView.dataSource = self;
        _mCollectionView.delegate = self;
        [_mCollectionView registerClass:[DGCollectionViewCell class]
                forCellWithReuseIdentifier:DGImageBrowserCellItemIdentifier];
        _mCollectionView.pagingEnabled = YES;
        
        _mCollectionView.showsHorizontalScrollIndicator = NO;
        _mCollectionView.showsVerticalScrollIndicator = NO;
        
        
    }
    return _mCollectionView;
}

- (DGBaseScrollView *) mScrollView{
    if(!_mScrollView){
        _mScrollView = [[DGBaseScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) andURLs:_URLs andPlaceholderImage:_placeholderImage andScrollDirection:mDirection];
    }
    return _mScrollView;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.URLs.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DGImageBrowserCellItemIdentifier forIndexPath:indexPath];
    cell.placehoderImage = _placeholderImage;
    cell.imageURL = self.URLs[indexPath.row];
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}

- (void)reloadDataWithCompleteBlock:(CompleteBlock)competeBlock{
    self.completeBlock = competeBlock;
    [self setNeedsLayout];
}
@end
