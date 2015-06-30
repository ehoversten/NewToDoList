//
//  ViewController.m
//  NewToDoList
//
//  Created by Erik Hoversten on 27.06.15.
//  Copyright (c) 2015 EverProductions. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "ToDoTasks.h"
#import <CoreData/CoreData.h>

#import "DetailViewController.h"


@interface ViewController ()

@property (nonatomic, strong) AppDelegate             *appDelegate;
@property (nonatomic, strong) NSManagedObjectContext  *managedObjectContext;

@property (nonatomic, strong)IBOutlet UITableView     *taskTableView;
@property (nonatomic, strong) NSArray                 *dataArray; // array to hold data temporary in the Context




@end

@implementation ViewController

#pragma mark - Button Methods

- (IBAction)addButtonPressed:(id)sender {
    NSLog(@"Add New Record");    
    [self performSegueWithIdentifier:@"addNewToDetailSegue" sender:self];
}

#pragma mark - Table View Methods

- (NSInteger)numberOfSectionsInTableView: (UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSLog(@"Tasks %li", _dataArray.count);
    return _dataArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    ToDoTasks *currentToDo = [_dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [currentToDo taskName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%i", [[currentToDo taskPriority] intValue] +1 ];

//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[currentToDo dateDue]];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected");
    [self performSegueWithIdentifier:@"listToDetailSegue" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController *destController = [segue destinationViewController];
    
    if ([[segue identifier] isEqualToString:@"listToDetailSegue"])  {
        NSIndexPath *indexPath = [_taskTableView indexPathForSelectedRow];
        //DetailViewController ( *destController);   // why does this screw up things?
        ToDoTasks *tasks = [_dataArray objectAtIndex:indexPath.row];
        destController.toDoObject = tasks;
    } else if ([[segue identifier] isEqualToString:@"addNewDetailSegue"]) {
        destController.toDoObject = nil;
    }
    
}


#pragma mark - Database Methods

- (void)addTempRecord {
    NSLog(@"Add Record");
    
    ToDoTasks *newTask = (ToDoTasks *) [NSEntityDescription insertNewObjectForEntityForName:@"ToDoTasks" inManagedObjectContext:_managedObjectContext];
    [newTask setTaskName:@"Home Work"];
    [newTask setTaskDescription:@"Work on ToDoList Porgram."];
    [newTask setTaskCatagory:@"Work vs. Home"];
    [newTask setTaskPriority:[NSNumber numberWithInt:2]];
    [newTask setTaskCompleted:[NSNumber numberWithBool:true]];
    [newTask setDateEntered:[NSDate date]];
    [newTask setDateDue:[NSDate date]];
    [newTask setDateUpdated:[NSDate date]];
    [newTask setDateCompleted:[NSDate date]];

//    [_appDelegate saveContext];
}


-(NSArray *)fetchToDoTasks {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ToDoTasks" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];   // Are we creating an Object out of our Entity here?
    return [_managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
}


#pragma mark PickerView Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _dataArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _dataArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"Row: %li  Label: %@", (long)row, _dataArray[row]);
}

#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initializing Appdelegate Control
    _appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    _managedObjectContext = _appDelegate.managedObjectContext;   // allows appDelegate to run managedObjectontext
    
//    [self addTempRecord];
}

- (void)viewWillAppear:(BOOL)animated   {
    [super viewWillAppear:animated];
//    [self addTempRecord];
    _dataArray = [self fetchToDoTasks];
    NSLog(@"Count : %li", _dataArray.count);
    [_taskTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
