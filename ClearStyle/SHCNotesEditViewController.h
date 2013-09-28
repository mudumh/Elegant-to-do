//
//  SHCNotesEditViewController.h
//  ClearStyle
//
//  Created by Harsha Vardhan on 6/27/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NotesEditViewControllerDelegate <NSObject>
-(void)doneEditingNotes:(NSString *)notes;
@end

@interface SHCNotesEditViewController : UIViewController
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@property(weak,nonatomic) NSString* notesText;
@property (weak, nonatomic) IBOutlet UITextView *notesTextView;
@property(weak,nonatomic) id<NotesEditViewControllerDelegate> delegate;
- (IBAction)cancelButtonPressed:(id)sender;

- (IBAction)doneButtonPressed:(id)sender;

@property(nonatomic,strong) UIColor* buttonColor;
@property(nonatomic,strong) UIColor* labelFontColor;
@property(nonatomic,strong) UIColor* navigationbarColor;
@property(nonatomic,strong) UIColor* navigationbarTitleColor;


@end
