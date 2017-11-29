//
//  AZPromptView.m
//  AZPromptView
//
//  Created by tianfengyu on 14/07/2017.
//  Copyright © 2017 Azreal. All rights reserved.
//

#import "AZPromptView.h"

@interface AZPromptView ()

// MARK: - 控件
@property (nonatomic, strong) UIView *promptView;
@property (nonatomic, strong) UILabel *promptLabel;
@property (nonatomic, strong) dispatch_source_t timer;

@property (nonatomic, copy) NSString *text;

// MARK: - 属性
@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, assign) CGFloat screenPadding;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat fontsize;
@property (nonatomic, assign) CGFloat backAlpha;

@end

@implementation AZPromptView

+ (void)show:(NSString *)text {
    [AZPromptView share].text = text;
}
+ (void)show:(NSString *)text hideKeyboardView:(UIView *)hideKeyboardView {
    [hideKeyboardView endEditing:true];
    [AZPromptView share].text = text;
}

+ (AZPromptView *)share {
    if (!_instance) {
        _instance = [[AZPromptView alloc] init];
    }
    return _instance;
}

// 1.
static id _instance;

/**
 * 2.用GCD的dispatch_once方法重写
 */
+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

// 3.
+ (instancetype)sharedMusicTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

// 4.
- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _padding = 80;
        _screenPadding = 80;
        _height = 40;
        _fontsize = 15;
        _backAlpha = 0.7;
        [self loadView];
    }
    return self;
}

- (void)loadView {
    [self loadSelf];
    [self loadPrompt];
}

- (void)loadSelf {
    self.layer.cornerRadius = 5;
    self.clipsToBounds = true;
    self.userInteractionEnabled = false;
    self.alpha = 0;
}

- (void)loadPrompt {
    _promptView.alpha = _backAlpha;
    _promptView.backgroundColor = UIColor.blackColor;
    _promptLabel.textAlignment = NSTextAlignmentCenter;
    _promptLabel.font = [UIFont systemFontOfSize:_fontsize];
    _promptLabel.textColor = UIColor.whiteColor;
    [self addSubview:_promptView];
    [self addSubview:_promptLabel];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)setText:(NSString *)text {
    _text = text;
    
}

- (void)reloadView:(NSString *)text {
    _promptLabel.text = text;
    CGSize sz = [text boundingRectWithSize:<#(CGSize)#> options:<#(NSStringDrawingOptions)#> attributes:<#(nullable NSDictionary<NSString *,id> *)#> context:<#(nullable NSStringDrawingContext *)#>]
}

@end
