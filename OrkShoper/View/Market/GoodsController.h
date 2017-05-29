//
//  GoodsController.h
//  OrkShoper
//
//  Created by Келбин on 19.05.17.
//  Copyright © 2017 Келбин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarketSubTreeController.h"
#import <CoreData/CoreData.h>


@interface GoodsController : UITableViewController


@property (nonatomic,strong)NSArray *goods;
@property (nonatomic)int row;
@property (readonly, strong)NSPersistentContainer *persistentContainer;
@property (nonatomic,strong)NSManagedObjectContext *context;
@property (nonatomic,strong)NSArray *cararr;

@end
