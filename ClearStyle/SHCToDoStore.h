//
//  SHCToDoStore.h
//  ClearStyle
//
//  Created by Harsha Vardhan on 6/1/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHCToDoItem.h"
#import "SHCCustomUIConfigModel.h"
#import "SHCThemePropsModel.h"
@interface SHCToDoStore : NSObject
{
    NSMutableArray *allItems;
    NSMutableArray *allAssetTypes;
}

-(void)removeItem:(SHCToDoItem *) p;
-(NSArray* )allItems;
//-(void)moveItemsAtIndex:(int)from toIndex:(int)to;
-(SHCToDoItem *)createItem;

+(SHCToDoStore *) sharedStore;
-(NSString *)itemArchivePath;

-(BOOL)saveChanges;


-(NSString* )itemArchivePathForCustomUI;
-(NSString * )itemsArchivePathForTheme;

-(BOOL)saveChangesForUI;
-(BOOL)saveChangesForTheme;
-(SHCCustomUIConfigModel*)loadChangesInUI;
-(SHCThemePropsModel*)loadThemeProps;

@property(nonatomic,strong) SHCCustomUIConfigModel * UImodel;
@property(nonatomic,strong)SHCThemePropsModel * themeModel;
@property (nonatomic,strong) NSManagedObjectContext* context;
@property NSManagedObjectModel * model;

@end
