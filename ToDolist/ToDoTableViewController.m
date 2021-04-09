//
//  ToDoTableViewController.m
//  ToDolist
//
//  Created by rahma zakaria on 2/26/21.
//

#import "ToDoTableViewController.h"

@interface ToDoTableViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation ToDoTableViewController{
    NSMutableArray *toDoArray;
    NSMutableArray *searchArray;
    NSMutableArray *indexArray;

    NSMutableArray *archieve;
    NSData *encodedObject;
    
    Task *initial;
    
    int sortCheck;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    sortCheck =0;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"add" style:UIBarButtonItemStylePlain target:self action:@selector(addAction)];
    [rightButton setImage:[UIImage imageNamed:@"add"]];
    [rightButton setTintColor:UIColor.blueColor];
    [rightButton setTitle:@"add"];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    UIBarButtonItem *sortButton = [[UIBarButtonItem alloc]initWithTitle:@"Sort" style:UIBarButtonItemStylePlain target:self action:@selector(sortAction)];
    //[sortButton setImage:[UIImage imageNamed:@"add"]];
    [sortButton setTintColor:UIColor.blueColor];
    [sortButton setTitle:@"sort"];
    [self.navigationItem setLeftBarButtonItem:sortButton];
}
- (void)viewWillAppear:(BOOL)animated{
    initial = [Task new];
    initial.taskName =@"initial";
    toDoArray = [NSMutableArray new];
    searchArray = [NSMutableArray new];
    indexArray = [NSMutableArray new];

    [self readData];

    searchArray =toDoArray;
    self.tableView.backgroundColor = [UIColor colorWithRed: 180.0 / 255.0
                                            green: 210.0 / 255.0
                                            blue: 255.0 / 255.0
                                            alpha: 0.98
                                            ];
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}
-(void)readData{
    NSUserDefaults *allData = [NSUserDefaults standardUserDefaults];
    if([[allData objectForKey:@"data"] count] != 0){
        NSMutableArray *dataArray = [allData objectForKey:@"data"];
        for (int i =0 ; i<[[allData objectForKey:@"data"]count]; i++) {
            [toDoArray addObject:[NSKeyedUnarchiver unarchiveObjectWithData:[dataArray objectAtIndex:i]]];
            [indexArray addObject:@(i)];
        }
    }
    else{
        [toDoArray addObject:initial];
        [indexArray addObject:@(0)];
    }
}

