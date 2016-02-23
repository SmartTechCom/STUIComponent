//
//  UIActionSheet+STBlocks.h
//  STUIComponent
//
//  Created by kenneth wang on 15/12/16.
//  Copyright © 2015年 Beijing Yimay Holiday Information Science & Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STButtonItem.h"

@interface UIActionSheet (STBlocks) <UIActionSheetDelegate>

-(id)initWithTitle:(NSString *)inTitle cancelButtonItem:(STButtonItem *)inCancelButtonItem destructiveButtonItem:(STButtonItem *)inDestructiveItem otherButtonItems:(STButtonItem *)inOtherButtonItems, ... NS_REQUIRES_NIL_TERMINATION;

/** This block is called when the action sheet is dismssed for any reason.
 */
@property (copy, nonatomic) void(^dismissalAction)();

@end
