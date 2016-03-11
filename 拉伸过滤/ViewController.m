//
//  ViewController.m
//  拉伸过滤
//
//  Created by 刘浩浩 on 16/3/10.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *digitViews;
@property(nonatomic,weak)NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImage *digits = [UIImage imageNamed:@"Digits.png"];
    //set up digit views
    for (UIView *view in self.digitViews) {
        //set contents
        view.layer.contents = (__bridge id)digits.CGImage;
        view.layer.contentsRect = CGRectMake(0, 0, 0.1, 1.0);
        view.layer.contentsGravity = kCAGravityResizeAspect;
//        view.layer.magnificationFilter = kCAFilterNearest;

    }
    //start timer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    //set initial clock time
    [_timer fire];
}
- (void)setDigit:(NSInteger)digit forView:(UILabel *)view
{
    //adjust contentsRect to select correct digit
    view.layer.contentsRect = CGRectMake(digit * 0.1, 0, 0.1, 1.0);
}
- (void)tick
{
    //convert time to hours, minutes and seconds
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    //set hours
    [self setDigit:components.hour / 10 forView:self.digitViews[0]];
    [self setDigit:components.hour % 10 forView:self.digitViews[1]];
    //set minutes
    [self setDigit:components.minute / 10 forView:self.digitViews[2]]; [self setDigit:components.minute % 10 forView:self.digitViews[3]];
    //set seconds
    [self setDigit:components.second / 10 forView:self.digitViews[4]]; [self setDigit:components.second % 10 forView:self.digitViews[5]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
