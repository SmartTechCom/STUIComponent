//
//  STButtonItem.h
//  STUIComponent
//
//  Created by kenneth wang on 15/12/16.
//  Copyright © 2015年 Beijing Yimay Holiday Information Science & Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STButtonItem : NSObject
{
    NSString *label;
    void (^action)();
}

@property (retain, nonatomic) NSString *label;
@property (copy, nonatomic) void (^action)();

+(id)item;
+(id)itemWithLabel:(NSString *)inLabel;
+(id)itemWithLabel:(NSString *)inLabel action:(void(^)(void))action;

@end
