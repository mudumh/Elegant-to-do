//
//  SHCSelectThemeViewController.h
//  ClearStyle
//
//  Created by Harsha Vardhan on 6/30/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHCSelectThemeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableView;



@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

- (IBAction)carrotButtonPressed;

- (IBAction)greenSeaPressed;
- (IBAction)asphaltPressed;
- (IBAction)blackandwhitePressed;
- (IBAction)backButtonPressed;
- (IBAction)wisteriaButtonPressed;
- (IBAction)sunFlowerButtonPressed;
- (IBAction)emeraldButtonPressed;
- (IBAction)peterRiverPressed;

@end
