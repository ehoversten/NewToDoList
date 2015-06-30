//
//  ToDoTasks.h
//  NewToDoList
//
//  Created by Erik Hoversten on 27.06.15.
//  Copyright (c) 2015 EverProductions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ToDoTasks : NSManagedObject

@property (nonatomic, retain) NSString * taskName;
@property (nonatomic, retain) NSString * taskCatagory;
@property (nonatomic, retain) NSNumber * taskPriority;
@property (nonatomic, retain) NSNumber * taskCompleted;
@property (nonatomic, retain) NSDate * dateEntered;
@property (nonatomic, retain) NSDate * dateDue;
@property (nonatomic, retain) NSDate * dateUpdated;
@property (nonatomic, retain) NSDate * dateCompleted;
@property (nonatomic, retain) NSString * taskDescription;

@end
