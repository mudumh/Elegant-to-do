//
//  SHCStrikethroughLabel.m
//  ClearStyle
//
//  Created by Fahim Farook on 23/9/12.
//  Copyright (c) 2012 RookSoft Pte. Ltd. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SHCStrikethroughLabel.h"

@implementation SHCStrikethroughLabel {
    bool _strikethrough;
    CALayer* _strikethroughLayer;
}
@synthesize labelText;

const float STRIKEOUT_THICKNESS = 2.0f;

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _strikethroughLayer = [CALayer layer];
        _strikethroughLayer.backgroundColor = [[UIColor blackColor] CGColor];
        _strikethroughLayer.hidden = YES;
        [self.layer addSublayer:_strikethroughLayer];
       
    }
    return self;
}

-(void)layoutSubviews {
    //[super layoutSubviews];
  
    [self resizeStrikeThrough];
}

-(void)setText:(NSString *)text {
    [super setText:text];
    //rgb(236, 240, 241) - clouds
    
    [self resizeStrikeThrough];
}

-(void)setLabelText:(NSString *)text {
    [super setText:text];
    
    //rgba(52, 73, 94,1.0)
    
    
    
    [self resizeStrikeThrough];
}
-(void)settextColor:(UIColor* )color
{
[super setTextColor:color];

}
// resizes the strikethrough layer to match the current label text
-(void)resizeStrikeThrough {
    CGSize textSize = [self.text sizeWithFont:self.font];
    _strikethroughLayer.frame = CGRectMake(0, self.bounds.size.height/2,
                                           textSize.width, STRIKEOUT_THICKNESS);
}

#pragma mark - property setter
-(void)setStrikethrough:(bool)strikethrough {
    _strikethrough = strikethrough;
    _strikethroughLayer.hidden = !strikethrough;
}

@end
