//
//  SHCTableViewCell.m
//  ClearStyle
//
//  Created by Fahim Farook on 23/9/12.
//  Copyright (c) 2012 RookSoft Pte. Ltd. All rights reserved.
//

#import "SHCTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "SHCStrikethroughLabel.h"
#import "SHCToDoStore.h"


@implementation SHCTableViewCell {
    CAGradientLayer* _gradientLayer;
	CGPoint _originalCenter;
	BOOL _deleteOnDragRelease;

	
	BOOL _markCompleteOnDragRelease;
	UILabel *_tickLabel;
	UILabel *_crossLabel;
}
@synthesize longpressDelegate;
@synthesize _label;

const float UI_CUES_MARGIN = 10.0f;
const float UI_CUES_WIDTH = 50.0f;


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self =
    [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.multipleTouchEnabled = YES;
        // add a tick and cross
        _tickLabel = [self createCueLabel];
        _tickLabel.text = @"\u2713";
        _tickLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_tickLabel];
        [UIFont fontWithName:@"Baskerville" size:16];
        _crossLabel = [self createCueLabel];
        _crossLabel.text = @"\u2717";
        _crossLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_crossLabel];
		
        // create a label that renders the todo item text
		_label = [[SHCStrikethroughLabel alloc] initWithFrame:CGRectNull];
		
        
//		_label.textColor = [UIColor blackColor];
      
       UIFont* gill_sans = [UIFont fontWithName:@"GillSans-Italic" size:19];

        _label.font = gill_sans;
		_label.backgroundColor = [UIColor clearColor];
		[self addSubview:_label];
        
		// remove the default blue highlight for selected cells
		self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // add a layer that overlays the cell adding a subtle gradient effect
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = self.bounds;
        _gradientLayer.colors = @[(id)[[UIColor colorWithWhite:1.0f alpha:0.2f] CGColor],
                                  (id)[[UIColor colorWithWhite:1.0f alpha:0.1f] CGColor],
                                  (id)[[UIColor clearColor] CGColor],
                                  (id)[[UIColor colorWithWhite:0.0f alpha:0.1f] CGColor]];
        _gradientLayer.locations = @[@0.00f, @0.01f, @0.95f, @1.00f];
       // [self.layer insertSublayer:_gradientLayer atIndex:0];
        
		// add a layer that renders a green background when an item is complete
		
        

		
		// add a pan recognizer
        //[self setAlpha:0.4];
		
    }
    return self;
}

const float LABEL_LEFT_MARGIN = 15.0f;

-(void)layoutSubviews {
    [super layoutSubviews];
    // ensure the gradient layers occupies the full bounds
    //_gradientLayer.frame = self.bounds;
   
    _label.frame = CGRectMake(LABEL_LEFT_MARGIN, 0,
                              self.bounds.size.width-LABEL_LEFT_MARGIN ,self.bounds.size.height);
    _tickLabel.frame = CGRectMake(-UI_CUES_WIDTH - UI_CUES_MARGIN, 0,
                                  UI_CUES_WIDTH, self.bounds.size.height);
    _crossLabel.frame = CGRectMake(self.bounds.size.width + UI_CUES_MARGIN, 0,
                                   UI_CUES_WIDTH, self.bounds.size.height);
}

-(void)setTodoItem:(SHCToDoItem *)todoItem {
    _todoItem = todoItem;
    // we must update all the visual state associated with the model item
    [_label setLabelText:todoItem.text];

      
    if([todoItem.completed intValue]==0 ){
        
        _label.strikethrough = NO;
    }
    else
    {
     
               _label.strikethrough = YES;
    }
    
}

// utility method for creating the contextual cues
-(UILabel*) createCueLabel {
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectNull];
    label.textColor = [UIColor blueColor];
    label.font = [UIFont boldSystemFontOfSize:32.0];
    label.backgroundColor = [UIColor clearColor];
    return label;
}

#pragma mark - horizontal pan gesture methods
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {


        // Check for horizontal gesture
    if ([gestureRecognizer isMemberOfClass:[UIPanGestureRecognizer class]]){
          
        UIPanGestureRecognizer * pan = (UIPanGestureRecognizer*)gestureRecognizer;
        CGPoint translation = [pan translationInView:[self superview]];
        // ALSO CHECK FOR THE NUMBER OF TOUCHES IN THIS
        if([gestureRecognizer numberOfTouches]==1){
            
            if (fabsf(translation.x) > fabsf(translation.y)) {
                return YES;
            }}
        return NO;
    }
    return NO;
   
}


