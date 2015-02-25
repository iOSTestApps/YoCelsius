//
//  SunInfoView.m
//  YXMWeather
//
//  Created by XianMingYou on 15/2/21.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import "SunInfoView.h"
#import "SunriseView.h"
#import "SunsetView.h"
#import "TitleMoveLabel.h"


@interface SunInfoStoreValue : NSObject
@property (nonatomic) CGRect  startRect;
@property (nonatomic) CGRect  midRect;
@property (nonatomic) CGRect  endRect;
@end
@implementation SunInfoStoreValue
@end


@interface SunInfoView ()

@property (nonatomic, strong) TitleMoveLabel     *movetitleLabel;

@property (nonatomic, strong) SunriseView        *sunriseView;
@property (nonatomic, strong) UILabel            *sunriseTimeLabel;
@property (nonatomic, strong) SunInfoStoreValue  *sunriseViewStoreValue;

@property (nonatomic, strong) SunsetView         *sunsetView;
@property (nonatomic, strong) UILabel            *sunsetTimeLabel;
@property (nonatomic, strong) SunInfoStoreValue  *sunsetViewStoreValue;

@end


@implementation SunInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.sunsireValue = [SunriseAndSunset new];
        self.sunsetValue  = [SunriseAndSunset new];
    }
    return self;
}

/**
 *  创建出view
 */
- (void)buildView {
    
    self.movetitleLabel = [TitleMoveLabel withText:@"Sunrise & Sunset"];
    [self.movetitleLabel buildView];
    [self addSubview:self.movetitleLabel];
    
    // 日出的view
    self.sunriseView = [[SunriseView alloc] initWithFrame:CGRectMake(45, 50, 40, 80)];
    [self.sunriseView buildView];
    [self addSubview:self.sunriseView];
    self.sunriseViewStoreValue = [SunInfoStoreValue new];
    self.sunriseViewStoreValue.midRect = self.sunriseView.frame;
    self.sunriseView.y += 10;
    self.sunriseViewStoreValue.startRect = self.sunriseView.frame;
    self.sunriseView.y -= 20;
    self.sunriseViewStoreValue.endRect = self.sunriseView.frame;
    self.sunriseView.frame = self.sunriseViewStoreValue.startRect;
    
    // 日出时间标签
    self.sunriseTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 40, 20)];
    self.sunriseTimeLabel.alpha = 0.f;
    self.sunriseTimeLabel.textAlignment = NSTextAlignmentCenter;
    self.sunriseTimeLabel.font = [UIFont fontWithName:LATO_BOLD size:LATO_10];
    [self.sunriseView addSubview:self.sunriseTimeLabel];

    
    
    // 日落的view
    self.sunsetView = [[SunsetView alloc] initWithFrame:CGRectMake(95, 40, 40, 80)];
    [self.sunsetView buildView];
    [self addSubview:self.sunsetView];
    self.sunsetViewStoreValue = [SunInfoStoreValue new];
    self.sunsetViewStoreValue.midRect = self.sunsetView.frame;
    self.sunsetView.y -= 10;
    self.sunsetViewStoreValue.startRect = self.sunsetView.frame;
    self.sunsetView.y += 20;
    self.sunsetViewStoreValue.endRect = self.sunsetView.frame;
    self.sunsetView.frame = self.sunsetViewStoreValue.startRect;
    
    // 日落时间标签
    self.sunsetTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 40, 20)];
    self.sunsetTimeLabel.textAlignment = NSTextAlignmentCenter;
    self.sunsetTimeLabel.alpha = 0.f;
    self.sunsetTimeLabel.font = [UIFont fontWithName:LATO_BOLD size:LATO_10];
    [self.sunsetView addSubview:self.sunsetTimeLabel];
}

/**
 *  显示
 */
- (void)show {

    [self.movetitleLabel show];
    
    // 动画持续时间
    CGFloat duration = 1.75f;
    
    // 日出动画
    [self.sunriseView showWithDuration:1.5];
    
    // 日落动画
    [self.sunsetView showWithDuration:1.5];
    
    [UIView animateWithDuration:duration animations:^{
        
        self.sunriseView.frame = self.sunriseViewStoreValue.midRect;
        self.sunsetView.frame = self.sunsetViewStoreValue.midRect;
        
        self.sunriseTimeLabel.text  = self.sunsireValue.timeString;
        self.sunriseTimeLabel.alpha = 1.f;
        
        self.sunsetTimeLabel.text   = self.sunsetValue.timeString;
        self.sunsetTimeLabel.alpha  = 1.f;
    }];
}

/**
 *  隐藏
 */
- (void)hide {
    CGFloat duration = 0.75f;
    
        [self.movetitleLabel hide];
    
    // 日出动画隐藏
    [self.sunriseView hideWithDuration:duration];
    
    // 日落动画隐藏
    [self.sunsetView hideWithDuration:duration];
    
    [UIView animateWithDuration:duration animations:^{
        self.sunriseView.frame = self.sunriseViewStoreValue.endRect;
        self.sunsetView.frame = self.sunsetViewStoreValue.endRect;
        
        self.sunriseTimeLabel.alpha = 0.f;
        self.sunsetTimeLabel.alpha = 0.f;
    } completion:^(BOOL finished) {
        self.sunriseView.frame = self.sunriseViewStoreValue.startRect;
        self.sunsetView.frame = self.sunsetViewStoreValue.startRect;
    }];
}

@end