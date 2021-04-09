//
//  DetailesViewController.h
//  ToDolist
//
//  Created by rahma zakaria on 2/26/21.
//

#import <UIKit/UIKit.h>
#import "myProtocol.h"
#import "EditViewController.h"

@interface DetailesViewController : UIViewController <myProtocol>
/*
@property NSString *name;
@property NSString *descrip;
@property NSString *date;
@property NSString *state;
@property NSString *piority;
*/

@property NSInteger index;
@property NSMutableArray *toDoArray;
@property NSMutableArray *allDataArray;
@property NSMutableArray *indexArray;

@end

