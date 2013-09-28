//
//  QuotesModel.h
//  ClearStyle
//
//  Created by Harsha Vardhan on 7/1/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuotesModel : NSObject
@property(strong,nonatomic) NSArray* quotes;
-(id)init;
+(QuotesModel *) sharedQuotesModel;
-(NSString*)getRandomQuote:(id)sender;
@end
