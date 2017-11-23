//
//  QHTimerUtil.m
//  Foundation
//
//  Created by Keldon on 16/6/6.
//
//

#import "QHTimerUtil.h"

@interface QHTimer()

@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation QHTimer

@synthesize timeout = _timeout;
@synthesize originTimeout = _originTimeout;
@synthesize countdownBlock = _countdownBlock;
@synthesize timerEndingBlock = _timerEndingBlock;

-(id)initWithTimeout:(int)timeout {
    self = [super init];
    
    if (self) {
        _originTimeout = timeout;
    }
    
    return self;
}

-(void)start {
    self.timeout = self.originTimeout;
    dispatch_source_set_timer(self.timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.timer, ^{
        ///倒计时结束
        if (self.timeout <= 0) {
            [self cancleTimer];
            
            if (self.timerEndingBlock) {
                dispatch_async(dispatch_get_main_queue(), self.timerEndingBlock);
            }
        }
        ///倒计时进行中
        else {
            self.timeout --;
            if (self.countdownBlock) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.countdownBlock(self.timeout + 1);
                });
            }
        }
    });
    
    dispatch_resume(self.timer);
}

-(void)cancleTimer {
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

- (dispatch_queue_t)queue {
    if (_queue == nil) {
        _queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    return _queue;
}

- (dispatch_source_t)timer {
    if (_timer == nil) {
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, self.queue);
    }
    return _timer;
}

@end
