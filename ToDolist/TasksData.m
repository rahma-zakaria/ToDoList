//
//  TasksData.m
//  ToDolist
//
//  Created by rahma zakaria on 2/28/21.
//

#import "TasksData.h"

@implementation TasksData
-(id)init{
    self = [super init];
    tasks = [[NSMutableArray alloc]init];
    return self;
}
-(void)addTask:(Task*)taskItem{
    [tasks addObject:taskItem];
}
-(NSMutableArray*)getAllTasks{
    return tasks;
}

@end
