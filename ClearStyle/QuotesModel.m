//
//  QuotesModel.m
//  ClearStyle
//
//  Created by Harsha Vardhan on 7/1/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import "QuotesModel.h"

@implementation QuotesModel
@synthesize quotes;
-(id)init
{
    self = [super init];
    if(self)
    {
        NSArray * collection_quotes =
        [NSArray
         arrayWithObjects:

         @"In the absence of willpower the most complete collection of virtues and talents is wholly worthless.",
                                       @"No day but today",@"We make a living by what we get, we make a life by what we give."  ,
                                       @"The most important thing is not to stop questioning.",
         @"Thinking will not overcome fear but action will.",
         @"We don't see things as they are, we see things as we are.",
         @"I find that the harder I work, the more luck I seem to have",
         @"All glory comes from daring to begin",
         @"Kind words can be short and easy to speak, but their echoes are truly endless.",
         @"Leave the past, engage the present, create the future",
         @"Nothing is particularly hard if you divide it into small jobs.",
         @"A good plan today is better than a great plan tomorrow",
         @"To conquer fear is the beginning of wisdom.",
         @"There is none so blind as those who will not listen.",
         @"Don't let yesterday take up too much of today.",
         @"Your life does not get better by chance, it gets better by change",
         @"Plan you work and work your plan.",
        @"'The future depends on what we do in the present.' - Mahatma Gandhi",
         @"'Clear thinking requires courage rather than intelligence.' - Thomas Szasz",
         @"'All our dreams can come true - if we have the courage to pursue them '-Walt Disney",
         @"Action may not always bring happiness, but there is no happiness without action.― William Jame",@"Action is the foundational key to all success - Pablo Picasso",
         @"If your ship doesnt come in, swim out to meet it- Jonathan Winters",@"It is quite possible to work without results, but never will there be results without work.",@"A man grows most tired while standing still.",
         @"I never did anything by accident, nor did any of my inventions come by accident; they came by work.- Thomas Edison",@"Life shrinks or expands in proportion to one's courage.",@"Count your age by friends, not years. Count your life by smiles, not tears. - John Lennon",
         
         
         
         nil];
        [self setQuotes:collection_quotes];    }
        return self;

}
-(NSString*)getRandomQuote:(id)sender
{
    NSInteger array_size = [[self quotes] count];
    NSInteger index = arc4random()%array_size;
    return [quotes objectAtIndex:index];
}
+(QuotesModel*)sharedQuotesModel
{

    static QuotesModel* sharedStore = nil;
    if(!sharedStore)
    {
        sharedStore = [[super allocWithZone:nil]init];
    }
    
    return sharedStore;


}
@end
