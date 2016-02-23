//
//  UIAlertView+STBlocks.h
//  STUIComponent
//
//  Created by kenneth wang on 15/12/16.
//  Copyright © 2015年 Beijing Yimay Holiday Information Science & Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STButtonItem.h"

@interface UIAlertView (STBlocks)

-(id)initWithTitle:(NSString *)inTitle message:(NSString *)inMessage cancelButtonItem:(STButtonItem *)inCancelButtonItem otherButtonItems:(STButtonItem *)inOtherButtonItems, ... NS_REQUIRES_NIL_TERMINATION;

- (NSInteger)addButtonItem:(STButtonItem *)item;

+ (UIAlertView *)alertViewWithTitle:(NSString *)title
                            message:(NSString *)message;

@end
