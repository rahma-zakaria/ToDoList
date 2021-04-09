//
//  DetailesViewController.m
//  ToDolist
//
//  Created by rahma zakaria on 2/26/21.
//

#import "DetailesViewController.h"

@interface DetailesViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UILabel *labelPriority;
@property (weak, nonatomic) IBOutlet UILabel *labelState;
@property (weak, nonatomic) IBOutlet UITextView *labelDiscription;
@property (weak, nonatomic) IBOutlet UILabel *labelRmnd;

@end

@implementation DetailesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_labelName setText:[[_toDoArray objectAtIndex:_index] taskName]];
    [_labelDiscription setText:[[_toDoArray objectAtIndex:_index] taskDesc]];
    [_labelState setText:[[_toDoArray objectAtIndex:_index] taskState]];
    [_labelPriority setText:[[_toDoArray objectAtIndex:_index] taskPriority]];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yy HH:mm a"];
    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
    NSString *date = [dateFormatter stringFromDate:[[_toDoArray objectAtIndex:_index] taskDate]];
    [_labelDate setText:date];
    
    NSDate *futureDate=[[_toDoArray objectAtIndex:_index] taskDate];
    NSDate *nowDate=[NSDate date];
    long allSeconds=[futureDate timeIntervalSinceDate:nowDate];
    if (allSeconds >0) {
        NSInteger day = allSeconds / (60 * 60 * 24);
        NSInteger hours = (allSeconds / (60 * 60))%24;
        NSInteger minutes = (allSeconds / 60) % 60;
       // NSInteger seconds = allSeconds % 60;
        NSString *result= [NSString stringWithFormat:@"%ld D  %02ld:%02ld", day, hours, minutes];
        [_labelRmnd setText:result];
    }else{
        [_labelRmnd setText:@"Time out"];
    }

    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editAction)];
    [self.navigationItem setRightBarButtonItem:rightButton];
}

-(void)editAction{
    EditViewController *editVC = [self.storyboard instantiateViewControllerWithIdentifier:@"editVC"];
    [editVC setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [editVC setEP:self];
    [editVC setNName:[[_toDoArray objectAtIndex:_index] taskName]];
    [editVC setNDesc:[[_toDoArray objectAtIndex:_index] taskDesc]];
    [editVC setNState:[[_toDoArray objectAtIndex:_index] taskState]];
    [editVC setNPriority:[[_toDoArray objectAtIndex:_index] taskPriority]];
    [editVC setNDate:[[_toDoArray objectAtIndex:_index] taskDate]];
    [self.navigationController pushViewController:editVC animated:YES];
}
-(void) editTask:(Task*)task{
    if([_indexArray count]!=0){
        [_toDoArray replaceObjectAtIndex:_index withObject:task];
        [self updateArray];
        
    }else{
        for(int i=0 ; i<[_allDataArray count];i++){
            if ([[[_toDoArray objectAtIndex:_index] taskName] isEqual: [[_allDataArray objectAtIndex:i] taskName]]&&[[[_toDoArray objectAtIndex:_index] taskDesc] isEqual: [[_allDataArray objectAtIndex:i] taskDesc]]) {
                [_toDoArray replaceObjectAtIndex:_index withObject:task];
                [_allDataArray replaceObjectAtIndex:i withObject:task];
            }
        }
        [self saveData];
    }
    [self viewDidLoad];
}


-(void)updateArray{
    for (int i =0 ; i<[_toDoArray count]; i++) {
        NSInteger myIndex = [[_indexArray objectAtIndex:i]integerValue];
        [_allDataArray replaceObjectAtIndex:myIndex withObject:[_toDoArray objectAtIndex:i]];
    }
    [self saveData];
}

-(void)saveData{
    NSMutableArray *archieve = [[NSMutableArray alloc]initWithCapacity:[_allDataArray count]];
   NSData *encodedObject=[NSData new];
    for(int i=0 ; i<[_allDataArray count];i++)
    {
        encodedObject =[NSKeyedArchiver archivedDataWithRootObject:[_allDataArray objectAtIndex:i] requiringSecureCoding:NO error:nil];
        [archieve addObject:encodedObject];
    }
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:archieve forKey:@"data"];
}

@end
