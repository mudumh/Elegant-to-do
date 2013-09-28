//
//  SHCViewControllerEditScreen.m
//  ClearStyle
//
//  Created by Harsha Vardhan on 6/21/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import "SHCViewControllerEditScreen.h"
#import "FUIButton.h"
#import "MPFoldTransition.h"
#import "UINavigationBar+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"
#import "SHCCalendarViewController.h"
#import "SHCToDoStore.h"
#import "SHCNotesViewController.h"
#import "SHCNotesEditViewController.h"
#import "QuotesModel.h"
#import "FUIAlertView.h"
@interface SHCViewControllerEditScreen ()
@property (weak, nonatomic) IBOutlet FUIButton *doneButton;

@property (weak, nonatomic) IBOutlet FUIButton *cancelButton;
@property (weak, nonatomic) IBOutlet FUIButton *changeDD;
@property (weak, nonatomic) IBOutlet FUIButton *notesButton;

@property (weak, nonatomic) IBOutlet UIButton *crossButton;

@end

@implementation SHCViewControllerEditScreen
{
    NSString * duedatesection;
    BOOL firstAppearance;
    NSString* editednotes;

}
@synthesize itemToEdit;
@synthesize navigationBar;
@synthesize taskDetails;
@synthesize listText;
@synthesize dateLabel;
@synthesize selectedDate;
@synthesize notesLabel;
@synthesize notestext;
@synthesize cellBackgroundColor,labelFontColor,navigationbarColor,navigationbarTitleColor,buttonColor;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
               self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableviewBackground.png"]];

        [self configureThemes];
        self->firstAppearance = YES;
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    [self configureThemes];
    [self.crossButton setAlpha:1.0];
    [[self quotesLabel] setText:[[QuotesModel sharedQuotesModel] getRandomQuote:self]];
    if(firstAppearance)
    {
      
    self.dateLabel.text=[[self itemToEdit]duedatesection];
        if([self.dateLabel.text isEqualToString:@"No due date"] )
        {
            [self.crossButton setAlpha:0.0];
        
        }
    [[self taskDetails] setText:[[self itemToEdit] text]];
    [[self listText] setText:[[self itemToEdit] list]];
    [self setNotestext:[[self itemToEdit] notes]   ];
    self->duedatesection = [[self itemToEdit] duedatesection];
    }
    else
    {
    self.dateLabel.text= self->duedatesection;
    
    }
       
    editednotes = [self notestext];
    [[self notesLabel] setText:[self notestext]];
     self->firstAppearance = NO;
   
    

}


-(BOOL)shouldAutorotate
{
    return NO;
    
}
-(void)configureThemes
{

    [self setButtonColor:[[[SHCToDoStore sharedStore] loadThemeProps] buttonColor]];
    [self setNavigationbarColor:[[[SHCToDoStore sharedStore] loadThemeProps] navigationBarColor]];
    [self setNavigationbarTitleColor:[[[SHCToDoStore sharedStore] loadThemeProps] navigationBarTitleColor]];
    
    self.doneButton.buttonColor = [self buttonColor];
    self.doneButton.shadowColor = [self buttonColor];
    self.doneButton.shadowHeight = 3.0f;
    self.doneButton.cornerRadius = 6.0f;
    self.doneButton.titleLabel.font = [UIFont fontWithName:@"GillSans-Italic" size:16];
    [self.doneButton setTitleColor:[UIColor whiteColor]
                          forState:UIControlStateNormal];
    [self.doneButton setTitleColor:[UIColor whiteColor]forState:UIControlStateHighlighted];
    
    
    
    self.cancelButton.buttonColor = [self buttonColor];
    self.cancelButton.shadowColor = [self buttonColor];
    self.cancelButton.shadowHeight = 3.0f;
    self.cancelButton.cornerRadius = 6.0f;
    self.cancelButton.titleLabel.font = [UIFont fontWithName:@"GillSans-Italic" size:16];
    [self.cancelButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor whiteColor]forState:UIControlStateHighlighted];
    
    
    self.changeDD.buttonColor = [self buttonColor];
    self.changeDD.shadowColor = [self buttonColor];
    self.changeDD.shadowHeight = 3.0f;
    self.changeDD.cornerRadius = 0.0f;
    self.changeDD.titleLabel.font = [UIFont fontWithName:@"GillSans-Italic" size:16];
    [self.changeDD setTitleColor:[self navigationbarTitleColor] forState:UIControlStateNormal];
    [self.changeDD setTitleColor:[self navigationbarTitleColor] forState:UIControlStateHighlighted];
    
    
    self.notesButton.buttonColor = [self buttonColor];
    self.notesButton.shadowColor =[self buttonColor];
    self.notesButton.shadowHeight = 3.0f;
    self.notesButton.cornerRadius = 0.0f;
    self.notesButton.titleLabel.font = [UIFont fontWithName:@"GillSans-Italic" size:16];
    [self.notesButton setTitleColor:[self navigationbarTitleColor] forState:UIControlStateNormal];
    [self.notesButton setTitleColor:[self navigationbarTitleColor] forState:UIControlStateHighlighted];
    
    
    
    
    
    [self.navigationBar configureFlatNavigationBarWithColor:[self navigationbarColor]];
    

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.taskDetails becomeFirstResponder];
    UITapGestureRecognizer* tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [[self view] addGestureRecognizer:tapgesture];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelPressed:(id)sender {
        [[self presentingViewController] dismissViewControllerWithFoldStyle:MPFoldStyleUnfold completion:nil];
    
    
}

- (IBAction)donePressed:(id)sender {
    if([[taskDetails text]length]==0)
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
   
    [itemToEdit setText:[taskDetails text]];
    [itemToEdit setList:[listText text]];
    if(!self->duedatesection){
    [itemToEdit setDuedatesection:@"No due date"];
    }
    else
    {
    [itemToEdit setDuedatesection:self->duedatesection];
    }
    [itemToEdit setDuedate:self.selectedDate];

    [itemToEdit setNotes:editednotes];
    
    [[SHCToDoStore sharedStore] saveChanges];

    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
        }
    
}

- (IBAction)changeDDPressed:(id)sender {
    SHCCalendarViewController * viewController = [[SHCCalendarViewController alloc] init];
    
    
    viewController.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    viewController.calendar.locale = [NSLocale currentLocale];
    [viewController setIsedit:YES];
    
    [self presentViewController:viewController animated:YES completion:nil];
    
}

- (IBAction)notesButtonPressed:(id)sender {
    
    SHCNotesEditViewController * viewController = [[SHCNotesEditViewController alloc] init];
    [viewController setNotesText:self.notestext];
    viewController.delegate =self;
    [self presentViewController:viewController animated:YES completion:nil]
    ;
}
-(void)dismissKeyboard
{
    
    [[self view] endEditing:YES];
    
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
    NSString * str= [NSString stringWithFormat:@"%@  %@",
                      [dateFormatter1 stringFromDate:self.selectedDate],
                      [timeFormatter1 stringFromDate:self.selectedDate]];
    self.dateLabel.text = str;
     
}
    
   
    

-(void)calenderControllerProcessDate:(NSDate *)date
{
      
    self.selectedDate = date;
      
      
	[self redrawDate];
    

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

-(void)doneEditingNotes:(NSString *)notes
{
    
    self.notestext = notes;

}


- (IBAction)noDueDatePressed:(id)sender {
    
    self->duedatesection = nil;
    self.dateLabel.text = @"No due date set";
    [self.dateLabel setNeedsDisplay];
    [self.crossButton setAlpha:0.0];
}

@end
