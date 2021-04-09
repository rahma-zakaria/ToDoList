//
//  AddViewController.m
//  ToDolist
//
//  Created by rahma zakaria on 2/26/21.
//

#import "AddViewController.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *priorityPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *statePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePiker;

@end

@implementation AddViewController{
    Task *addedTask;
    NSString *addedPriority;
    NSString *addedState;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    addedPriority=@"High";
    addedState=@"To Do";
    priorityList =[NSMutableArray new];
    [priorityList addObject:@"High"];
    [priorityList addObject:@"Medium"];
    [priorityList addObject:@"Low"];
    
    stateList =[NSMutableArray new];
    [stateList addObject:@"To Do"];
    [stateList addObject:@"In Progress"];
    [stateList addObject:@"Done"];
    
    [_priorityPicker setDelegate:self] ;
    [_priorityPicker setDataSource:self] ;
    
    [_statePicker setDelegate:self] ;
    [_statePicker setDataSource:self] ;
    addedTask = [Task new];
}
- (IBAction)addButton:(id)sender {
    addedTask.taskName = _nameText.text;
    addedTask.taskDesc = _descText.text;
    addedTask.taskPriority = addedPriority;
    addedTask.taskState = addedState;
    addedTask.taskDate = _datePiker.date;
    
    //NSDate *create =[NSDate date];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss a"];
    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
    NSString *date2 = [dateFormatter stringFromDate:[NSDate date]];
    //[dateLabel setText:date];
    //NSLog(@"**%@\n",date2);
    NSDate *newDate = [dateFormatter dateFromString:date2];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss a"];
    addedTask.createDate = newDate;
    
    _nameText.text = @"";
    _nameText.text =@"";
    //_priorityChosen.text = @"" ;
    //_conditionChosen.text = @"" ;
    
    [_P addTask:addedTask];
    /*[self dismissViewControllerAnimated:YES completion:^(void){
        printf("completion\n");
    }];*/
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger numOfRows = 0 ;
    switch (pickerView.tag) {
        case 1:
            numOfRows = [priorityList count]  ;
            break;
        case 2:
            numOfRows = [stateList count]  ;
            break;
    }
    return numOfRows ;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *rowData ;
    switch (pickerView.tag) {
        case 1:
            rowData = priorityList[row] ;
            break;
        case 2:
            rowData = stateList[row] ; ;
            break;
    }
    return rowData ;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (pickerView.tag) {
        case 1:
            //printf("%i",priorityList[row]);
            NSLog(@"\n%@\n",priorityList[row]);
            addedPriority =priorityList[row];
            //_priorityChosen.text = prioritylist[row] ;
            break;
        case 2:
            NSLog(@"\n%@\n",stateList[row]);
            addedState=stateList[row];
          //  _conditionChosen.text = conditionlist[row] ; ;
            break;
    }
    
}
/*
- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    <#code#>
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    <#code#>
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    <#code#>
}

- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
    <#code#>
}

- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    <#code#>
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    <#code#>
}

- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    <#code#>
}

- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
    <#code#>
}

- (void)setNeedsFocusUpdate {
    <#code#>
}

- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
    <#code#>
}

- (void)updateFocusIfNeeded {
    <#code#>
}
*/
@end
