//
//  SHCViewController.m
//  ClearStyle
//
//  Created by Fahim Farook on 22/9/12.
//  Copyright (c) 2012 RookSoft Pte. Ltd. All rights reserved.
//

#import "SHCViewController.h"
#import "SHCToDoItem.h"
#import "SHCTableViewCell.h"
#import "SHCAddTaskViewController.h"
#import "SHCToDoStore.h"
#import "SHCListViewController.h"
#import "MPFoldTransition.h"
#import "MPFlipTransition.h"
#import  "SHCCellAddTask.h"


#import "UINavigationBar+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "FUICellBackgroundView.h"
#import "SHCViewControllerEditScreen.h"
#import "UIFont+FlatUI.h"
#import "SHCSelectThemeViewController.h"
#import "SHCAppDelegate.h"



@interface SHCViewController ()
@property (weak, nonatomic) IBOutlet FUIButton *menuButton;

@end

@implementation SHCViewController
{


    BOOL _pullDownInProgress;
    SHCCellAddTask* _placeholderCell;
}
    


@synthesize fetchedResultsController;
@synthesize cellBackgroundColor,labelFontColor,navigationbarColor,navigationbarTitleColor,buttonColor;


@synthesize userMovingTableRows;

@synthesize sourceSectionDefunctAfterUserMove;
@synthesize noTasksLabel;




-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {

       // this is the cell that will be shown when the user drags down to add a task.
        _placeholderCell= [[SHCCellAddTask alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"celladd"];
        
    }
    return self;
}

-(void)viewDidLoad {
    

    [super viewDidLoad];
	self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self setUserMovingTableRows:NO];
    [self setSourceSectionDefunctAfterUserMove:NO];
    fetchedResultsController.delegate = self;
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
          
		exit(-1);  // Fail
	}
    self.tableView.backgroundColor =[UIColor clearColor];

  
}
-(void)viewWillAppear:(BOOL)animated{

   [super viewWillAppear:animated];

    [self configureThemes];
    [[self tableView] reloadData];
    [self showOrHideNoTasksLabel];
}


-(BOOL)shouldAutorotate
{
    return NO;

}
-(void)configureThemes
{
    [self setCellBackgroundColor:[[[SHCToDoStore sharedStore] loadThemeProps] cellbackgroundColor]];
    
    [self setLabelFontColor:[[[SHCToDoStore sharedStore] loadThemeProps] fontColor]];
    
    [self setButtonColor:[[[SHCToDoStore sharedStore] loadThemeProps] buttonColor]];
    
    [self setNavigationbarColor:[[[SHCToDoStore sharedStore] loadThemeProps] navigationBarColor]];
    
    [self setNavigationbarTitleColor:[[[SHCToDoStore sharedStore] loadThemeProps] navigationBarTitleColor]];
    
    self.menuButton.buttonColor = [self buttonColor];
    self.menuButton.shadowColor = [self buttonColor];
    self.menuButton.shadowHeight = 3.0f;
    self.menuButton.cornerRadius = 6.0f;
    self.menuButton.titleLabel.font = [UIFont fontWithName:@"GillSans-Italic" size:16];
    [self.menuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.menuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];

    
    
    [self.navigationBar configureFlatNavigationBarWithColor:[self navigationbarColor]];
    

}
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// show the pull down to add a task label if there is not tasks.
-(void)showOrHideNoTasksLabel
{
    if([self getCountOfAllTasks]==0)
    {
        


        self.noTasksLabel.hidden= NO;
       
    }
    
    else
    {
        
        self.noTasksLabel.hidden = YES;
                
        
        
    }

}

-(void)showListView

{
    SHCListViewController * listviewController = [[SHCListViewController alloc] init];
    
    
    
    
  //[self presentViewController:listviewController animated:YES completion:nil];;
    [self presentViewController:listviewController
                      foldStyle:MPFoldStyleUnfold
                     completion:nil];
    
}