-(void)saveData{
    archieve = [[NSMutableArray alloc]initWithCapacity:[toDoArray count]];
    encodedObject=[NSData new];
    for(int i=0 ; i<[toDoArray count];i++)
    {
        encodedObject =[NSKeyedArchiver archivedDataWithRootObject:[toDoArray objectAtIndex:i] requiringSecureCoding:NO error:nil];
        [archieve addObject:encodedObject];
    }
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:archieve forKey:@"data"];
}
-(void)addAction{
    AddViewController *addVC = [self.storyboard instantiateViewControllerWithIdentifier:@"addVC"];
    [addVC setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [addVC setP:self];
    [self.navigationController pushViewController:addVC animated:YES];
}

-(void)sortAction{
    sortCheck = 1;
    [self.tableView reloadData];
}
-(NSInteger)numSection:(NSInteger)secNum{
    NSMutableArray *high;
    NSMutableArray *low;
    NSMutableArray *medium;
    NSInteger num = 0;
    high= [NSMutableArray new];
    low= [NSMutableArray new];
    medium= [NSMutableArray new];
    for (int i =0 ; i<[toDoArray count]; i++) {
        if ([[[toDoArray objectAtIndex:i] taskPriority ]isEqualToString:@"High"]) {
            [high addObject:[toDoArray objectAtIndex:i]];
            [indexArray addObject:@(i)];
           }else if ([[[toDoArray objectAtIndex:i] taskPriority ]isEqualToString:@"Low"]) {
               [low addObject:[toDoArray objectAtIndex:i]];
               [indexArray addObject:@(i)];
        }else{
            [medium addObject:[toDoArray objectAtIndex:i]];
            [indexArray addObject:@(i)];
        }}
    switch (secNum) {
        case 0:
            num = [high count];
            break;
        case 1:
            num = [medium count];
            break;
        default:
            num = [low count];
            break;
    }
    return num;
}
-(NSMutableArray*)dataSection:(NSInteger)secNum{
    NSMutableArray *arr;
    indexArray = [NSMutableArray new];
    arr= [NSMutableArray new];
    switch (secNum) {
        case 0:
            for (int i =0 ; i<[toDoArray count]; i++) {
                if ([[[toDoArray objectAtIndex:i] taskPriority ]isEqualToString:@"High"]) {
                    [arr addObject:[toDoArray objectAtIndex:i]];
                    [indexArray addObject:@(i)];
                   }}
            break;
        case 1:
            for (int i =0 ; i<[toDoArray count]; i++) {
                if ([[[toDoArray objectAtIndex:i] taskPriority ]isEqualToString:@"Medium"]) {
                    [arr addObject:[toDoArray objectAtIndex:i]];
                    [indexArray addObject:@(i)];
                   }}
            break;
        default:
            for (int i =0 ; i<[toDoArray count]; i++) {
                if ([[[toDoArray objectAtIndex:i] taskPriority ]isEqualToString:@"Low"]) {
                    [arr addObject:[toDoArray objectAtIndex:i]];
                    [indexArray addObject:@(i)];
                   }}
            break;
    }
    return arr;
}

-(void)addTask:(Task*)task{
    [toDoArray addObject:task];
    searchArray = toDoArray;
    [self saveData];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    int num;
    switch (sortCheck) {
        case 1:
            num = 3;
            break;
        default:
            num = 1;
            break;
    }
    return num;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger num;
    switch (sortCheck) {
        case 1:
            num =[self numSection:section];
            break;
        default:
            num = [searchArray count];
            break;
    }
    return num;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *sectionTitle = @"";
    switch (sortCheck) {
        case 1:
            switch (section) {
                case 0:
                    sectionTitle = @"High";
                    break;
                case 1:
                    sectionTitle = @"Meduim";
                    break;
                case 2:
                    sectionTitle = @"Low";
                    break;
                default:
                    break;
            }
            break;
        default:
            sectionTitle = @"To Do";
            break;
    }
    return sectionTitle;
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *headerView = [UITableViewHeaderFooterView new];

    [headerView.contentView setBackgroundColor: [UIColor colorWithRed: 200.0 / 255.0 green: 200.0 / 255.0 blue: 255.0 / 255.0 alpha: 1] ];
    [headerView.textLabel setTextColor:[UIColor blackColor]];
 
  return headerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    switch (sortCheck) {
        case 1:
            searchArray = [self dataSection:indexPath.section];
            break;
        default:
            break;
    }
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
    
        if ([[[searchArray objectAtIndex:indexPath.row] taskState ]isEqualToString:@"In Progress"]) {
            cell.backgroundColor = [UIColor
                                    colorWithRed: 255.0 / 255.0
                                    green: 210.0 / 255.0
                                    blue: 210.0 / 255.0
                                    alpha: 1.0
                                    ];
            //cell.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:.7];
        }
        if ([[[searchArray objectAtIndex:indexPath.row] taskState ]isEqualToString:@"Done"]) {
            cell.backgroundColor = [UIColor
                                    colorWithRed: 210.0 / 255.0
                                    green: 255.0 / 255.0
                                    blue: 210.0 / 255.0
                                    alpha: 1.0
                                    ];
        }
    if ([[[searchArray objectAtIndex:indexPath.row] taskState ]isEqualToString:@"To Do"]){
            cell.backgroundColor = [UIColor
                                    colorWithRed: 180.0 / 255.0
                                    green: 210.0 / 255.0
                                    blue: 255.0 / 255.0
                                    alpha: 1.0
                                    ];
        }
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
    [toDoArray removeObjectAtIndex:index];
    [self saveData];
    [self.tableView reloadData];
}

#pragma mark - Search Bar
/*
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self.searchBar setShowsCancelButton:YES animated:YES];
}*/
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self.searchBar setShowsCancelButton:NO animated:YES];
    searchBar.text = @"";
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length == 0) {
        searchArray =toDoArray;
        [self.searchBar endEditing:YES];
    }
    else {
        sortCheck = 0;
        searchArray =[NSMutableArray new];
        indexArray =[NSMutableArray new];
        for (int i=0 ; i<[toDoArray count];i++) {
            NSRange range = [[[toDoArray objectAtIndex:i] taskName] rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (range.location != NSNotFound) {
                [searchArray addObject:[toDoArray objectAtIndex:i]];
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
