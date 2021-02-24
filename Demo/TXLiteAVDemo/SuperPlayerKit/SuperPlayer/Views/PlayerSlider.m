//
//  PlayerSlider.m
//  Slider
//
//  Created by annidyfeng on 2018/8/27.
//  Copyright © 2018年 annidy. All rights reserved.
//

#import "PlayerSlider.h"
#import <Masonry/Masonry.h>
#import "UIView+MMLayout.h"

@implementation PlayerPoint
- (instancetype)init {
    self = [super init];
    
    self.holder = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIView *inter = [[UIView alloc] initWithFrame:CGRectMake(14, 14, 2, 2)];
    inter.backgroundColor = [UIColor whiteColor];
    [self.holder addSubview:inter];
    self.holder.userInteractionEnabled = YES;
    
    return self;
}
@end

@interface PlayerSlider()
@property UIImageView    *tracker;
@end

@implementation PlayerSlider

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self initUI];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self initUI];
    return self;
}

- (void)initUI {
    _progressView                   = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progressView.progressTintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
    _progressView.trackTintColor    = [UIColor clearColor];
//    [_progressView.layer addSublayer:[self setGradualChangingColor:_progressView colors:@[@"F7B500", @"B620E0", @"32C5FF"]]];
    [self addSubview:_progressView];
  
    self.pointArray = [NSMutableArray new];
    
    self.maximumValue = 1;
 
    self.maximumTrackTintColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    UIColor *startColor = [UIColor colorWithRed:247/255 green:181.0/255 blue:0.0/255 alpha:1.0];
    UIColor *middleColor = [UIColor colorWithRed:182.0/255 green:32.0/255 blue:224.0/255 alpha:1.0];
    UIColor *endColor = [UIColor colorWithRed:50.0/255 green:197.0/255 blue:255.0/255 alpha:1.0];
    NSArray *colors = @[endColor,middleColor,startColor];
    UIImage *img = [self getGradientImageWithColors:colors imgSize:self.bounds.size];
    [self setMinimumTrackImage:img forState:UIControlStateNormal];
    
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.centerY.equalTo(self).mas_offset(0.5);
        make.height.mas_equalTo(2);
    }];
    _progressView.layer.masksToBounds = YES;
    _progressView.layer.cornerRadius  = 1;
    [self sendSubviewToBack:self.progressView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tracker = self.subviews.lastObject;
    for (PlayerPoint *point in self.pointArray) {
        point.holder.center = [self holderCenter:point.where];
        if (@available(iOS 14.0, *)) {
            [self addSubview:point.holder];
        } else {
            // Fallback on earlier versions
            [self insertSubview:point.holder belowSubview:self.tracker];
        }
        
    }
}

- (PlayerPoint *)addPoint:(GLfloat)where
{
    for (PlayerPoint *pp in self.pointArray) {
        if (fabsf(pp.where - where) < 0.0001)
            return pp;
    }
    PlayerPoint *point = [PlayerPoint new];
    point.where = where;
    point.holder.center = [self holderCenter:where];
    point.holder.hidden = _hiddenPoints;
    [self.pointArray addObject:point];
    [point.holder addTarget:self action:@selector(onClickHolder:) forControlEvents:UIControlEventTouchUpInside];
    [self setNeedsLayout];
    return point;
}

- (CGPoint)holderCenter:(GLfloat)where {
    return CGPointMake(self.frame.size.width * where, self.progressView.mm_centerY);
}

- (void)onClickHolder:(UIControl *)sender {
    NSLog(@"clokc");
    for (PlayerPoint *point in self.pointArray) {
        if (point.holder == sender) {
            if ([self.delegate respondsToSelector:@selector(onPlayerPointSelected:)])
                [self.delegate onPlayerPointSelected:point];
        }
    }
}

- (void)setHiddenPoints:(BOOL)hiddenPoints
{
    for (PlayerPoint *point in self.pointArray) {
        point.holder.hidden = hiddenPoints;
    }
    _hiddenPoints = hiddenPoints;
}

//- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value {
//    
//    rect.origin.x = rect.origin.x - 10 ;
//    
//    rect.size.width = rect.size.width +20;
//    
//    return CGRectInset ([super thumbRectForBounds:bounds
//                                        trackRect:rect
//                                            value:value],
//                        10 ,
//                        10);
//    
//}


-(UIImage *)getGradientImageWithColors:(NSArray*)colors imgSize:(CGSize)imgSize
{
    NSMutableArray *arRef = [NSMutableArray array];
    for(UIColor *ref in colors) {
        [arRef addObject:(id)ref.CGColor];
        
    }
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors firstObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)arRef, NULL);
    CGPoint start = CGPointMake(0.0, 0.0);
    CGPoint end = CGPointMake(imgSize.width, imgSize.height);
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

//绘制渐变色颜色的方法
- (CAGradientLayer *)setGradualChangingColor:(UIView *)view colors:(NSArray<NSString *> *)hexColors{

//    CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;

    //  创建渐变色数组，需要转换为CGColor颜色
    NSMutableArray * colors = [NSMutableArray array];
    for (NSInteger i = 0; i < hexColors.count; i++) {
        [colors addObject:(__bridge id)[self colorWithHex:hexColors[i]].CGColor];
    }
    gradientLayer.colors = colors;

    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(2.35, 0.5);
    gradientLayer.endPoint = CGPointMake(0.5, 0.5);

    //  设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0,@0.5,@1];

    return gradientLayer;
}

//获取16进制颜色的方法
- (UIColor *)colorWithHex:(NSString *)hexColor {
    hexColor = [hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([hexColor length] < 6) {
        return nil;
    }
    if ([hexColor hasPrefix:@"#"]) {
        hexColor = [hexColor substringFromIndex:1];
    }
    NSRange range;
    range.length = 2;
    range.location = 0;
    NSString *rs = [hexColor substringWithRange:range];
    range.location = 2;
    NSString *gs = [hexColor substringWithRange:range];
    range.location = 4;
    NSString *bs = [hexColor substringWithRange:range];
    unsigned int r, g, b, a;
    [[NSScanner scannerWithString:rs] scanHexInt:&r];
    [[NSScanner scannerWithString:gs] scanHexInt:&g];
    [[NSScanner scannerWithString:bs] scanHexInt:&b];
    if ([hexColor length] == 8) {
        range.location = 4;
        NSString *as = [hexColor substringWithRange:range];
        [[NSScanner scannerWithString:as] scanHexInt:&a];
    } else {
        a = 255;
    }
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:((float)a / 255.0f)];
}


@end
