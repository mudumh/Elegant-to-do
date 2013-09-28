//
//  SHCCalendarViewController.h
//  ClearStyle
//
//  Created by Harsha Vardhan on 6/24/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSQCalendarView.h"

@interface SHCCalendarViewController : UIViewController <TSQCalendarViewDelegate>
@property (nonatomic, strong) NSCalendar *calendar;
@property(nonatomic) BOOL isedit;


@end
