//
//  SHCThemePropsModel.m
//  ClearStyle
//
//  Created by Harsha Vardhan on 6/28/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import "SHCThemePropsModel.h"

@implementation SHCThemePropsModel

@synthesize cellbackgroundColor;
@synthesize fontColor;
@synthesize navigationBarColor;
@synthesize navigationBarTitleColor;
@synthesize buttonColor;


-(void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:cellbackgroundColor forKey:@"cellbackgroundcolor"];
    [aCoder encodeObject:fontColor forKey:@"fontColor"];
    [aCoder encodeObject:navigationBarColor forKey:@"navigationBarColor"];
    [aCoder encodeObject:navigationBarTitleColor forKey:@"navigationBarTitleColor"];
    [aCoder encodeObject:buttonColor forKey:@"buttonColor"];
   
    
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self){
        [self setCellbackgroundColor: [aDecoder decodeObjectForKey:@"cellbackgroundcolor"]];
        [self setFontColor: [aDecoder decodeObjectForKey:@"fontColor"]];
        [self setNavigationBarColor: [aDecoder decodeObjectForKey:@"navigationBarColor"]];
        [self setNavigationBarTitleColor: [aDecoder decodeObjectForKey:@"navigationBarTitleColor"]];
        
        [self setButtonColor: [aDecoder decodeObjectForKey:@"buttonColor"]];
        
    }
    return self;
    
}



@end
