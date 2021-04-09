//
//  EditViewController.h
//  ToDolist
//
//  Created by rahma zakaria on 2/26/21.
//

#import <UIKit/UIKit.h>
#import "myProtocol.h"
#import "DetailesViewController.h"

@interface EditViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>{
    NSMutableArray *priorityList;
    NSMutableArray *stateList;
}

@property NSString *nName , *nDesc , *nState , *nPriority;
@property NSDate *nDate;

@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextView *descText;
- (IBAction)editButton:(id)sender;

@property id<myProtocol>eP;

@end

