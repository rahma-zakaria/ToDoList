//
//  TasksData.h
//  ToDolist
//
//  Created by rahma zakaria on 2/28/21.
//

#import <Foundation/Foundation.h>
#import "Task.h"

@interface TasksData : NSObject{
    NSMutableArray *tasks;
}


-(void)addTask:(Task*)taskItem;
-(NSMutableArray*)getAllTasks;

@end


