//
//  CartController.m
//  OrkShoper
//
//  Created by Келбин on 27.05.17.
//  Copyright © 2017 Келбин. All rights reserved.
//

#import "CartController.h"
#import "GoodsController.h"
#import "PayController.h"

@interface CartController () <UITableViewDelegate,UITableViewDataSource,UITabBarControllerDelegate,UIPopoverControllerDelegate> {
    int sum;
    UILabel *value;

}

@end

@implementation CartController 

- (void)viewDidLoad {
    [super viewDidLoad];
    [self paynow];
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    [self.navigationItem setTitle:@"Корзина"];
    _context = self.persistentContainer.viewContext;
    NSFetchRequest *req = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Carts" inManagedObjectContext:_context];
    [req setEntity:entity];
    [req setResultType:NSDictionaryResultType];
    [req setReturnsDistinctResults:YES];
    req.returnsObjectsAsFaults = NO;
    NSError *error;
    if (![_context save:&error]){
    }
    GoodsCustomCellController *goods = [GoodsCustomCellController new];
    goods.delegate = self;
    _textprice = [UILabel new];
    NSArray *fetchedObjects = [_context executeFetchRequest:req error:&error];
    _carts = fetchedObjects;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)test {
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_carts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[_carts objectAtIndex:indexPath.row]objectForKey:@"image"]]]];
    value = [UILabel new];
    value.frame = CGRectMake(15, 10, 30, 30);
    value.textColor = [UIColor blackColor];
    value.font = [UIFont fontWithName:@"Arial" size:10];
    [cell addSubview:value];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [cell.imageView setImage:img];
    NSString* inttostr = [NSString stringWithFormat:@"%@ руб.",[[_carts objectAtIndex:indexPath.row] objectForKey:@"price"]];
    [[cell detailTextLabel] setText:inttostr];
    [[cell textLabel] setText:[[_carts objectAtIndex:indexPath.row]objectForKey:@"title"]];
    [[cell detailTextLabel] setText:inttostr];
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:10.0];
    // NSArray *prices = [NSArray arrayWithObject:[[_carts objectAtIndex:indexPath.row] objectForKey:@"price"]];
    sum = 0;
    
    for (NSNumber *q in [_carts valueForKey:@"price"]){
        sum += [q intValue];
    }
    NSLog(@"%d", sum);
    _textprice.frame = CGRectMake(80, 330, 200, 100);
    _textpri = [NSString stringWithFormat:@"Ваша сумма : %d руб.",sum];
    _textprice.text = _textpri;
    _textprice.textColor = [UIColor blackColor];
    _textprice.font = [UIFont fontWithName:@"Arial" size:15];
    [self.view addSubview:_textprice];
    /*int sum = 0;
    for (NSNumber *b in prices){
        sum += [b intValue];
    }
    NSLog(@"%i",sum);*/
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *title = [[_carts objectAtIndex:indexPath.row] objectForKey:@"title"];
        NSString *image = [[_carts objectAtIndex:indexPath.row] objectForKey:@"image"];
        NSNumber *price = [[_carts objectAtIndex:indexPath.row] objectForKey:@"price"];
        NSLog(@"%@ and %@ and %@",title,image,price);
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
       // NSManagedObject *db = [NSEntityDescription insertNewObjectForEntityForName:@"Cart" inManagedObjectContext:_context];
        [fetchRequest setEntity:[NSEntityDescription entityForName:@"Carts" inManagedObjectContext:_context]];
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"title == %@ AND image == %@ AND price == %@", title, image, price]];
        NSError* error = nil;
        NSArray* results = [_context executeFetchRequest:fetchRequest error:&error];
        for (NSManagedObject *obj in results){
        [_context deleteObject:obj];
        }
        if (![_context save:&error]){
            NSLog(@"NE ROBIT");
        }
        NSMutableArray *cartselements = [NSMutableArray arrayWithArray:_carts];
        NSLog(@"%@", cartselements);
        [cartselements removeObjectAtIndex:indexPath.row];
        _carts = cartselements;
       // [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]  withRowAnimation:UITableViewRowAnimationRight];
        [tableView reloadData];
        [_textprice setText:_textpri];
        //add code here for when you hit delete
    }
}

-(void)paynow {
    UIButton *paynow = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [paynow setTitle:@"Оплатить заказ"  forState:UIControlStateNormal];
    [paynow setTitleColor:[UIColor colorWithRed:250 green:250 blue:250 alpha:.77] forState:UIControlStateNormal];
    paynow.frame = CGRectMake(80.0, 400.0, 160.0, 40.0);
    paynow.layer.cornerRadius = 10;
    [paynow addTarget:self action:@selector(pushtopaycon)
     forControlEvents:UIControlEventTouchUpInside];
    paynow.backgroundColor = [UIColor blackColor];
    [self.view addSubview:paynow];
}

-(IBAction)pushtopaycon {
    PayController *paycon = [PayController new];
    [self.navigationController pushViewController:paycon animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 40;
}



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Model"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}



@end
