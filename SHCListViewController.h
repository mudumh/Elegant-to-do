//
//  SHCListViewController.h
//  ClearStyle
//
//  Created by Harsha Vardhan on 6/3/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SHCTableViewCellDelegate.h"
#import "RNGridMenu.h"

@interface SHCListViewController : UIViewController<NSFetchedResultsControllerDelegate,SHCTableViewCellDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,RNGridMenuDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)menuPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *noTaskLabel;


@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

- (IBAction)backButtonPressed:(id)sender;
-(NSUInteger) getCountOfAllTasks;
@property BOOL userMovingTableRows;
@property BOOL sourceSectionDefunctAfterUserMove;


@property UIColor* cellBackgroundColor;
@property UIColor* labelFontColor;
@property(nonatomic,strong) UIColor* buttonColor;
@property(nonatomic,strong) UIColor* navigationbarColor;
@property(nonatomic,strong) UIColor* navigationbarTitleColor;




@property(strong,nonatomic) NSFetchedResultsController * fetchedResultsController_list;
@end
