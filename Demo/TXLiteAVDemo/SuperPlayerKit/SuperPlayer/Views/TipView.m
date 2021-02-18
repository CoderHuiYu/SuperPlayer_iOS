//
//  TipView.m
//  Pods
//
//  Created by yuhui on 2021/2/18.
//

#import "TipView.h"
#import "Masonry.h"
@interface TipView()
@property (nonatomic, strong) UILabel *backgroundLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, copy) NSString *title;
@end

@implementation TipView

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame title:@""];
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title {
    self = [super initWithFrame:frame];
    if (self) {
        self.title = title;
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _backgroundLabel = [[UILabel alloc]init];
    _backgroundLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    _backgroundLabel.layer.cornerRadius = 4;
    _backgroundLabel.layer.masksToBounds = YES;
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.text = _title;
    _titleLabel.font = [UIFont systemFontOfSize:12.0f];
    
    [self addSubview:_backgroundLabel];
    [self addSubview:_titleLabel];
    
    [_backgroundLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.left.mas_equalTo(self);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(3.5);
        make.bottom.mas_equalTo(self).mas_offset(-3.5);
        make.left.mas_equalTo(self).mas_offset(10);
        make.right.mas_equalTo(self).mas_offset(-10);
    }];
}

@end
