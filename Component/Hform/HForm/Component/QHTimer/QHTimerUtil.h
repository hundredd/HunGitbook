//
//  QHTimerUtil.h
//  Foundation
//
//  Created by Keldon on 16/6/6.
//
//

#import <Foundation/Foundation.h>

typedef void (^TimerCountdownBlock)(int);
typedef void (^TimerEndingBlock)(void);

@interface QHTimer : NSObject

//倒计时的当前剩余时间
@property __block int timeout;

//倒计时的总时间
@property (nonatomic, assign) int originTimeout;

@property (nonatomic, strong) TimerCountdownBlock countdownBlock;

@property (nonatomic, strong) TimerEndingBlock timerEndingBlock;

/**
 *	@brief	初始化
 *
 *	@param 	timeout 	倒计时的时间
 *
 *	@return	返回实例
 */
-(id)initWithTimeout:(int)timeout;

/**
 *	@brief	开始计时
 *
 *	@param 	countdownBlock 	倒计时时每秒处理Block
 *	@param 	timerEndingBlock 	倒计时结束时处理Block
 */
-(void)start;


/**
 *	@brief	取消计时
 */
-(void)cancleTimer;

@end
