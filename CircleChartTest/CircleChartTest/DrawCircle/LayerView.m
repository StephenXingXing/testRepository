//
//  LayerView.m
//  CircleTest
//
//  Created by 谢振新 on 16/9/20.
//  Copyright © 2016年 谢振新. All rights reserved.
//

#import "LayerView.h"

@implementation LayerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)drawRect:(CGRect)rect{
    [self labView];
    [self circleBezierPath];
    
    
    if (![self.type isEqualToString:@"1"]) {
        //用定时器模拟数值输入的情况
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                  target:self
                                                selector:@selector(circleAnimationTypeOne)
                                                userInfo:nil
                                                 repeats:YES];
    }
    else{
        [self circleAnimationTypeOne];
    }
    
    //绘制虚线
    //[self createDottedLine];
    
}

-(void)circleBezierPath{
    
    //创建背景
    _BGShapeLayer = [CAShapeLayer layer];   //创建出CAShapeLayer
    _BGShapeLayer.frame = CGRectMake(0, 0, 80,80);
    //    _BGShapeLayer.position = self.center;
    _BGShapeLayer.fillColor = [[UIColor clearColor] CGColor];  //设置填充颜色
    
    // 十六进制字符串转成整形。
    long colorLong1 = strtoul([@"0xf3f3f3" cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
    // 通过位与方法获取三色值
    int R1 = (colorLong1 & 0xFF0000 )>>16;
    int G1 = (colorLong1 & 0x00FF00 )>>8;
    int B1 =  colorLong1 & 0x0000FF;
    
    _BGShapeLayer.strokeColor = [UIColor colorWithRed:R1/255.0 green:G1/255.0 blue:B1/255.0 alpha:1.0].CGColor;
    
    
    _BGShapeLayer.lineWidth = 5.0f;   //设置线条的宽度和颜色
    _BGShapeLayer.strokeStart =0;    //起始位置
    _BGShapeLayer.strokeEnd =1;     //终点
    
    //创建前景
    _shapeLayer = [CAShapeLayer layer];   //创建出CAShapeLayer
    _shapeLayer.frame = CGRectMake(0, 0, 80, 80);
    //    _BGShapeLayer.position = self.center;
    _shapeLayer.fillColor = [[UIColor clearColor] CGColor];  //设置填充颜色
    
    // 十六进制字符串转成整形。
    long colorLong2 = strtoul([@"0x00a0ff" cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
    // 通过位与方法获取三色值
    int R2 = (colorLong2 & 0xFF0000 )>>16;
    int G2 = (colorLong2 & 0x00FF00 )>>8;
    int B2 =  colorLong2 & 0x0000FF;
    
    _shapeLayer.strokeColor = [UIColor colorWithRed:R2/255.0 green:G2/255.0 blue:B2/255.0 alpha:1.0].CGColor;

    
    _shapeLayer.lineWidth = 5.0f;   //设置线条的宽度和颜色
    _shapeLayer.strokeStart = 0;    //起始位置
    //_shapeLayer.strokeEnd =0.75;     //终点

    
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0,80, 80)];
    
    _BGShapeLayer.path = circlePath.CGPath;    //让贝塞尔曲线与CAShapeLayer产生联系
    _shapeLayer.path = circlePath.CGPath;
    
    [self.layer addSublayer:_BGShapeLayer];  //添加并显示
    [self.layer addSublayer:_shapeLayer];
    
}

- (void)circleAnimationTypeOne{
//    if (self.shapeLayer.strokeEnd < 0.5) {
//        self.shapeLayer.strokeEnd += 0.05;
//        CGFloat title = self.shapeLayer.strokeEnd*100;
//        _titleLab.text = [NSString stringWithFormat:@"%.0f%%",title];
//    }else{
//        [_timer invalidate];
//        _timer=nil;
//    }
    
        self.shapeLayer.strokeEnd = _endValue;
        CGFloat title = self.shapeLayer.strokeEnd*100;
        _titleLab.text = [NSString stringWithFormat:@"%.0f%%",title];
    //_titleLab.text = [NSString stringWithFormat:@"100%%"];
    //label的富文本
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:_titleLab.text];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:28.0] range:NSMakeRange(0, _titleLab.text.length-1)];
    [attr addAttribute:NSBaselineOffsetAttributeName value:@10 range:NSMakeRange(_titleLab.text.length-1, 1)];
    _titleLab.numberOfLines = 0;
    _titleLab.attributedText = attr;
    [_titleLab sizeToFit];
    
        [_timer invalidate];
        _timer=nil;
}

//百分比label
-(void)labView{
    _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 70, 70)];  //位置根据View大小设定  View bounds为 100 100;
    _titleLab.textAlignment = NSTextAlignmentCenter;
    //_titleLab.font = [UIFont systemFontOfSize:14];
    _titleLab.textColor = [UIColor blackColor];
    
//    if(![self.type isEqualToString:@"1"]){
//        _titleLab.transform=CGAffineTransformMakeRotation(M_PI/2);
//    }
    
    
    _titleLab.font=[UIFont boldSystemFontOfSize:15.0];
    [self addSubview:_titleLab];
    
}

//-(void)createDottedLine
//{
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    [shapeLayer setBounds:self.bounds];
//    [shapeLayer setPosition:self.center];
//    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
//    
//    // 设置虚线颜色为blackColor
//    [shapeLayer setStrokeColor:[[UIColor blackColor]CGColor]];
//    
//    // 3.0f设置虚线的宽度
//    [shapeLayer setLineWidth:1.0f];
//    [shapeLayer setLineJoin:kCALineJoinRound];
//    
//    // 3 为线的宽度 6 为两条线的间距
//    [shapeLayer setLineDashPattern:
//     [NSArray arrayWithObjects:[NSNumber numberWithInt:3],
//      [NSNumber numberWithInt:6],nil]];
//    
//    // Setup the path
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathMoveToPoint(path, NULL, -70, 100);   //起始位置
//    CGPathAddLineToPoint(path, NULL, 200,150); //终点位置
//    
//    [shapeLayer setPath:path];
//    CGPathRelease(path);
//    // 可以把self改成任何你想要的UIView, 下图演示就是放到UITableViewCell中的
//    [[self layer] addSublayer:shapeLayer];
//}


@end
