//
//  DetailViewController.m
//  NewToDoList
//
//  Created by Erik Hoversten on 28.06.15.
//  Copyright (c) 2015 EverProductions. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"


@interface DetailViewController ()

@property (nonatomic, strong) AppDelegate            *appDelegate;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong) IBOutlet UITextField         *taskNameTextField;
@property (nonatomic, strong) IBOutlet UISegmentedControl  *taskPrioritySeg;
@property (nonatomic, strong) IBOutlet UISegmentedControl  *taskCatagorySeg;
@property (nonatomic, strong) IBOutlet UIDatePicker        *taskDueDatePicker;
@property (nonatomic, strong) IBOutlet UITextView          *taskDescription;
@property (nonatomic, strong) IBOutlet UISwitch            *taskCompletedSwitch;



@end

@implementation DetailViewController

#pragma mark - Button Methods

- (IBAction)saveButtonPressed:(id)sender  {
    NSLog(@"Saved");
    _toDoObject.taskName = _taskNameTextField.text;
//    _toDoObject.taskCatagory = [NSString stringWithFormat:@"%@",[_taskCatagorySeg.selectedSegmentIndex intValue]];
    _toDoObject.taskPriority = [NSNumber numberWithInt: [_taskNameTextField.text intValue]];
//    _toDoObject.taskPriority = [NSNumber numberWithLong:_taskPrioritySeg.selectedSegmentIndex];
    _toDoObject.dateDue = _taskDueDatePicker.date;
    [_appDelegate saveContext];
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)deleteButtonPressed:(id)sender {
    NSLog(@"Record Deleted");
    [_managedObjectContext deleteObject:_toDoObject];    // removes object data from memory
    [_appDelegate saveContext];
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark - Interactivity Methods

//     Create ability to Hide the Keyboard when Return Key is pressed
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _managedObjectContext = _appDelegate.managedObjectContext;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated  {
    [super viewWillAppear:animated];

    // is there already and Object? if not create it
    if (_toDoObject != nil) {
        _taskNameTextField.text = [_toDoObject taskName];
//        [_taskPrioritySeg setSelectedSegmentIndex:[_toDoObject.taskPriority intValue]];
//        [_taskCatagorySeg setSelectedSegmentIndex:[_toDoObject.taskCatagory intValue]];
//        [_taskDueDatePicker setDate:_toDoObject.dateDue];
    } else {
        ToDoTasks *newAddToDo = (ToDoTasks *)[NSEntityDescription insertNewObjectForEntityForName:@"ToDoTasks" inManagedObjectContext:_managedObjectContext];
        _toDoObject = newAddToDo;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
