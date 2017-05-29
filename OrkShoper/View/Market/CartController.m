//
//  CartController.m
//  OrkShoper
//
//  Created by Келбин on 27.05.17.
//  Copyright © 2017 Келбин. All rights reserved.
//

#import "CartController.h"
#import "GoodsController.h"

@interface CartController () <UITableViewDelegate,UITableViewDataSource,UITabBarControllerDelegate> {}

@end

@implementation CartController 

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    [self.navigationItem setTitle:@"Корзина"];
    _context = self.persistentContainer.viewContext;
    NSFetchRequest *req = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Cart" inManagedObjectContext:_context];
    [req setEntity:entity];
    [req setResultType:NSDictionaryResultType];
    [req setReturnsDistinctResults:YES];
    req.returnsObjectsAsFaults = NO;
    NSError *error;
    if (![_context save:&error]){
    }
    NSArray *fetchedObjects = [_context executeFetchRequest:req error:&error];
    _carts = fetchedObjects;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    UILabel *value = [UILabel new];
    value.frame = CGRectMake(120, 10, 30, 30);
    value.text = @"руб";
    value.textColor = [UIColor blackColor];
    value.font = [UIFont fontWithName:@"Arial" size:10];
    [cell addSubview:value];
    cell.imageView.frame = CGRectMake(10, 19, 10,10);
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [cell.imageView setImage:img];
    [[cell textLabel] setText:[[_carts objectAtIndex:indexPath.row]objectForKey:@"title"]];
    [[cell detailTextLabel] setText:[[_carts objectAtIndex:indexPath.row] objectForKey:@"price"]];
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:10.0];
    NSArray *hi = [[_carts objectAtIndex:indexPath.row] objectForKey:@"price"];
    NSLog(@"%@", hi);
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
        NSString *price = [[_carts objectAtIndex:indexPath.row] objectForKey:@"price"];
        NSLog(@"%@ and %@ and %@",title,image,price);
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSManagedObject *db = [NSEntityDescription insertNewObjectForEntityForName:@"Cart" inManagedObjectContext:_context];
        [fetchRequest setEntity:[NSEntityDescription entityForName:@"Cart" inManagedObjectContext:_context]];
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"title == %@ AND image == %@ AND price == %@", title, image, price]];
        [_context deleteObject:db];                     // В логах все нормально, но запрос на удаление не происходит
        NSError* error = nil;
        [_context save:&error];
        NSLog(@"%@", fetchRequest);
        NSMutableArray *cartselements = [NSMutableArray arrayWithArray:_carts];
        NSLog(@"%@", cartselements);
        [cartselements removeObjectAtIndex:indexPath.row];
        //add code here for when you hit delete
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
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"core"];
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
