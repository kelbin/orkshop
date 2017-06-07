//
//  GoodsController.m
//  OrkShoper
//
//  Created by Келбин on 19.05.17.
//  Copyright © 2017 Келбин. All rights reserved.
//

#import "GoodsController.h"
#import "MarketSubTreeController.h"
#import "JSONKit.h"
#import "CartController.h"

@interface GoodsController () <UITableViewDelegate> {
    UIButton *quantityplus;
    UIButton *quantityminus;

}
@end

@implementation GoodsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self leftmenu];
    [self.navigationItem setTitle:@"Магазин"];
    _context = self.persistentContainer.viewContext;
    self.quantity = [[UILabel alloc] init];
    quantityplus = [[UIButton alloc] init];
    quantityminus = [[UIButton alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(IBAction)quaplus:(UIButton*)sender {
    NSInteger value = [self.quantity.text integerValue];
    value --;
    NSString *val = [NSString stringWithFormat:@"%ld",(long)value];
   // self.quantity.tag = (int) sender.tag;
    self.quantity.text = val;
}

-(IBAction)quaminus:(UIButton*)sender {
    NSInteger value = [self.quantity.text integerValue];
    value ++;
    NSString *val = [NSString stringWithFormat:@"%ld",(long)value];
    self.quantity.tag = (int) sender.tag;
    NSLog(@"%ld", (long)self.quantity.tag);
    self.quantity.text = val;
}


-(IBAction)leftmenu {
    UIBarButtonItem *rightbutton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cart.png"]
                                                                    style:UIBarButtonItemStylePlain target:self action:@selector(pushCart:)];
    rightbutton.tintColor = [UIColor blackColor];
    [self.navigationItem setRightBarButtonItem:rightbutton];
}

-(IBAction)pushCart:(UIButton*)sender {
    CartController *cart = [CartController new];
    [self.navigationController pushViewController:cart animated:YES];
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
    return [_goods count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {

        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
  /*  UIButton *addToCart = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addToCart.frame = CGRectMake(290.0, 0, 30.0, 30.0);
    addToCart.tintColor = [UIColor blackColor];
    [addToCart setTitle:@"Buy" forState:UIControlStateNormal];
    [addToCart addTarget:self action:@selector(hell:)
     forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:addToCart]; */
   /* UILabel *value = [UILabel new];
    value.frame = CGRectMake(120, 10, 30, 30);
    value.text = @"руб";
    value.textColor = [UIColor blackColor];
    value.font = [UIFont fontWithName:@"Arial" size:10];
    [cell addSubview:value]; */
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[_goods objectAtIndex:indexPath.row]objectForKey:@"image"]]]];
    [cell.imageView setImage:img];
    [[cell textLabel] setText:[[_goods objectAtIndex:indexPath.row]objectForKey:@"title"]];
    NSString* inttostr = [NSString stringWithFormat:@"%@ руб.",[[_goods objectAtIndex:indexPath.row] objectForKey:@"price"]];
    [[cell detailTextLabel] setText:inttostr];
    // addToCart.tag = indexPath.row;
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:10.0];
    self.quantity = [UILabel new];
    self.quantity.text = @"1";
    self.quantity.tag = indexPath.row;
    self.quantity.frame = CGRectMake(180, 10, 15, 15);
    self.quantity.textColor = [UIColor blackColor];
    self.quantity.tintColor = [UIColor blackColor];
    self.quantity.enabled = NO;
    quantityminus = [UIButton buttonWithType:UIButtonTypeCustom];
    quantityminus.tag = indexPath.row;
    [quantityminus setTitle:@"-"  forState:UIControlStateNormal];
    [quantityminus setTitleColor:[UIColor colorWithRed:250 green:250 blue:250 alpha:.77] forState:UIControlStateNormal];
    quantityminus.frame = CGRectMake(160, 10, 15, 15);
    [quantityminus addTarget:self action:@selector(quaplus:)
            forControlEvents:UIControlEventTouchUpInside];
    quantityminus.backgroundColor = [UIColor blackColor];
    quantityplus = [UIButton buttonWithType:UIButtonTypeCustom];
    quantityplus.tag = indexPath.row;
    [quantityplus setTitle:@"+"  forState:UIControlStateNormal];
    [quantityplus setTitleColor:[UIColor colorWithRed:250 green:250 blue:250 alpha:.77] forState:UIControlStateNormal];
    quantityplus.frame = CGRectMake(200, 10, 15, 15);
    [quantityplus addTarget:self action:@selector(quaminus:)
           forControlEvents:UIControlEventTouchUpInside];
    quantityplus.backgroundColor = [UIColor blackColor];
    [cell addSubview:self.quantity];
    [cell addSubview:quantityplus];
    [cell addSubview:quantityminus];
    return cell;
}

/*
-(IBAction)hell:(UIButton*)sender {
    NSLog(@"%ld",(long)sender.tag);
    _row = (int)sender.tag;
    NSLog(@"%@",_goods[_row]);
    CartController *carter = [[CartController alloc] init];
    carter.carts = _goods[_row];
    NSLog(@"%@", carter.carts);
    
} */

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = [[_goods objectAtIndex:indexPath.row] objectForKey:@"title"];
    NSString *image = [[_goods objectAtIndex:indexPath.row] objectForKey:@"image"];
    NSNumber *price = [[_goods objectAtIndex:indexPath.row] objectForKey:@"price"];
    NSManagedObject *db = [NSEntityDescription insertNewObjectForEntityForName:@"Carts" inManagedObjectContext:_context];
    [db setValue:title forKey:@"title"];
    [db setValue:image forKey:@"image"];
    [db setValue:price forKey:@"price"];
    NSFetchRequest *req = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Carts" inManagedObjectContext:_context];
    [req setEntity:entity];
    req.returnsObjectsAsFaults = NO;
    NSError *error;
    if (![_context save:&error]){
    }
    NSArray *fetchedObjects = [_context executeFetchRequest:req error:&error];
    _cararr = fetchedObjects;
    NSLog(@"%@", _cararr);
    for (NSManagedObject *obj in fetchedObjects){
        NSLog(@"%@", obj);
    }
    
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
