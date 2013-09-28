//
//  SHCListViewController.m
//  ClearStyle
//
//  Created by Harsha Vardhan on 6/3/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import "SHCListViewController.h"

#import "SHCToDoItem.h"
#import "SHCTableViewCell.h"
#import "SHCAddTaskViewController.h"
#import "SHCToDoStore.h"
#import "MPFoldTransition.h"
#import "MPFlipTransition.h"
#import "SHCToDoItem.h"
#import "SHCCellAddTask.h"

#import "SHCSelectThemeViewController.h"
#import "UINavigationBar+FlatUI.h"

#import "UIColor+FlatUI.h"
#import "FUICellBackgroundView.h"
#import "UIFont+FlatUI.h"
#import "SHCViewControllerEditScreen.h"

@interface SHCListViewController ()

@property (weak, nonatomic) IBOutlet FUIButton *menuButton;
@property (weak, nonatomic) IBOutlet FUIButton *backButton;


@end

@implementation SHCListViewController
{

 SHCCellAddTask* _placeholderCell;
 BOOL _pullDownInProgress;
}
@synthesize fetchedResultsController_list;
@synthesize cellBackgroundColor,labelFontColor,navigationbarColor,navigationbarTitleColor,buttonColor;
@synthesize noTaskLabel;
@synthesize userMovingTableRows;
@synthesize sourceSectionDefunctAfterUserMove;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[self view] setBackgroundColor:[UIColor clearColor]];
       
     _placeholderCell= [[SHCCellAddTask alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"celladd"];
        [self setNavigationbarColor:[[[SHCToDoStore sharedStore] loadThemeProps] navigationBarColor]];
        [self.navigationBar configureFlatNavigationBarWithColor:[self navigationbarColor]];
    }
    return self;
}

- (void)viewDidLoad
{    [super viewDidLoad];

	self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self setUserMovingTableRows:NO];
    [self setSourceSectionDefunctAfterUserMove:NO];
    
    fetchedResultsController_list.delegate = self;
    NSError *error;
	if (![[self fetchedResultsController_list] performFetch:&error]) {
		// Update to handle the error appropriately.
		  
		exit(-1);  // Fail
	}
    [self configureThemes];
    
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
	[self.tableView registerClass:[SHCTableViewCell class] forCellReuseIdentifier:@"Cell"];
     self.noTaskLabel.hidden = YES;
    
}

-(void)viewWillAppear:(BOOL)animated{

    

    
      

    [self configureThemes];
    
    [[self tableView] reloadData];
    
    [super viewWillAppear:animated]  ;
     
    
}

-(BOOL)shouldAutorotate
{
    return NO;
    
}
-(void)showOrHideNoTasksLabel
{
    if([self getCountOfAllTasks]==0)
    {
        
        
        self.noTaskLabel.hidden= NO;
    }
    
    else
    {
        
        self.noTaskLabel.hidden = YES;
        
        
    }
    
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
    [self.menuButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [self.menuButton setTitleColor:[UIColor whiteColor]forState:UIControlStateHighlighted];
    
    self.backButton.buttonColor = [self buttonColor];
    self.backButton.shadowColor = [self buttonColor];
    self.backButton.shadowHeight = 3.0f;
    self.backButton.cornerRadius = 6.0f;
    self.backButton.titleLabel.font = [UIFont fontWithName:@"GillSans-Italic" size:16];
    [self.backButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [self.backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.navigationBar configureFlatNavigationBarWithColor:[self navigationbarColor]];
    



}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataDelegate protocol methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}




- (IBAction)addItem:(id)sender {
    SHCAddTaskViewController * addItemController = [[SHCAddTaskViewController alloc] init];
    [addItemController setDismissBlock:^{[[self tableView]reloadData];}];
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:addItemController ];
    [navController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [navController setModalPresentationStyle:UIModalPresentationFormSheet];
    [self presentViewController:navController animated:YES completion:nil];;
    
}
-(void)toDoItemDeleted:(SHCToDoItem*)todoItem {
    
    [[SHCToDoStore sharedStore] removeItem:todoItem];
}


- (NSFetchedResultsController *)fetchedResultsController_list {
    
    if (fetchedResultsController_list != nil) {
        return fetchedResultsController_list;
    }
   
    NSManagedObjectContext * context = [[SHCToDoStore sharedStore] context];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"SHCToDoItem" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"list" ascending:YES];
   // NSSortDescriptor *sort_display_order = [[NSSortDescriptor alloc]
     //                                       initWithKey:@"displayOrder" ascending:YES];
    NSSortDescriptor *sort_order_completed = [[NSSortDescriptor alloc]
                                              initWithKey:@"completed" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sort,sort_order_completed,nil]];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:context sectionNameKeyPath:@"list"
                                                   cacheName:@"Root"];
    self.fetchedResultsController_list = theFetchedResultsController;
    fetchedResultsController_list.delegate = self;
    
    return fetchedResultsController_list;
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	// Display the authors' names as section headings.
    
