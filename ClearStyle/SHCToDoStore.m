//
//  SHCToDoStore.m
//  ClearStyle
//
//  Created by Harsha Vardhan on 6/1/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import "SHCToDoStore.h"


#import "SHCToDoStore.h"
#import "UIColor+FlatUI.h"
@implementation SHCToDoStore
{

}

@synthesize context;
@synthesize model;
@synthesize UImodel;
-(id)init
{
    self = [super init];
    if(self)
    {
        model = [NSManagedObjectModel mergedModelFromBundles:nil];
        
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        NSString* path = [self itemArchivePath];
        NSURL *storeURL =[NSURL fileURLWithPath:path];
        NSError *error = nil;
        if(![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
        {
            [NSException raise:@"open failed" format:@"Reason : %@",[error localizedDescription]];
            
            
        }
        context = [[NSManagedObjectContext alloc] init];
        [context setPersistentStoreCoordinator:psc];
        [context setUndoManager:nil];
        
    }
    
    return self;
    
}

+(SHCToDoStore *)sharedStore
{
    static SHCToDoStore* sharedStore = nil;
    if(!sharedStore)
    {
        sharedStore = [[super allocWithZone:nil]init];
    }
    
    return sharedStore;
}

+(id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}

-(NSArray *)allItems
{
    return allItems;
    
}

-(BOOL) saveChanges
{
    NSError * err = nil;
    BOOL successful =  [context save:&err];
    if(!successful)
    {
          
          
        
    }
    return successful;
    
}

-(NSString *)itemArchivePath
{
    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentDirectory= [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"store2.data"];
    
}

-(SHCToDoItem *)createItem
{
    /**   double order;
     if([allItems count]==0)
     {
     order = 1.0;
     
     }
     else
     {
     order  = [[allItems lastObject] orderingValue]+1.0;
     
     }*/
    
    SHCToDoItem * p = [NSEntityDescription insertNewObjectForEntityForName:@"SHCToDoItem" inManagedObjectContext:context];
    // [p setOrderingValue:order];
    
   // [allItems addObject:p];
   
    
    return p;
}

-(void)removeItem:(SHCToDoItem *)p

{
      
    [context deleteObject:p];
    
    [self saveChanges];
    
    
}

-(NSString*)itemArchivePathForCustomUI
{
    NSArray* documentsDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [documentsDirectories objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"uiconfig.archive"];

}

-(BOOL)saveChangesForUI
{
    NSString* path = [self itemArchivePathForCustomUI];
    return [NSKeyedArchiver archiveRootObject:[self UImodel] toFile:path];
    
    
    
}
-(SHCCustomUIConfigModel*)loadChangesInUI
{
    NSString* path = [self itemArchivePathForCustomUI];
    [self setUImodel:[NSKeyedUnarchiver unarchiveObjectWithFile:path]];
    if(![self UImodel])
    {
          
        [self setUImodel:[[SHCCustomUIConfigModel alloc] init]] ;
        [[self UImodel] setCellbackgroundColor:[UIColor blueColor]];
        [[self UImodel] setFontColor:[UIColor whiteColor]];
    
    }
    //  
    return [self UImodel];
    

}

-(NSString *)itemsArchivePathForTheme
{

    NSArray* documentsDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [documentsDirectories objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"themeprops.archive"];

}
-(SHCThemePropsModel*)loadThemeProps
{
    NSString* path = [self itemsArchivePathForTheme];
    [self setThemeModel:[NSKeyedUnarchiver unarchiveObjectWithFile:path]];
    if(![self themeModel])
    {
          
        [self setThemeModel:[[SHCThemePropsModel alloc] init]] ;
        [[self themeModel] setCellbackgroundColor:[UIColor blackColor]];
        [[self themeModel] setFontColor:[UIColor whiteColor]];
        [[self themeModel] setButtonColor:[[UIColor blackColor ] colorWithAlphaComponent:0.7]];
        [[self themeModel] setNavigationBarColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]];
        [[self themeModel] setNavigationBarTitleColor:[UIColor whiteColor]];
        
        
    }
  
    return [self themeModel];

}
-(BOOL)saveChangesForTheme
{

    NSString* path = [self itemsArchivePathForTheme];
    return [NSKeyedArchiver archiveRootObject:[self themeModel] toFile:path];

}
@end
 
