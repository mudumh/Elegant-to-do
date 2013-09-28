//
//  SHCCellAddTask.m
//  ClearStyle
//
//  Created by Harsha Vardhan on 6/10/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import "SHCCellAddTask.h"
#import "SHCTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "SHCStrikethroughLabel.h"
#import "SHCToDoStore.h"
#import "SHCThemePropsModel.h"

@implementation SHCCellAddTask{

    SHCStrikethroughLabel *_label;
    CAGradientLayer* _gradientLayer;
}
@synthesize labelColor;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _label = [[SHCStrikethroughLabel alloc] initWithFrame:CGRectNull];
		
        
		_label.textColor = [UIColor whiteColor];
		_label.font = [UIFont boldSystemFontOfSize:20];
		[self setLabelText:@"Pull to add a new task"];

		[self addSubview:_label];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
       
        [self setLabelBackground];
        // add a layer that overlays the cell adding a subtle gradient effect
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = self.bounds;
        _gradientLayer.colors = @[(id)[[UIColor colorWithWhite:1.0f alpha:0.2f] CGColor],
                                  (id)[[UIColor colorWithWhite:1.0f alpha:0.1f] CGColor],
                                  (id)[[UIColor clearColor] CGColor],
                                  (id)[[UIColor colorWithWhite:0.0f alpha:0.1f] CGColor]];
        _gradientLayer.locations = @[@0.00f, @0.01f, @0.95f, @1.00f];
        [self.layer insertSublayer:_gradientLayer atIndex:0];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews {
    [super layoutSubviews];
    // ensure the gradient layers occupies the full bounds
    _gradientLayer.frame = self.bounds;
    
    _label.frame = CGRectMake(0, 0,
                              self.bounds.size.width - 0,self.bounds.size.height);
    
  
}
-(void)setLabelText:(NSString*)text
{
 [_label setText:text];

}
-(void)setLabelBackground
{
_label.backgroundColor = [[[[SHCToDoStore sharedStore] loadThemeProps] cellbackgroundColor] colorWithAlphaComponent:0.5];

}
@end
