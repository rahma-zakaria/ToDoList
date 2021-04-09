//
//  Task.m
//  ToDolist
//
//  Created by rahma zakaria on 2/28/21.
//

#import "Task.h"

@implementation Task

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.taskName forKey:@"name"];
    [encoder encodeObject:self.taskDesc forKey:@"desc"];
    [encoder encodeObject:self.taskPriority forKey:@"priority"];
    [encoder encodeObject:self.taskDate forKey:@"date"];
    [encoder encodeObject:self.createDate forKey:@"createDate"];
    [encoder encodeObject:self.taskState forKey:@"state"];
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        
        self.taskName = [decoder decodeObjectOfClass:[self class] forKey:@"name"];
        self.taskDesc = [decoder decodeObjectOfClass:[self class] forKey:@"desc"];
        self.taskPriority = [decoder decodeObjectOfClass:[self class] forKey:@"priority"];
        self.taskDate = [decoder decodeObjectOfClass:[self class] forKey:@"date"];
        self.createDate = [decoder decodeObjectOfClass:[self class] forKey:@"createDate"];
        self.taskState = [decoder decodeObjectOfClass:[self class] forKey:@"state"];
        
        /*
        self.taskName = [decoder decodeObjectForKey:@"name"];
        self.taskDesc = [decoder decodeObjectForKey:@"desc"];
        self.taskPriority = [decoder decodeObjectForKey:@"priority"];
        self.taskDate = [decoder decodeObjectForKey:@"date"];
        self.createDate = [decoder decodeObjectForKey:@"createDate"];
        self.taskState = [decoder decodeObjectForKey:@"state"];
         */
    }
    return self;
}
+ (BOOL)supportsSecureCoding{
    return YES;
}

@end
