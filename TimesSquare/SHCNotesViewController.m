//
//  SHCNotesViewController.m
//  ClearStyle
//
//  Created by Harsha Vardhan on 6/26/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import "SHCNotesViewController.h"
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
@interface SHCNotesViewController ()

@property (weak, nonatomic) IBOutlet FUIButton *doneButton;
@property (weak, nonatomic) IBOutlet FUIButton *cancelButton;

@end

@implementation SHCNotesViewController
@synthesize navigatioBar;
@synthesize notes;
@synthesize newnote;
@synthesize notesTextView;
@synthesize labelFontColor,navigationbarColor,navigationbarTitleColor,buttonColor;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        UITapGestureRecognizer* tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
        [[self view] addGestureRecognizer:tapgesture];
        [self configureThemes];
    }
    return self;
}

-(BOOL)shouldAutorotate
{
    return NO;
    
}
-(void)configureThemes
{
    
    
    [self setLabelFontColor:[[[SHCToDoStore sharedStore] loadThemeProps] fontColor]];
    [self setButtonColor:[[[SHCToDoStore sharedStore] loadThemeProps] buttonColor]];
    [self setNavigationbarColor:[[[SHCToDoStore sharedStore] loadThemeProps] navigationBarColor]];
    [self setNavigationbarTitleColor:[[[SHCToDoStore sharedStore] loadThemeProps] navigationBarTitleColor]];
    
    [self.navigatioBar configureFlatNavigationBarWithColor:[self navigationbarColor]];
    self.doneButton.buttonColor = [self buttonColor];
    self.doneButton.shadowColor = [self buttonColor];
    self.doneButton.shadowHeight = 3.0f;
    self.doneButton.cornerRadius = 6.0f;
    self.doneButton.titleLabel.font = [UIFont fontWithName:@"GillSans-Italic" size:16];
    [self.doneButton setTitleColor:[self navigationbarTitleColor] forState:UIControlStateNormal];
    [self.doneButton setTitleColor:[self navigationbarTitleColor] forState:UIControlStateHighlighted];

    
    self.cancelButton.buttonColor = [self buttonColor];
    self.cancelButton.shadowColor = [self buttonColor];
    self.cancelButton.shadowHeight = 3.0f;
    self.cancelButton.cornerRadius = 6.0f;
    self.cancelButton.titleLabel.font = [UIFont fontWithName:@"GillSans-Italic" size:16];
    [self.cancelButton setTitleColor:[self navigationbarTitleColor] forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[self navigationbarTitleColor] forState:UIControlStateHighlighted];

}
-(id)initToAddNewNote:(BOOL)isnewnote
{
    self.newnote = isnewnote;
   return  [self init];

}

-(void)viewWillAppear:(BOOL)animated
{
    
    [self configureThemes];
    [super viewWillAppear:YES];

}

-(void)dismissKeyboard
{
    
    [[self view] endEditing:YES];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer* tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [[self view] addGestureRecognizer:tapgesture];

    if(self.newnote){
    }
    else
    {
        SHCViewControllerEditScreen * controller =     (SHCViewControllerEditScreen*)   [self presentingViewController];
   [notesTextView setText:[[controller itemToEdit] notes]];
        
    
    
    }
   
    [notesTextView becomeFirstResponder];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
      
    self.notes = [textView text];

    
     [[self delegate] doneAddingNotes:self.notes];
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    
    
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    return YES;
}
- (IBAction)doneButtonPressed:(id)sender {
    [[self delegate] doneAddingNotes:self.notes];
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)cancelButtonPressed:(id)sender {
    
     [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}
@end
