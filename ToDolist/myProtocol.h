//
//  myProtocol.h
//  ToDolist
//
//  Created by rahma zakaria on 2/28/21.
//

#import <Foundation/Foundation.h>
#import "Task.h"

@protocol myProtocol <NSObject>

@optional
-(void) addTask:(Task*)task;
-(void) editTask:(Task*)task;

@end

