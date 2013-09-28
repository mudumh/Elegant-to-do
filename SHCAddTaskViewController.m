//
//  SHCAddTaskViewController.m
//  ClearStyle
//
//  Created by Harsha Vardhan on 6/1/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import "SHCAddTaskViewController.h"
#import "SHCToDoItem.h"
#import "SHCToDoStore.h"
#import "FUIAlertView.h"

#import "MPFoldTransition.h"
#import "MPFlipTransition.h"
#import "SHCViewController.h"
#import "UINavigationBar+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"
#import "FUIButton.h"
#import "SHCNotesViewController.h"
#import "SHCCalendarViewController.h"
#import "SHCListViewController.h"
#import "QuotesModel.h"
@interface SHCAddTaskViewController ()
@property (weak, nonatomic) IBOutlet FUIButton *doneButton;

@property (weak, nonatomic) IBOutlet FUIButton *cancelButton;
@property (weak, nonatomic) IBOutlet FUIButton *dueDateButton;
@property (weak, nonatomic) IBOutlet FUIButton *addNotes;
@property BOOL notesButtonClicked;
@property (weak, nonatomic) IBOutlet UIButton *crossButton;

@end

@implementation SHCAddTaskViewController
{
    NSString * duedatesection;
}
@synthesize dismissBlock;
@synthesize navigationBar;
@synthesize selectedDate;
@synthesize notes;
@synthesize notesLabel;
@synthesize quotesLabel;
@synthesize cellBackgroundColor,labelFontColor,navigationbarColor,navigationbarTitleColor,buttonColor;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       //[[self view] setBackgroundColor:[UIColor peterRiverColor]];
        
       
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableviewBackground.png"]];
      
        [self configureThemes];
        
        
 //self.selectedDate = [NSDate date];
    }
    
    
    
    
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [[self quotesLabel] setText:[[QuotesModel sharedQuotesModel] getRandomQuote:self]];


    [super viewWillAppear:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self->textField becomeFirstResponder];
    
    self.notesButtonClicked = NO;
    [self.crossButton setAlpha:0.0];

    dateLabel.text = @"No due date set";
    UITapGestureRecognizer* tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [[self view] addGestureRecognizer:tapgesture];

