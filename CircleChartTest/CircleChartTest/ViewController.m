//
//  ViewController.m
//  CircleChartTest
//
//  Created by 谢振新 on 17/8/8.
//  Copyright © 2017年 谢振新. All rights reserved.
//

#import "ViewController.h"

#import "LayerView.h"

@interface ViewController ()

{
    LayerView *_la1;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self customChart];
    
}

//定制图表
-(void)customChart{
    //课程完成率
    _la1 = [[LayerView alloc]init];
    _la1.backgroundColor = [UIColor clearColor];
    _la1.frame = CGRectMake(100, 100, 60, 60);
    
    _la1.endValue=0.5;
    
    [self.view addSubview:_la1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
