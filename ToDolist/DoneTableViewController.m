//
//  DoneTableViewController.m
//  ToDolist
//
//  Created by rahma zakaria on 2/26/21.
//

#import "DoneTableViewController.h"

@interface DoneTableViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@end

@implementation DoneTableViewController{
    NSMutableArray *toDoArray;
    NSMutableArray *searchArray;
    NSMutableArray *doneArray;
    NSMutableArray *indexArray;
    
    NSMutableArray *archieve;
    NSData *encodedObject;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    printf("\n in did load");
}
- (void)viewWillAppear:(BOOL)animated{
    printf("\n in will apper");
    toDoArray = [NSMutableArray new];
    searchArray = [NSMutableArray new];
    doneArray = [NSMutableArray new];
    indexArray = [NSMutableArray new];
    
    [self readData];
    self.tableView.backgroundColor = [UIColor
                                      colorWithRed: 210.0 / 255.0
                                      green: 255.0 / 255.0
                                      blue: 210.0 / 255.0
                                      alpha: 0.98
                                      ];
  //  [self updateArray];
    [self readDone];
    searchArray = doneArray;
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}

-(void)readData{
    NSUserDefaults *allData = [NSUserDefaults standardUserDefaults];
        NSMutableArray *dataArray = [allData objectForKey:@"data"];
        for (int i =0 ; i<[[allData objectForKey:@"data"]count]; i++) {
            [toDoArray addObject:[NSKeyedUnarchiver unarchiveObjectWithData:[dataArray objectAtIndex:i]]];
        }
}
-(void)readDone{
    for (int i =0 ; i<[toDoArray count]; i++) {
        if ([[[toDoArray objectAtIndex:i] taskState ]isEqualToString:@"Done"]) {
            [doneArray addObject:[toDoArray objectAtIndex:i]];
            [indexArray addObject:@(i)];
        }
    }
   // searchArray =doneArray;
}
-(void)saveData{
    NSMutableArray *archieve = [[NSMutableArray alloc]initWithCapacity:[toDoArray count]];
   NSData *encodedObject=[NSData new];
    for(int i=0 ; i<[toDoArray count];i++)
    {
        encodedObject =[NSKeyedArchiver archivedDataWithRootObject:[toDoArray objectAtIndex:i] requiringSecureCoding:NO error:nil];
        [archieve addObject:encodedObject];
    }
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:archieve forKey:@"data"];
    //[self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [searchArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *nameLabel = [cell viewWithTag:1];
    UILabel *detaileLabel = [cell viewWithTag:2];
    UIImageView  *imageView  = [cell viewWithTag:3];
    UILabel *dateLabel = [cell viewWithTag:4];
    UILabel *remndLabel = [cell viewWithTag:5];

     [nameLabel setText:[[searchArray objectAtIndex:indexPath.row] taskName]];
    [detaileLabel setText:[[searchArray objectAtIndex:indexPath.row] taskDesc]];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yy HH:mm a"];
    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
    NSString *date = [dateFormatter stringFromDate:[[searchArray objectAtIndex:indexPath.row] createDate]];
    [dateLabel setText:date];
    
    NSDate *futureDate=[[searchArray objectAtIndex:indexPath.row] taskDate];
    NSDate *nowDate=[NSDate date];
    long allSeconds=[futureDate timeIntervalSinceDate:nowDate];
    if (allSeconds >0) {
        NSInteger day = allSeconds / (60 * 60 * 24);
        NSInteger hours = (allSeconds / (60 * 60))%24;
        NSInteger minutes = (allSeconds / 60) % 60;
        NSString *result= [NSString stringWithFormat:@"%ld    %02ld:%02ld", day, hours, minutes];
        [remndLabel setText:result];
    }else{
        [remndLabel setText:@"Time Out"];
    }

    if ([[[searchArray objectAtIndex:indexPath.row] taskPriority ]isEqualToString:@"High"]) {
        [imageView setImage:[UIImage imageNamed:@"sun"]];
    }else if ([[[searchArray objectAtIndex:indexPath.row] taskPriority ]isEqualToString:@"Low"]) {
        [imageView setImage:[UIImage imageNamed:@"raining"]];
    }else{
        [imageView setImage:[UIImage imageNamed:@"clouds-and-sun"]];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
            cell.backgroundColor = [UIColor
                                    colorWithRed: 210.0 / 255.0
                                    green: 255.0 / 255.0
                                    blue: 210.0 / 255.0
                                    alpha: 1.0
                                    ];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailesViewController *detailesVC = [self.storyboard instantiateViewControllerWithIdentifier:@"detailesVC"];
    [detailesVC setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    
    [detailesVC setToDoArray:searchArray];
    [detailesVC setAllDataArray:toDoArray];
    [detailesVC setIndexArray:indexArray];
    [detailesVC setIndex:indexPath.row];
    
    [self.navigationController pushViewController:detailesVC animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
// alert must be here
    UIAlertController *alertDelete = [UIAlertController alertControllerWithTitle:@"Delete Task" message:@"Are You Sure ?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yes =[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deletetask:indexPath.row];
    }];
    UIAlertAction *no =[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:nil];
    [alertDelete addAction:yes];
    [alertDelete addAction:no];
    [self presentViewController:alertDelete animated:YES completion:nil];
}

-(void)deletetask:(NSInteger)index{
    //must be change here
    [doneArray removeObjectAtIndex:index];
    //[self saveData];

    for (int i=0 ; i<[indexArray count];i++) {
        if (i == index) {
            NSInteger myIndex = [[indexArray objectAtIndex:i]integerValue];
            [toDoArray removeObjectAtIndex:myIndex];
        }
    }
    [self saveData];
    [self.tableView reloadData];
}

#pragma mark - Search Bar
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self.searchBar setShowsCancelButton:NO animated:YES];
    searchBar.text = @"";
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length == 0) {
        searchArray =doneArray;
        [self.searchBar endEditing:YES];
    }
    else {
        searchArray =[NSMutableArray new];
        indexArray =[NSMutableArray new];
        for (int i=0 ; i<[doneArray count];i++) {
            NSRange range = [[[doneArray objectAtIndex:i] taskName] rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (range.location != NSNotFound) {
                [searchArray addObject:[doneArray objectAtIndex:i]];
            }
        }
        if([searchArray count] ==0){
            UIAlertController *alertDelete = [UIAlertController alertControllerWithTitle:@"Search" message:@"Search Not Found" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok =[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self->searchArray = self->toDoArray;
                //searchBar.text = @"";
                //[self.searchBar resignFirstResponder];
                [self.tableView reloadData];
            }];
            [alertDelete addAction:ok];
            [self presentViewController:alertDelete animated:YES completion:nil];
        }
    }
    [self.tableView reloadData];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = @"";
    [self.searchBar resignFirstResponder];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = @"";
    [self.searchBar resignFirstResponder];
}
@end
