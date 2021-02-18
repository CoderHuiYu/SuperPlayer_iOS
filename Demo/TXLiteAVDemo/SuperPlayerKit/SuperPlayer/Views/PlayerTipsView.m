//
//  PlayerTipsView.m
//  Pods
//
//  Created by yuhui on 2021/2/18.
//

#import "PlayerTipsView.h"
#import "TipView.h"
#import "Masonry.h"
@interface PlayerTipsView()
@property (nonatomic, strong) NSMutableArray<NSString *> *tips;
@end
@implementation PlayerTipsView
- (NSMutableArray<NSString *> *)tips{
    if (!_tips) {
        _tips = [NSMutableArray array];
    }
    return _tips;
}

- (instancetype)initWithFrame:(CGRect)frame tips:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.tips addObjectsFromArray:titles];
        [self initialize];
    }
    return self;
}

- (void)initialize {
    
    if (_tips.count < 2) {
        [_tips insertObject:@"" atIndex:0];
    }
    
    for (NSInteger i = 0; i<_tips.count; i++) {
        CGFloat width = [self getWidthWithText:_tips[i] height:29 font:12];
        [self createTipView:width title:_tips[i] index:i];
    }
}

- (void)createTipView:(CGFloat)width title:(NSString *)title index:(NSInteger)index {
    TipView * tipview = [[TipView alloc]initWithFrame:CGRectMake(0, 0, width, 29) title:title];
    tipview.backgroundColor = [UIColor clearColor];
    [self addSubview:tipview];
    
    [tipview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.width.mas_equalTo( width == 0 ? 0 : width+22);
        make.height.mas_equalTo(29);
        make.top.mas_equalTo(self).mas_offset(index*35);
    }];
}


//根据高度度求宽度  text 计算的内容  Height 计算的高度 font字体大小
- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                        context:nil];
    return rect.size.width;
}
@end
