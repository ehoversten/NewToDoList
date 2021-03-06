//
//  DetailViewController.h
//  NewToDoList
//
//  Created by Erik Hoversten on 28.06.15.
//  Copyright (c) 2015 EverProductions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoTasks.h"

@interface DetailViewController : UIViewController <UITextFieldDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong)ToDoTasks          *toDoObject;

@end
