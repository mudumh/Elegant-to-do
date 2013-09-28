//
//  SHCNotesViewController.h
//  ClearStyle
//
//  Created by Harsha Vardhan on 6/26/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NotesViewControllerDelegate <NSObject>
-(void)doneAddingNotes:(NSString *)notes;
@end

@interface SHCNotesViewController : UIViewController<UITextViewDelegate>
-(id)initToAddNewNote:(BOOL)isnewnote;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigatioBar;
@property(weak,nonatomic)NSString* notes;
@property BOOL newnote;
@property (weak, nonatomic) IBOutlet UITextView *notesTextView;
- (IBAction)cancelButtonPressed:(id)sender;
@property(weak,nonatomic) id<NotesViewControllerDelegate> delegate;
- (IBAction)doneButtonPressed:(id)sender;

@property(nonatomic,strong) UIColor* buttonColor;
@property(nonatomic,strong) UIColor* labelFontColor;
@property(nonatomic,strong) UIColor* navigationbarColor;
@property(nonatomic,strong) UIColor* navigationbarTitleColor;

@end