-(void)handlePan:(UIPanGestureRecognizer *)recognizer {
      
    if (recognizer.state == UIGestureRecognizerStateBegan) {
		// if the gesture has just started, record the current centre location
        _originalCenter = self.center;
    }
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        // translate the center
        CGPoint translation = [recognizer translationInView:self];
        self.center = CGPointMake(_originalCenter.x + translation.x, _originalCenter.y);
        // determine whether the item has been dragged far enough to initiate a delete / complete
        _markCompleteOnDragRelease = self.frame.origin.x > self.frame.size.width / 2;
        _deleteOnDragRelease = self.frame.origin.x < -self.frame.size.width / 2;
		// Context cues
		// fade the contextual cues
		float cueAlpha = fabsf(self.frame.origin.x) / (self.frame.size.width / 2);
		_tickLabel.alpha = cueAlpha;
		_crossLabel.alpha = cueAlpha;
        
		// indicate when the item have been pulled far enough to invoke the given action
		_tickLabel.textColor = _markCompleteOnDragRelease ?
        [UIColor greenColor] : [UIColor whiteColor];
		_crossLabel.textColor = _deleteOnDragRelease ?
        [UIColor redColor] : [UIColor blueColor];
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        // the frame this cell would have had before being dragged
        CGRect originalFrame = CGRectMake(0, self.frame.origin.y,
                                          self.bounds.size.width, self.bounds.size.height);
        if (!_deleteOnDragRelease) {
            // if the item is not being deleted, snap back to the original location
               
            [UIView animateWithDuration:0.2
                             animations:^{
                                 self.frame = originalFrame;
                             }
             ];
        }
		if (_deleteOnDragRelease) {
			// notify the delegate that this item should be deleted
              
              
              
            
			[self.delegate toDoItemDeleted:self.todoItem];
            
		}
        if (_markCompleteOnDragRelease) {
            // mark the item as complete and update the UI state
            //CHECK THE CURRENT DONE STATUS.
            if([self.todoItem.completed intValue]==0)
            {
                NSDecimalNumber * one = [[NSDecimalNumber alloc] initWithInt:1];
                self.todoItem.completed = one;
            
                _label.strikethrough = YES;
            
            
            }
            else if([self.todoItem.completed intValue]==1)
            {
                  
                NSDecimalNumber * zero = [[NSDecimalNumber alloc] initWithInt:0];
                self.todoItem.completed = zero;
                [[SHCToDoStore sharedStore] saveChanges];
              
                _label.strikethrough = NO;
            }

            
        }
    }
}


-(void)putGesturesRecognizers
{
    UIPanGestureRecognizer* recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    recognizer.delegate = self;
    UIPanGestureRecognizer *test =  (UIPanGestureRecognizer* )recognizer;
    [test setMaximumNumberOfTouches:1];
    [self addGestureRecognizer:recognizer];
    
    
    //UISwipeGestureRecognizer* swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    //recognizer.delegate = self;
    //[recognizer requireGestureRecognizerToFail:swipe];
    
   // [self addGestureRecognizer:swipe];
    
   
    
    //[self addGestureRecognizer:longpress];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped:)];
    [self addGestureRecognizer:tap];
    //[recognizer requireGestureRecognizerToFail:tap];
    
    // recognizer.cancelsTouchesInView = NO;
  /**  UISwipeGestureRecognizer* swiperight = [[UISwipeGestureRecognizer alloc] initWithTarget:[self delegate] action:@selector(handleViewsSwipe:)];
    //[swiperight setNumberOfTouchesRequired:2];
    [swiperight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self addGestureRecognizer:swiperight];
    swiperight.delegate = self;*/
    
    
   


    

}
-(void)cellTapped:(UITapGestureRecognizer* )recognizer
{

    [[self delegate] cellTapped:[self todoItem]];

}
-(void)handleSwipe:(UISwipeGestureRecognizer*)swipe
{
      
    if([swipe direction]==UISwipeGestureRecognizerDirectionLeft)
    {
       [self.delegate toDoItemDeleted:self.todoItem];
    }
    else if([swipe direction]==UISwipeGestureRecognizerDirectionRight)
    {
        if([self.todoItem.completed intValue]==0)
        {
            NSDecimalNumber * one = [[NSDecimalNumber alloc] initWithInt:1];
            self.todoItem.completed = one;
            [[SHCToDoStore sharedStore] saveChanges];
            
            _label.strikethrough = YES;
            
        }
        else if([self.todoItem.completed intValue]==1)
        {
              
            NSDecimalNumber * zero = [[NSDecimalNumber alloc] initWithInt:0];
            self.todoItem.completed = zero;
            [[SHCToDoStore sharedStore] saveChanges];
            
            _label.strikethrough = NO;
        }
    
    }
}

@end
