//
//  ViewController.m
//  RollingPiture
//
//  Created by FSLB on 16/3/21.
//  Copyright © 2016年 FSLB. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<DGRollingViewDataSource,DGRollingViewDelegate>

@property (nonatomic, strong) DGRollingView *rollingView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _rollingView = [[DGRollingView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 200) placeholderImage:[UIImage imageNamed:@"200"]];
    _rollingView.delegate = self;
    _rollingView.dataSource = self;
    [self.view addSubview:_rollingView];
    
    
}

- (NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc] initWithObjects:
                      @"http://203.130.45.116:8001/imgUpload/pics20160522060507152.png",
                      @"http://203.130.45.116:8001/imgUpload/pics20161919031954975.jpg",
                      @"http://203.130.45.116:8001/imgUpload/pics2016040602042036.png",
                      @"http://203.130.45.116:8001/imgUpload/pics20160606020645104.jpg", nil];

    }
    return _dataArray;
}



- (UICollectionViewScrollDirection) DGRollingViewDirection{
    return UICollectionViewScrollDirectionHorizontal;
}

- (NSArray *)DGRollingViewURLs{
    return self.dataArray;
}

- (BOOL) DGRollingAllowCircle{
    return YES;
}

- (CGRect) DGAddPageControlFrame{
    return CGRectMake(0, 160, self.view.bounds.size.width, 30);
}

- (void) DGRollingViewDidEndDeceleratingAtCurrentPage:(NSInteger)index{
    NSLog(@"%ld",index);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