- (IBAction)showSettings:(id)sender {

    SHCSelectThemeViewController * controller = [[SHCSelectThemeViewController alloc]init];
  /**  SHCSettingsViewController * settingsController = [[SHCSettingsViewController alloc] init];
       
    [self presentViewController:settingsController animated:YES completion:nil];*/
    [self presentViewController:controller animated:YES completion:nil];
}
-(void)showAddTaskView
{
    SHCAddTaskViewController * addItemController = [[SHCAddTaskViewController alloc] init];
    [addItemController setDismissBlock:^{[[self tableView]reloadData];}];
    
    
    
[self presentViewController:addItemController
                      flipStyle:(MPFlipStyleFlipDirectionBit(MPFlipStyleOrientationVertical)) 
                     completion:nil];
    
     

    

}

-(void)toDoItemDeleted:(SHCToDoItem*)todoItem {
  
    
    [[SHCToDoStore sharedStore] removeItem:todoItem];
    
    
}



- (NSFetchedResultsController *)fetchedResultsController {
    
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
   
    NSManagedObjectContext * context = [[SHCToDoStore sharedStore] context];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"SHCToDoItem" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"duedatesection" ascending:YES];
    NSSortDescriptor *sort_order_completed = [[NSSortDescriptor alloc]
                                            initWithKey:@"completed" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sort,sort_order_completed,nil]];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:context sectionNameKeyPath:@"duedatesection"
                                                   cacheName:@"Root"];
    self.fetchedResultsController = theFetchedResultsController;
    fetchedResultsController.delegate = self;
    
    return fetchedResultsController;
    
}
-(NSUInteger) getCountOfAllTasks

{
    NSUInteger count = [[[self fetchedResultsController] fetchedObjects] count];
    
    
    return count;
}




- (IBAction)menuPressed:(id)sender {
    [self showMenu:sender];
}

- (NSUInteger )getCount {
    
    
    
    NSManagedObjectContext * context = [[SHCToDoStore sharedStore] context];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"SHCToDoItem" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"completed==%d", 0];
    [fetchRequest setEntity:entity];
    
    [fetchRequest setPredicate:predicate];
    
    return [[context executeFetchRequest:fetchRequest error:nil] count] ;
    
    
}


