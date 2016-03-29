//
//  DGRollingDelagate.h
//  RollingPiture
//
//  Created by FSLB on 16/3/22.
//  Copyright © 2016年 FSLB. All rights reserved.
//

#ifndef DGRollingDelagate_h
#define DGRollingDelagate_h

#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height


@protocol DGRollingViewDataSource <NSObject>

@required
/*** 返回图片URL、缺省图 */
- (NSArray *) DGRollingViewURLs;

@optional
/*** 返回滚动方向 默认横向*/
- (UICollectionViewScrollDirection) DGRollingViewDirection;
/*** 是否循环 默认为No */
- (BOOL) DGRollingAllowCircle;
/*** 是否支持小圆点 默认为不支持 */
- (CGRect) DGAddPageControlFrame;

@end

@protocol DGRollingViewDelegate <NSObject>

@required

@optional
/*** 点击Item回调 */
- (void) DGRollingViewDidSelectItemAtIndex:(NSInteger) index;
- (void) DGRollingViewDidEndDeceleratingAtCurrentPage:(NSInteger) index;
@end


#endif /* DGRollingDelagate_h */
