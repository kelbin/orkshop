//
//  MarketController.m
//  OrkShoper
//
//  Created by Келбин on 15.05.17.
//  Copyright © 2017 Келбин. All rights reserved.
//

#import "MarketController.h"
#import "JSONKit.h"
#import "MarketSubTreeController.h"
#import "CartController.h"

@interface MarketController () <UITableViewDelegate,UITableViewDataSource,UITabBarControllerDelegate> {
    NSDictionary *json;
}

@end

@implementation MarketController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self leftmenu];
    [[self navigationItem] setHidesBackButton:YES animated:NO];
    NSString *str=[[NSBundle mainBundle] pathForResource:@"market1ForOrkShop" ofType:@"json"];
    NSData *jsondata = [NSData dataWithContentsOfFile:str];
    [self.navigationItem setTitle:@"Магазин"];
    JSONDecoder *decoder = [[JSONDecoder alloc] initWithParseOptions:JKParseOptionNone];
    json = [decoder objectWithData:jsondata];
    _market = json[@"market"];
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_market count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[_market objectAtIndex:indexPath.row]objectForKey:@"image"]]]];
    [cell.imageView setImage:img];
    [[cell textLabel] setText:[[_market objectAtIndex:indexPath.row]objectForKey:@"title"]];
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:10.0];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 40;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MarketSubTreeController *marketsubtree = [MarketSubTreeController new];
    marketsubtree.marketsub = json[@"market"][indexPath.row][@"subtree"];
    [self.navigationController pushViewController:marketsubtree animated:YES];
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

@end
