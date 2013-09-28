//
//  SHCToDoItem.h
//  ClearStyle
//
//  Created by Harsha Vardhan on 7/9/13.
//  Copyright (c) 2013 HarshaProjects. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SHCToDoItem : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * completed;
@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) NSDate * duedate;
@property (nonatomic, retain) NSString * duedatesection;
@property (nonatomic, retain) NSString * list;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * text;

@end