#pragma mark - UITableViewDataDelegate protocol methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    FUICellBackgroundView* backgroundView = [FUICellBackgroundView new];
    backgroundView.backgroundColor = [[self cellBackgroundColor] colorWithAlphaComponent:0.6];
    cell.backgroundView = backgroundView;

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{

      
    return [[[fetchedResultsController sections] objectAtIndex:section] name ];

}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[[self fetchedResultsController] sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSArray *sections = [[self fetchedResultsController] sections];
    id <NSFetchedResultsSectionInfo> sectionInfo = nil;
    sectionInfo = [sections objectAtIndex:section];

    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHCTableViewCell *cell = nil;
    SHCToDoItem *object = nil;
    object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
      
    

    
    cell = [[SHCTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
        // Initialize cell
        
        
        // TODO: Any other initialization that applies to all cells of this type.
        //       (Possibly create and add subviews, assign tags, etc.)
    

    
    cell.delegate = self;
    
    
    cell.todoItem = object;
    [[cell _label] setTextColor:labelFontColor];
    
    [cell putGesturesRecognizers];
    
    return cell;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
   
      
      
    
    if ([self userMovingTableRows]) {
             
		return;
	}
    [self.tableView beginUpdates];
      
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    
    if ([self userMovingTableRows]) {
           
          
		return;
	}
    
      
    NSArray *newArray = nil;
    if (newIndexPath) {
        newArray = [NSArray arrayWithObject:newIndexPath];
    }
    NSArray *oldArray = nil;
    if (indexPath) {
        oldArray = [NSArray arrayWithObject:indexPath];
    }
    switch(type) {
        case NSFetchedResultsChangeInsert:
              
            [[self tableView] insertRowsAtIndexPaths:newArray
                                    withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
              
            [[self tableView] deleteRowsAtIndexPaths:oldArray
                                    withRowAnimation:UITableViewRowAnimationLeft];
            [self  showOrHideNoTasksLabel];
            break;
        case NSFetchedResultsChangeUpdate: {
              
            //UITableViewCell *cell = nil;
            //NSManagedObject *object = nil;
            //cell = [[self tableView] cellForRowAtIndexPath:indexPath];
            //object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
            //[[cell textLabel] setText:[object valueForKey:@"text"]];
            break;
        }
        case NSFetchedResultsChangeMove:
            [[self tableView] deleteRowsAtIndexPaths:oldArray
                                    withRowAnimation:UITableViewRowAnimationLeft];
            [[self tableView] insertRowsAtIndexPaths:newArray
                                    withRowAnimation:UITableViewRowAnimationFade];
        break;
    
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:
(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {

    if ([self userMovingTableRows]) {
        if (type == NSFetchedResultsChangeDelete) {
			[self setSourceSectionDefunctAfterUserMove:YES];
		}
		return;
	}
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    
    
    if ([self userMovingTableRows]) {
		return;
	}
    [self.tableView endUpdates];
}


-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
      
    if ([sourceIndexPath isEqual:destinationIndexPath]) {
		return;
	}
    [self setUserMovingTableRows:YES];
    SHCToDoItem *itemToMove = [[self fetchedResultsController] objectAtIndexPath:sourceIndexPath];
    id sourceSectionInfo = [[self fetchedResultsController] sections][[sourceIndexPath section]];
	id destSectionInfo = [[self fetchedResultsController] sections][[destinationIndexPath section]];
    NSString *destCategory = [[destSectionInfo objects][0] duedatesection];
    
    if ([sourceIndexPath section] == [destinationIndexPath section]) {
		if ([destinationIndexPath row] < [sourceIndexPath row]) {
			[self shiftDisplayIndexesOfItemsInSection:[destinationIndexPath section] range:NSMakeRange([destinationIndexPath row], [sourceIndexPath row] - [destinationIndexPath row]) byAmount:1];
		} else {
			[self shiftDisplayIndexesOfItemsInSection:[destinationIndexPath section] range:NSMakeRange([sourceIndexPath row] + 1, [destinationIndexPath row] - [sourceIndexPath row]) byAmount:-1];
		}
	}
    
    
    else {
		[self shiftDisplayIndexesOfItemsInSection:[sourceIndexPath section] range:NSMakeRange([sourceIndexPath row] + 1, [sourceSectionInfo numberOfObjects] - [sourceIndexPath row] - 1) byAmount:-1];
		[self shiftDisplayIndexesOfItemsInSection:[destinationIndexPath section] range:NSMakeRange([destinationIndexPath row], [destSectionInfo numberOfObjects] - [destinationIndexPath row]) byAmount:1];
	}
[itemToMove setDuedatesection:destCategory];
[itemToMove setDisplayOrder:@([destinationIndexPath row])];

    [[SHCToDoStore sharedStore] saveChanges];
    if ([self sourceSectionDefunctAfterUserMove]) {
		[[self tableView] reloadData];
		[self setSourceSectionDefunctAfterUserMove:NO];
	}
    [self setUserMovingTableRows:NO];
    


}
- (void)shiftDisplayIndexesOfItemsInSection:(NSInteger)section range:(NSRange)range byAmount:(NSInteger)amount
{
	for (NSUInteger shiftIndex = range.location; shiftIndex < NSMaxRange(range); shiftIndex++) {
		NSIndexPath *indexPathOfItemToShift = [NSIndexPath indexPathForRow:shiftIndex inSection:section];
		SHCToDoItem *itemToShift = [[self fetchedResultsController] objectAtIndexPath:indexPathOfItemToShift];
		[itemToShift setDisplayOrder:@([[itemToShift displayOrder] integerValue] + amount)];
	}
}
-(void)handleLongPress

{
      
    [[self tableView] setEditing: YES animated: YES];

}
-(void)editTable
{
      
    [[self tableView] setEditing: YES animated: YES];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableview shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


- (BOOL)tableView:(UITableView *)tableview canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)handleViewsSwipe:(UISwipeGestureRecognizer *)recognizer {
      
[self showListView];
    
    
}
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
      
    
    if ([gestureRecognizer isMemberOfClass:[UISwipeGestureRecognizer class]]){
          
        UISwipeGestureRecognizer * swipe = (UISwipeGestureRecognizer*)gestureRecognizer;
        UISwipeGestureRecognizerDirection swipe_direction = [swipe direction];
        if(swipe_direction == UISwipeGestureRecognizerDirectionRight){
            return YES;
            
        }
        
        
        
        
    }
return NO;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // this behaviour starts when a user pulls down while at the top of the table
   
    _pullDownInProgress = scrollView.contentOffset.y <= 0.0f;
    if (_pullDownInProgress) {
        // add your placeholder
          
        
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    

    if (_pullDownInProgress && self.tableView.contentOffset.y <= 0.0f) {
        
        // maintain the location of the placeholder
_placeholderCell.frame = CGRectMake(0, - self.tableView.contentOffset.y*1.5 - 50.0,
                                            [self tableView].frame.size.width, 40);

        if(-self.tableView.contentOffset.y > 40.0)
        {
            [_placeholderCell setLabelText:@"Pull to add a new task"];
          
            [_placeholderCell setLabelBackground];
            [[self view] insertSubview:_placeholderCell atIndex:1];
        }
        if(-self.tableView.contentOffset.y > 60.0)
        {
            [_placeholderCell setLabelText:@"Release to add a new task"];
        
        }
        
_placeholderCell.alpha = MIN(1.0f, - self.tableView.contentOffset.y / 50.0);
    } else {
        _pullDownInProgress = false;
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // check whether the user pulled down far enough
    if (_pullDownInProgress && - self.tableView.contentOffset.y > 60.0) {


        [self showAddTaskView];
        
    }
    _pullDownInProgress = false;
    [_placeholderCell removeFromSuperview];
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
   
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, tableView.bounds.size.width, 22.0)];
    [headerView setBackgroundColor:[UIColor clearColor]];
    
    // Add the label
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0.0,
                                                                   [self tableView].frame.size.width  ,22.0)];

    
    [headerLabel setBackgroundColor:[UIColor clearColor]];
    
    headerLabel.text =[self tableView:tableView titleForHeaderInSection:section];

    [headerLabel setTextColor:[UIColor colorWithRed:44/255.0 green:62/255.0 blue:80/255.0 alpha:1]];
    
    [headerView addSubview:headerLabel];
    
    // Return the headerView
    return headerView;
}
-(void)enterEditingMode
{
    [[self tableView] setEditing: YES animated: YES];

}
-(void)showMenu:(UIButton*) sender

{

    
    NSInteger numberOfOptions = 4;
    NSArray *items = @[
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"arrow"] title:@"Add task"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"attachment"] title:@"See lists"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"bluetooth"] title:@"Themes"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"block"] title:@"Cancel"]
                       
                       
                       ];
  
    
    RNGridMenu *av = [[RNGridMenu alloc] initWithItems:[items subarrayWithRange:NSMakeRange(0, numberOfOptions)]];
    av.delegate = self;
    [av setHighlightColor:[UIColor clearColor]];
    [av setMenuStyle:RNGridMenuStyleGrid];
    [av setBlurLevel:0.25];
    UIFont* marion = [UIFont fontWithName:@"Marion-Italic" size:20];
    [av setItemFont:marion];
    [av setAnimationDuration:0.2];

   

    [av showInViewController:self center:CGPointMake(self.view.bounds.size.width/2.f, self.view.bounds.size.height/2.f)];

    

    
    
}

- (void)gridMenu:(RNGridMenu *)gridMenu willDismissWithSelectedItem:(RNGridMenuItem *)item atIndex:(NSInteger)itemIndex {
    switch(itemIndex )
    {
        case 0:
            [self showAddTaskView];
            break;
        case 1:
            [self showListView];
            break;
        case 2:
            [self showSettings:self];
            break;
        default:
            break;
    
    }

}
-(void)cellTapped:(SHCToDoItem *)itemTapped
{
    SHCViewControllerEditScreen * controller = [[SHCViewControllerEditScreen alloc] init];
    [controller setItemToEdit:itemTapped];
    [self presentViewController:controller animated:YES completion:nil];
  
}
@end
