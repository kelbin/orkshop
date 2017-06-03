//
//  CartController.h
//  OrkShoper
//
//  Created by Келбин on 27.05.17.
//  Copyright © 2017 Келбин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface CartController : UITableViewController

@property (nonatomic,strong)NSArray *carts;
@property (nonatomic,strong)NSManagedObjectContext *context;
@property (readonly,strong)NSPersistentContainer *persistentContainer;
@property (nonatomic,weak)IBOutlet UIImageView *photo;
@property (nonatomic,strong)UILabel *textprice;
@property (nonatomic,strong)NSString *textpri;

@end
