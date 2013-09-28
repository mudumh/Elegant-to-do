//
//  SHCAddTaskViewController.h
//  ClearStyle
//
//  Created by Harsha Vardhan on 6/1/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import "FUIButton.h"

#import "TSQCalendarView.h"




#import <UIKit/UIKit.h>
#import "SHCNotesViewController.h"

@interface SHCAddTaskViewController : UIViewController<UITextFieldDelegate,NotesViewControllerDelegate>
{

    __weak IBOutlet UITextField *textField;


    __weak IBOutlet UILabel *dateLabel;
    __weak IBOutlet UITextField *listField;
    __weak IBOutlet UITextView *textNotes;
}

- (IBAction)showDatePicker:(id)sender;
- (IBAction)notesButtonPressed:(id)sender;
- (IBAction)noDueDatePressed:(id)sender;


- (IBAction)cancelPressed:(id)sender;
- (IBAction)donePressed:(id)sender;
-(void)calenderControllerProcessDate:(NSDate* )date;

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property(nonatomic,strong) NSDate * selectedDate;

@property (weak, nonatomic) IBOutlet UILabel *quotesLabel;

@property (nonatomic,copy)void(^dismissBlock)(void);

@property (nonatomic,strong) UITextField* activeTextField;
@property(nonatomic,strong)NSString* notes;
@property (weak, nonatomic) IBOutlet UILabel *notesLabel;

@property(nonatomic,strong) UIColor* cellBackgroundColor;
@property(nonatomic,strong) UIColor* buttonColor;
@property(nonatomic,strong) UIColor* labelFontColor;
@property(nonatomic,strong) UIColor* navigationbarColor;
@property(nonatomic,strong) UIColor* navigationbarTitleColor;



@end
