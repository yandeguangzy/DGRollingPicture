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


@optional
/*** 返回滚动方向 默认横向*/
- (UICollectionViewScrollDirection) DGRollingViewDirection;
/*** 是否循环 默认为No */
- (BOOL)DGRollingAllowCircle;

@end

@protocol DGRollingViewDelegate <NSObject>

@required

@optional

@end


#endif /* DGRollingDelagate_h */
