//
//  EditViewController.m
//  ToDolist
//
//  Created by rahma zakaria on 2/26/21.
//

#import "EditViewController.h"

@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *priorityPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *statePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePiker;


@end

@implementation EditViewController{
    Task *editedTask;
    DetailesViewController *myTask;
    NSString *editedPriority;
    NSString *editedState;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //editedPriority=@"High";
    //editedState=@"ToDo";
    stateList =[NSMutableArray new];
    
    priorityList =[NSMutableArray new];
    [priorityList addObject:@"High"];
    [priorityList addObject:@"Medium"];
    [priorityList addObject:@"Low"];
    
    [_priorityPicker setDelegate:self] ;
    [_priorityPicker setDataSource:self] ;
    
    [_statePicker setDelegate:self] ;
    [_statePicker setDataSource:self] ;
}

- (void)viewWillAppear:(BOOL)animated{
    editedTask = [Task new];
    myTask =[self.storyboard instantiateViewControllerWithIdentifier:@"detailesVC"];
    _nameText.text = _nName;
    _descText.text = _nDesc;
    editedState = _nState;
    editedPriority = _nPriority;

    if ([_nState  isEqual: @"Done"]) {
        [stateList addObject:@"Done"];
    }else if([_nState  isEqual:@"In Progress"]){
        [stateList addObject:@"In Progress"];
        [stateList addObject:@"Done"];
    }else{
        [stateList addObject:@"To Do"];
        [stateList addObject:@"In Progress"];
        [stateList addObject:@"Done"];
    }
}

-(void)saveEdit{
    editedTask.taskName = _nameText.text;
    editedTask.taskDesc = _descText.text;
    editedTask.taskPriority = editedPriority;
    editedTask.taskState = editedState;
    editedTask.taskDate = _datePiker.date;
    //NSDate *create =[NSDate date];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss a"];
    NSString *date2 = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *newDate = [dateFormatter dateFromString:date2];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss a"];
    editedTask.createDate = newDate;
    [_eP editTask:editedTask];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)editButton:(id)sender{
    //alert must be here
    UIAlertController *alertDelete = [UIAlertController alertControllerWithTitle:@"Edit Task" message:@"Are You Sure ?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yes =[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self saveEdit];
    }];
    UIAlertAction *no =[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:nil];
    [alertDelete addAction:yes];
    [alertDelete addAction:no];
    [self presentViewController:alertDelete animated:YES completion:nil];
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
            //NSLog(@"\n%@\n",priorityList[row]);
            editedPriority =priorityList[row];
            //_priorityChosen.text = prioritylist[row] ;
            break;
        case 2:
            //NSLog(@"\n%@\n",stateList[row]);
            editedState=stateList[row];
          //  _conditionChosen.text = conditionlist[row] ; ;
            break;
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