return [[[fetchedResultsController_list sections] objectAtIndex:section] name] ;
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[[self fetchedResultsController_list] sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSArray *sections = [[self fetchedResultsController_list] sections]; id <NSFetchedResultsSectionInfo> sectionInfo = nil;
    sectionInfo = [sections objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FUICellBackgroundView* backgroundView = [FUICellBackgroundView new];
    backgroundView.backgroundColor = [[self cellBackgroundColor] colorWithAlphaComponent:0.6];
    cell.backgroundView = backgroundView;
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
                                    withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate: {
            
           // UITableViewCell *cell = nil;
            //NSManagedObject *object = nil;
            //cell = [[self tableView] cellForRowAtIndexPath:indexPath];
            //object = [[self fetchedResultsController_list] objectAtIndexPath:indexPath]; [[cell textLabel] setText:[object valueForKey:@"text"]];
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
-(void)back:(id)sender
{

    [[self presentingViewController] dismissViewControllerWithFoldStyle:MPFoldStyleUnfold completion:nil];

}



-(void)showMenu:(UIButton*) sender

{
    

    
    
    NSInteger numberOfOptions = 4;
    NSArray *items = @[
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"arrow"] title:@"Add task"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"attachment"] title:@"See due dates"],
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
    
    
    //    av.bounces = NO;
    [av showInViewController:self center:CGPointMake(self.view.bounds.size.width/2.f, self.view.bounds.size.height/2.f)];
    
    
    
    
    


    
}
- (void)gridMenu:(RNGridMenu *)gridMenu willDismissWithSelectedItem:(RNGridMenuItem *)item atIndex:(NSInteger)itemIndex {
    switch(itemIndex )
    {
        case 0:
            [self showAddTaskView];
            break;
        case 1:
            [self back:self];
            break;
        case 2:
            [self showSettings:self];
            break;
        default:
            break;
            
            
            
    }
    
    
      
}

- (IBAction)menuPressed:(id)sender {
    [self showMenu:sender];
}

- (IBAction)backButtonPressed:(id)sender {
        [self back:sender];
    
}
- (void)showSettings:(id)sender {
    
    
   SHCSelectThemeViewController * controller = [[SHCSelectThemeViewController alloc]init];

    [self presentViewController:controller animated:YES completion:nil];
}
-(void)showDates
{

    SHCViewController * listviewController = [[SHCViewController alloc] init];
    
    
    
    
    //[self presentViewController:listviewController animated:YES completion:nil];;
    [self presentViewController:listviewController
                      foldStyle:MPFoldStyleUnfold
                     completion:nil];
    
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
      
    if ([sourceIndexPath isEqual:destinationIndexPath]) {
		return;
	}
    [self setUserMovingTableRows:YES];
    SHCToDoItem *itemToMove = [[self fetchedResultsController_list] objectAtIndexPath:sourceIndexPath];
    id sourceSectionInfo = [[self fetchedResultsController_list] sections][[sourceIndexPath section]];
	id destSectionInfo = [[self fetchedResultsController_list] sections][[destinationIndexPath section]];
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
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHCTableViewCell *cell = nil;
    SHCToDoItem *object = nil;
    object = [[self fetchedResultsController_list] objectAtIndexPath:indexPath];
    
    cell = [[SHCTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    cell.delegate = self;
    cell.todoItem = object;
    [[cell _label] setTextColor:labelFontColor];
    [cell putGesturesRecognizers];
    return cell;
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
      
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, tableView.bounds.size.width, 22.0)];
    [headerView setBackgroundColor:[UIColor clearColor]];
    
    // Add the label
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0.0,
                                                                     [self tableView].frame.size.width  ,22.0)];
    
    // do whatever headerLabel configuration you want here
    [headerLabel setBackgroundColor:[UIColor clearColor]];
    
    headerLabel.text =[self tableView:tableView titleForHeaderInSection:section];
    
    [headerLabel setTextColor:[UIColor colorWithRed:44/255.0 green:62/255.0 blue:80/255.0 alpha:1]];
    
    [headerView addSubview:headerLabel];
    
    // Return the headerView
    return headerView;
}

- (void)shiftDisplayIndexesOfItemsInSection:(NSInteger)section range:(NSRange)range byAmount:(NSInteger)amount
{
	for (NSUInteger shiftIndex = range.location; shiftIndex < NSMaxRange(range); shiftIndex++) {
		NSIndexPath *indexPathOfItemToShift = [NSIndexPath indexPathForRow:shiftIndex inSection:section];
		SHCToDoItem *itemToShift = [[self fetchedResultsController_list] objectAtIndexPath:indexPathOfItemToShift];
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


- (BOOL)tableView:(UITableView *)tableview canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // this behaviour starts when a user pulls down while at the top of the table
    
    _pullDownInProgress = scrollView.contentOffset.y <= 0.0f;
    if (_pullDownInProgress) {
        // add your placeholder
       
                              }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //CONTENT OFFSET -
    //the content offset for a scroll view :
    //  origin.scrollview.y - origin.y.contentview
    if (_pullDownInProgress && self.tableView.contentOffset.y <= 0.0f) {
        // maintain the location of the placeholder
        _placeholderCell.frame = CGRectMake(0, - self.tableView.contentOffset.y*1.5 - 50.0,
                                            [self tableView].frame.size.width, 40);
        
        if(-self.tableView.contentOffset.y > 40.0)
        {
            [_placeholderCell setLabelText:@"Pull to add a new task"];
            //  [_placeholderCell setTodoItem:test];
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
-(void)showAddTaskView
{
    SHCAddTaskViewController * addItemController = [[SHCAddTaskViewController alloc] init];
    [addItemController setDismissBlock:^{[[self tableView]reloadData];}];
    
    
    
    [self presentViewController:addItemController
                      flipStyle:(MPFlipStyleFlipDirectionBit(MPFlipStyleOrientationVertical))
                     completion:nil];
    
    
    
}

-(NSUInteger) getCountOfAllTasks

{
    NSUInteger count = [[[self fetchedResultsController_list] fetchedObjects] count];
    
    
    return count;
}

-(void)cellTapped:(SHCToDoItem *)itemTapped
{
    
    
    SHCViewControllerEditScreen * controller = [[SHCViewControllerEditScreen alloc] init];
    [controller setItemToEdit:itemTapped];
    [controller setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:controller animated:YES completion:nil];
    
}

@end




