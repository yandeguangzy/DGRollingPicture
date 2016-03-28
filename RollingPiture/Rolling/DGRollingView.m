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
@property (nonatomic, strong) NSMutableArray *temporaryArray;

//是否循环滚动
@property (nonatomic, assign) BOOL isRollingCircle;
//小圆点
@property (nonatomic, strong) UIPageControl *pageControl;

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
    
    //记录循环滚动下当前index
    NSInteger currentIndex;
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
        _isRollingCircle = [self.dataSource DGRollingAllowCircle];
        currentIndex = 0;
    }
    [self initializeScrollView];
}

- (void) initializeScrollView {
    [self addSubview:self.mCollectionView];
    [self addSubview:self.pageControl];
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
        
        if(_isRollingCircle){
            [_mCollectionView setContentOffset:CGPointMake(_mCollectionView.bounds.size.width, 0) animated:NO];
        }
        
        
    }
    return _mCollectionView;
}

- (DGBaseScrollView *) mScrollView{
    if(!_mScrollView){
        _mScrollView = [[DGBaseScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) andURLs:_URLs andPlaceholderImage:_placeholderImage andScrollDirection:mDirection];
        
    }
    return _mScrollView;
}

- (NSMutableArray *) temporaryArray{
    if(!_temporaryArray){
        _temporaryArray = [[NSMutableArray alloc] initWithObjects:_URLs[_URLs.count-1],_URLs[0],_URLs[1>=_URLs.count?0:1], nil];
    }
    return _temporaryArray;
}

- (UIPageControl *) pageControl{
    if(!_pageControl){
        CGRect pageControlFrame = CGRectZero;
        if(self.dataSource && [self.dataSource respondsToSelector:@selector(DGAddPageControlFrame)]){
            pageControlFrame = [self.dataSource DGAddPageControlFrame];
        }
        _pageControl = [[UIPageControl alloc] initWithFrame:pageControlFrame];
        _pageControl.numberOfPages = _URLs.count;
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:39/255.0 green:120/255.0 blue:211/255.0 alpha:1];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        
    }
    return _pageControl;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(_isRollingCircle){
        return 3;
    }
    return self.URLs.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DGImageBrowserCellItemIdentifier forIndexPath:indexPath];
    cell.placehoderImage = _placeholderImage;
    if (_isRollingCircle){
        cell.imageURL = self.temporaryArray[indexPath.row];
    }else{
        cell.imageURL = self.URLs[indexPath.row];
    }
    
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(!_isRollingCircle){
        return;
    }
    if(scrollView.contentOffset.x == scrollView.bounds.size.width){
        return;
    }
    if(scrollView.contentOffset.x == 0){
        currentIndex = currentIndex-1<0?_URLs.count-1:currentIndex-1;
    }else{
        currentIndex = currentIndex+1>=_URLs.count?0:currentIndex+1;
    }
    [self updateTemporArray];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    float pagecount = scrollView.contentOffset.x/scrollView.frame.size.width-0.5;
    NSLog(@"%f",pagecount);
    if(pagecount <= 0){
        _pageControl.currentPage = currentIndex - 1 < 0?_URLs.count - 1:currentIndex-1;
    }else if (0 < pagecount && pagecount <= 1){
        _pageControl.currentPage = currentIndex;
    }else{
        _pageControl.currentPage = currentIndex + 1 >= _URLs.count?0:currentIndex + 1;
    }
    
}

- (void) updateTemporArray{
    [self.temporaryArray removeAllObjects];
    [_temporaryArray addObject:_URLs[currentIndex-1<0?_URLs.count-1:currentIndex-1]];
    [_temporaryArray addObject:_URLs[currentIndex]];
    [_temporaryArray addObject:_URLs[currentIndex+1>=_URLs.count?0:currentIndex+1]];
    [_mCollectionView reloadData];
    
    [_mCollectionView setContentOffset:CGPointMake(_mCollectionView.bounds.size.width, 0) animated:NO];
}

- (void)reloadDataWithCompleteBlock:(CompleteBlock)competeBlock{
    self.completeBlock = competeBlock;
    [self setNeedsLayout];
}
@end
