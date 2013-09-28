//
//  SHCCalendarViewController.m
//  ClearStyle
//
//  Created by Harsha Vardhan on 6/24/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import "SHCCalendarViewController.h"
#import "TSQCalendarView.h"
#import "TSQTACalendarRowCell.h"
#import "SHCAddTaskViewController.h"
#import "SHCViewControllerEditScreen.h"


@interface SHCCalendarViewController ()
@property (nonatomic, retain) NSTimer *timer;
@end
@interface TSQCalendarView (AccessingPrivateStuff)

@property (nonatomic, readonly) UITableView *tableView;

@end

@implementation SHCCalendarViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
         TSQCalendarView *calendarView = [[TSQCalendarView alloc] init];
        calendarView.calendar = self.calendar;
        calendarView.rowCellClass = [TSQTACalendarRowCell class];
        calendarView.firstDate = [NSDate dateWithTimeIntervalSinceNow:-60 * 60 * 24 * 365 * 1];
        calendarView.lastDate = [NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24 * 365 * 5];
        calendarView.backgroundColor = [UIColor colorWithRed:0.84f green:0.85f blue:0.86f alpha:1.0f];
        calendarView.pagingEnabled = YES;
        CGFloat onePixel = 1.0f / [UIScreen mainScreen].scale;
        calendarView.contentInset = UIEdgeInsetsMake(0.0f, onePixel, 0.0f, onePixel);
        [calendarView setDelegate:self] ;
        self.view = calendarView;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(BOOL)shouldAutorotate
{
    return NO;
    
}
- (void)viewDidLayoutSubviews;
{
    // Set the calendar view to show today date on start
    [(TSQCalendarView *)self.view scrollToDate:[NSDate date] animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillDisappear:(BOOL)animated;
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scroll;
{
    static BOOL atTop = YES;
    TSQCalendarView *calendarView = (TSQCalendarView *)self.view;
    UITableView *tableView = calendarView.tableView;
    
    [tableView setContentOffset:CGPointMake(0.f, atTop ? 10000.f : 0.f) animated:YES];
    atTop = !atTop;
}

- (void)calendarView:(TSQCalendarView *)calendarView didSelectDate:(NSDate *)date;
{
    if([self isedit])
    {
          
        SHCViewControllerEditScreen* caller = (SHCViewControllerEditScreen *)   [self presentingViewController];
         [caller calenderControllerProcessDate:date];
    
    }
    
    else
    {
 SHCAddTaskViewController* caller = (SHCAddTaskViewController *)   [self presentingViewController];
         [caller calenderControllerProcessDate:date];
    }
 
   
	[[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

@end
