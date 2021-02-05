#import "SuperPlayerControlView.h"

@implementation SuperPlayerControlView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _compact =YES;
        //修改一些东西
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    UIInterfaceOrientation currentOrientation = [UIApplication sharedApplication].statusBarOrientation;
    if (self.compact) {
        [self setOrientationPortraitConstraint];
    } else {
        [self setOrientationLandscapeConstraint];
    }
    [self.delegate controlViewDidChangeScreen:self];
}

- (void)setOrientationPortraitConstraint
{
    
}

- (void)setOrientationLandscapeConstraint
{
    
}

- (void)resetWithResolutionNames:(NSArray<NSString *> *)resolutionNames
          currentResolutionIndex:(NSUInteger)resolutionIndex
                          isLive:(BOOL)isLive
                  isTimeShifting:(BOOL)isTimeShifting
                      isPlaying:(BOOL)isAutoPlay
{
    
}

- (void)setPlayState:(BOOL)isPlay {

}

- (void)setProgressTime:(NSInteger)currentTime
              totalTime:(NSInteger)totalTime
          progressValue:(CGFloat)progress
          playableValue:(CGFloat)playable
{

}

@end
