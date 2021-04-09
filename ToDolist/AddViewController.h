//
//  AddViewController.h
//  ToDolist
//
//  Created by rahma zakaria on 2/26/21.
//

#import <UIKit/UIKit.h>
#import "myProtocol.h"

@interface AddViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>{
    NSMutableArray *priorityList;
    NSMutableArray *stateList;
}
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextView *descText;
- (IBAction)addButton:(id)sender;

@property id<myProtocol>P;

@end

