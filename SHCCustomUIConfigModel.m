//
//  SHCCustomUIConfigModel.m
//  ClearStyle
//
//  Created by Harsha Vardhan on 6/11/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import "SHCCustomUIConfigModel.h"

@implementation SHCCustomUIConfigModel

@synthesize cellbackgroundColor;
@synthesize fontColor;
-(void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:cellbackgroundColor forKey:@"cellbackgroundcolor"];
    [aCoder encodeObject:fontColor forKey:@"fontColor"];

}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self){
    [self setCellbackgroundColor: [aDecoder decodeObjectForKey:@"cellbackgroundcolor"]];
    [self setFontColor: [aDecoder decodeObjectForKey:@"fontColor"]];
    }
        return self;

}


@end
