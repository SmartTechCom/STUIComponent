//
//  STButtonItem.m
//  STUIComponent
//
//  Created by kenneth wang on 15/12/16.
//  Copyright © 2015年 Beijing Yimay Holiday Information Science & Technology Co.,Ltd. All rights reserved.
//

#import "STButtonItem.h"

@implementation STButtonItem

@synthesize label;
@synthesize action;

+(id)item
{
    return [self new];
}

+(id)itemWithLabel:(NSString *)inLabel
{
    STButtonItem *newItem = [self item];
    [newItem setLabel:inLabel];
    return newItem;
}

+(id)itemWithLabel:(NSString *)inLabel action:(void(^)(void))action
{
    STButtonItem *newItem = [self itemWithLabel:inLabel];
    [newItem setAction:action];
    return newItem;
}

@end
