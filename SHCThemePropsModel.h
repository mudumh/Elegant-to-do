//
//  SHCThemePropsModel.h
//  ClearStyle
//
//  Created by Harsha Vardhan on 6/28/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHCThemePropsModel : NSObject<NSCoding>

@property(nonatomic,strong) UIColor* cellbackgroundColor;
@property(nonatomic,strong) UIColor* fontColor;

@property(nonatomic,strong) UIColor* buttonColor;
@property(nonatomic,strong) UIColor* navigationBarColor;
@property(nonatomic,strong) UIColor* navigationBarTitleColor;

@end