//	[self redrawDate];

	// Do any additional setup after loading the view.
}
-(void)configureThemes
{
    [self setCellBackgroundColor:[[[SHCToDoStore sharedStore] loadThemeProps] cellbackgroundColor]];
    
    [self setLabelFontColor:[[[SHCToDoStore sharedStore] loadThemeProps] fontColor]];
    
    [self setButtonColor:[[[SHCToDoStore sharedStore] loadThemeProps] buttonColor]];
    
    [self setNavigationbarColor:[[[SHCToDoStore sharedStore] loadThemeProps] navigationBarColor]];
    
    [self setNavigationbarTitleColor:[[[SHCToDoStore sharedStore] loadThemeProps] navigationBarTitleColor]];
    self.doneButton.buttonColor = [self buttonColor];
    self.doneButton.shadowColor = [self buttonColor];
    self.doneButton.shadowHeight = 3.0f;
    self.doneButton.cornerRadius = 6.0f;
    self.doneButton.titleLabel.font = [UIFont fontWithName:@"GillSans-Italic" size:16];
    [self.doneButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [self.doneButton setTitleColor:[UIColor whiteColor]forState:UIControlStateHighlighted];
    
    self.dueDateButton.buttonColor = [self buttonColor];
    self.dueDateButton.shadowColor = [self buttonColor];
    self.dueDateButton.shadowHeight = 3.0f;

    self.dueDateButton.cornerRadius = 0.0f;
    self.dueDateButton.titleLabel.font = [UIFont fontWithName:@"GillSans-Italic" size:16];
    [self.dueDateButton setTitleColor:[self navigationbarTitleColor] forState:UIControlStateNormal];
    [self.dueDateButton setTitleColor:[self navigationbarTitleColor] forState:UIControlStateHighlighted];
    
    self.addNotes.buttonColor = [self buttonColor];
    self.addNotes.shadowColor = [self buttonColor];
    self.addNotes.shadowHeight = 3.0f;
    self.addNotes.cornerRadius = 0.0f;
    self.addNotes.titleLabel.font = [UIFont fontWithName:@"GillSans-Italic" size:16];
    [self.addNotes setTitleColor:[self navigationbarTitleColor] forState:UIControlStateNormal];
    [self.addNotes setTitleColor:[self navigationbarTitleColor] forState:UIControlStateHighlighted];

    
    self.cancelButton.buttonColor = [self buttonColor];
    self.cancelButton.shadowColor = [self buttonColor];
    self.cancelButton.shadowHeight = 3.0f;
    self.cancelButton.cornerRadius = 6.0f;
    self.cancelButton.titleLabel.font = [UIFont fontWithName:@"GillSans-Italic" size:16];
    [self.cancelButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.navigationBar configureFlatNavigationBarWithColor:[self navigationbarColor]];


}
-(void)viewDidUnload
{
[[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)dismissKeyboard
{

    [[self view] endEditing:YES];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addtask:(id)sender
{
    
    if([[textField text]length]==0)
    {
        FUIAlertView *alertView = [[FUIAlertView alloc] initWithTitle:@"Hello"
                                                              message:@" You forgot to enter a task !"
                                                             delegate:nil cancelButtonTitle:@"Ok"
                                                    otherButtonTitles:@"", nil];
        
        alertView.titleLabel.textColor = [UIColor cloudsColor];
        alertView.titleLabel.font = [UIFont fontWithName:@"GillSans-Italic" size:16];
        alertView.messageLabel.textColor = [UIColor cloudsColor];
        alertView.messageLabel.font = [UIFont fontWithName:@"GillSans-Italic" size:16];
        alertView.backgroundOverlay.backgroundColor = [[UIColor cloudsColor] colorWithAlphaComponent:0.8];
        alertView.alertContainer.backgroundColor = [UIColor midnightBlueColor];
        alertView.defaultButtonColor = [UIColor cloudsColor];
        alertView.defaultButtonShadowColor = [UIColor asbestosColor];
        alertView.defaultButtonFont = [UIFont fontWithName:@"GillSans-Italic" size:16];
        alertView.defaultButtonTitleColor = [UIColor asbestosColor];
        [alertView show];
    }
    else{
    SHCToDoItem * newitem = [[SHCToDoStore sharedStore] createItem];
    [newitem setText:[textField text]];
    if(!self.selectedDate)
    {

        [newitem setDuedate:self.selectedDate];
        [newitem setDuedatesection: @"No due date"];
    }
    else{
        
        
    [newitem setDuedate:self.selectedDate];



    [newitem setDuedatesection: self->duedatesection];
        

        }

    NSDecimalNumber * zero = [[NSDecimalNumber alloc] initWithInt:0];

    [newitem setCompleted: zero];
    if([[listField text]length]==0)
    {
    [newitem setList:@"Default list"];
    }
    else
    {
    [newitem setList:[listField text]];
    }
    

    [newitem setNotes:[self notes]];
    
    if([[self presentingViewController]isMemberOfClass:[SHCViewController class]])
    {
        SHCViewController * controller =  (SHCViewController*)[self presentingViewController];
        NSUInteger display_order =  [controller getCountOfAllTasks];

        [newitem setDisplayOrder: [NSNumber numberWithInt:display_order]];
    }
    else
    {
        SHCListViewController * controller =  (SHCListViewController*)[self presentingViewController];
        NSUInteger display_order =  [controller getCountOfAllTasks];
     
        [newitem setDisplayOrder: [NSNumber numberWithInt:display_order]];
    
    }
    
    
    

    [[SHCToDoStore sharedStore] saveChanges];

    [[self presentingViewController] dismissViewControllerWithFlipStyle:MPFlipStyleOrientationVertical completion:nil];
   }

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
        return YES;
}





- (void)redrawDate
{


	
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
	[dateFormatter1 setDateStyle:NSDateFormatterLongStyle];
	
    NSDateFormatter *timeFormatter1 = [[NSDateFormatter alloc] init];
	[timeFormatter1 setTimeStyle:NSDateFormatterNoStyle];
    
    self->duedatesection = [NSString stringWithFormat:@"%@  %@",
                            [dateFormatter1 stringFromDate:self.selectedDate],
                            [timeFormatter1 stringFromDate:self.selectedDate]];
    dateLabel.text = [NSString stringWithFormat:@"%@  %@",
                      [dateFormatter1 stringFromDate:self.selectedDate],
                      [timeFormatter1 stringFromDate:self.selectedDate]];
    
    


}

- (IBAction)showDatePicker:(id)sender {
    
    
    
    SHCCalendarViewController * viewController = [[SHCCalendarViewController alloc] init];
    viewController.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    viewController.calendar.locale = [NSLocale currentLocale];
    [viewController setIsedit:NO];
    [self presentViewController:viewController animated:YES completion:nil];
    
    
   
}


- (IBAction)notesButtonPressed:(id)sender {
    self.notesButtonClicked = YES;
    SHCNotesViewController * viewController = [[SHCNotesViewController alloc] init];
    viewController.delegate = self;
    [viewController setNewnote:YES];
    [self presentViewController:viewController foldStyle:MPFoldStyleCubic completion:nil];

}

- (IBAction)noDueDatePressed:(id)sender {
    
    self.selectedDate = nil;
    dateLabel.text = @"No due date set";
    [self.crossButton setAlpha:0.0];
    [dateLabel setNeedsDisplay];
    
    
}

- (IBAction)cancelPressed:(id)sender {
    [[self presentingViewController] dismissViewControllerWithFlipStyle:MPFlipStyleOrientationVertical completion:nil]; 
    
}

- (IBAction)donePressed:(id)sender {
    [self addtask:sender];
}

-(void)calenderControllerProcessDate:(NSDate*)date
{
    
    self.selectedDate = date;
	[self redrawDate];
    [[self view ]setNeedsDisplay];
    [[self crossButton ]setAlpha:1.0];
	
}


-(void)doneAddingNotes:(NSString *)newnotes
{
   [self setNotes:newnotes];
    [[self notesLabel] setText:[self notes]];
}
@end
