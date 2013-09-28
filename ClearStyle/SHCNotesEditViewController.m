//
//  SHCNotesEditViewController.m
//  ClearStyle
//
//  Created by Harsha Vardhan on 6/27/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import "SHCNotesEditViewController.h"
#import "FUIButton.h"
#import "UIFont+FlatUI.h"
#import "UINavigationBar+FlatUI.h"
#import "SHCToDoStore.h"
@interface SHCNotesEditViewController ()
@property (weak, nonatomic) IBOutlet FUIButton *cancelButton;
@property (weak, nonatomic) IBOutlet FUIButton *doneButton;
@property(weak,nonatomic)NSString* tempText;

@end

@implementation SHCNotesEditViewController
@synthesize notesTextView;
@synthesize notesText;
@synthesize labelFontColor,navigationbarColor,navigationbarTitleColor,buttonColor;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
       // self.view.backgroundColor = [UIColor colorWithPatternImage://[UIImage imageNamed:@"tableviewBackground.png"]];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self notesTextView ]setText:[self notesText]];
    UITapGestureRecognizer* tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [[self view] addGestureRecognizer:tapgesture];
    
}
-(void)viewWillAppear:(BOOL)animated
{


    [super viewWillAppear:YES];
    [self configureThemes];
    [notesTextView becomeFirstResponder];



}
-(void)dismissKeyboard
{
    
    [[self view] endEditing:YES];
    
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
    
    [self.navigationBar configureFlatNavigationBarWithColor:[self navigationbarColor]];
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButtonPressed:(id)sender {
    
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)doneButtonPressed:(id)sender {
    self.notesText = [[self notesTextView] text];
    
    [[self delegate] doneEditingNotes:self.notesText];

    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
      

    self.tempText =[[self notesTextView] text];
    
    
    /**[[self delegate] doneEditingNotes:self.notesText];
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];*/
    
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
   
    return YES;
}

@end
