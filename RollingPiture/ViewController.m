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
    
    _rollingView = [[DGRollingView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 200) placeholderImage:[UIImage imageNamed:@"200"] andPictuerURL:self.dataArray];
    _rollingView.delegate = self;
    _rollingView.dataSource = self;
    [self.view addSubview:_rollingView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 300, 90, 90);
    btn.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:btn];
    
    [btn setImage:[UIImage imageNamed:@"21"] forState:UIControlStateNormal];
     btn.imageEdgeInsets = UIEdgeInsetsMake(0,24,50,24);
    
    [btn setTitle:@"首页" forState:UIControlStateNormal];
    btn.titleLabel.frame = CGRectMake(0, 0, btn.bounds.size.width, 16);
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
     btn.titleEdgeInsets = UIEdgeInsetsMake(40, 0, 0, 0);
    
    btn.imageView.backgroundColor = [UIColor redColor];
    btn.titleLabel.backgroundColor = [UIColor blackColor];
    
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    NSLog(@"%f",btn.imageView.bounds.origin.x);
    
    [btn addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
}

- (NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc] initWithObjects:
                      @"http://203.130.45.116:8001/imgUpload/pics20160522060507152.png",
                      @"http://203.130.45.116:8001/imgUpload/pics20161919031954975.jpg",
                      @"http://203.130.45.116:8001/imgUpload/pics2016040602042036.png",
                      @"http://203.130.45.116:8001/imgUpload/pics20162405042453466.jpg",
                      @"http://203.130.45.116:8001/imgUpload/pics20160606020645104.jpg", nil];
    }
    return _dataArray;
}

- (void)test:(id)sender {
    [_rollingView reloadDataWithCompleteBlock:^{
        NSLog(@"2");
    }];
}


- (BOOL) DGRollingAllowCircle{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
