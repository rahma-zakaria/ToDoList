//
//  Task.h
//  ToDolist
//
//  Created by rahma zakaria on 2/28/21.
//

#import <Foundation/Foundation.h>


@interface Task : NSObject
@property NSString *taskName;
@property NSString *taskDesc;
@property NSString *taskPriority;
@property NSDate *taskDate;
@property NSDate *createDate;
@property NSString *taskState;

@end

