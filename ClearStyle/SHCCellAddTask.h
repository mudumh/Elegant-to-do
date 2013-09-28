//
//  SHCCellAddTask.h
//  ClearStyle
//
//  Created by Harsha Vardhan on 6/10/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHCCellAddTask : UITableViewCell
@property(weak,nonatomic)UIColor *labelColor;
-(void)setLabelBackground;
-(void)setLabelText:(NSString* )text;
@end
