//
//  SHCViewControllerEditScreen.h
//  ClearStyle
//
//  Created by Harsha Vardhan on 6/21/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHCToDoItem.h"
#import "SHCNotesEditViewController.h"

@interface SHCViewControllerEditScreen : UIViewController
<NotesEditViewControllerDelegate>
{


    
}
@property (weak, nonatomic) IBOutlet UILabel *quotesLabel;
@property (weak, nonatomic) IBOutlet UITextField *taskDetails;
@property (weak, nonatomic) IBOutlet UITextField *listText;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property(weak,nonatomic) NSString * datelabeltext;
@property (strong, nonatomic) IBOutlet UILabel *notesLabel;
@property(weak,nonatomic) NSString* notestext;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
- (IBAction)noDueDatePressed:(id)sender;

@property UIColor* cellBackgroundColor;
@property UIColor* labelFontColor;
@property(nonatomic,strong) UIColor* buttonColor;
@property(nonatomic,strong) UIColor* navigationbarColor;
@property(nonatomic,strong) UIColor* navigationbarTitleColor;



@property(weak,nonatomic) SHCToDoItem * itemToEdit;

- (IBAction)cancelPressed:(id)sender;
- (IBAction)donePressed:(id)sender;
- (IBAction)changeDDPressed:(id)sender;
- (IBAction)notesButtonPressed:(id)sender;
-(void)calenderControllerProcessDate:(NSDate*)date;
@property(weak,nonatomic) NSDate * selectedDate;


@end
