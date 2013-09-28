//
//  SHCStrikethroughLabel.h
//  ClearStyle
//
//  Created by Fahim Farook on 23/9/12.
//  Copyright (c) 2012 RookSoft Pte. Ltd. All rights reserved.
//

// A UILabel subclass that can optionally have a strikethrough
@interface SHCStrikethroughLabel : UILabel

// A boolean value that determines whether the label should have a strikethrough.
@property (nonatomic) bool strikethrough;
@property (nonatomic) NSString* labelText;


@end
