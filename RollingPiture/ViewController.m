//
//  ViewController.m
//  RollingPiture
//
//  Created by FSLB on 16/3/21.
//  Copyright © 2016年 FSLB. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) DGRollingView *rollingView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _rollingView = [[DGRollingView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 200)];
    [self.view addSubview:_rollingView];
}
- (IBAction)test:(id)sender {
    [_rollingView reloadDataWithCompleteBlock:^{
        NSLog(@"2");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
