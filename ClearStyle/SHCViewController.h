//
//  SHCViewController.h
//  ClearStyle
//
//  Created by Fahim Farook on 22/9/12.
//  Copyright (c) 2012 RookSoft Pte. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHCTableViewCellDelegate.h"
#import "RNGridMenu.h"



@interface SHCViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, SHCTableViewCellDelegate,NSFetchedResultsControllerDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate,RNGridMenuDelegate>
{


}

@property (weak, nonatomic) IBOutlet UITableView *tableView;



@property(strong,nonatomic) NSFetchedResultsController * fetchedResultsController;
@property BOOL userMovingTableRows;
@property BOOL sourceSectionDefunctAfterUserMove;
@property(nonatomic,strong) UIColor* cellBackgroundColor;
@property(nonatomic,strong) UIColor* buttonColor;
@property(nonatomic,strong) UIColor* labelFontColor;
@property(nonatomic,strong) UIColor* navigationbarColor;
@property(nonatomic,strong) UIColor* navigationbarTitleColor;

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

- (IBAction)menuPressed:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *noTasksLabel;

-(NSUInteger)getCount;
-(NSUInteger)getCountOfAllTasks;
-(void)showListView;


@end
