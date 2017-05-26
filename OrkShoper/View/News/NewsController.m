//
//  NewsController.m
//  OrkShoper
//
//  Created by Келбин on 07.05.17.
//  Copyright © 2017 Келбин. All rights reserved.
//

#import "NewsController.h"
#import "JSONKit.h"
#import "NewsCellsController.h"

@interface NewsController ()<UITableViewDelegate,UITableViewDataSource,UITabBarControllerDelegate> {
    NSString *title;
    NSArray*students;
    NSDictionary *json;
   
}
@end

@implementation NewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tabBarItem];
    [[self navigationItem] setHidesBackButton:YES animated:NO];
    NSString *str=[[NSBundle mainBundle] pathForResource:@"Model/NewsForOrkShoper" ofType:@"json"];
    NSData *jsondata = [NSData dataWithContentsOfFile:str];
    [self.navigationItem setTitle:@"Лента"];
    JSONDecoder *decoder = [[JSONDecoder alloc] initWithParseOptions:JKParseOptionNone];
    json = [decoder objectWithData:jsondata];
    _hi = json[@"news"];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_hi count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //Поиск ячейки
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    //Если ячейка не найдена
    if (cell == nil) {
        //Создание ячейки
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    //cell.textLabel.text = [students objectAtIndex:indexPath.row];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[_hi objectAtIndex:indexPath.row]objectForKey:@"image"]]]];
    [cell.imageView setImage:img];
    [[cell textLabel] setText:[[_hi objectAtIndex:indexPath.row]objectForKey:@"title_news"]];
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:10.0];
        //cell.textLabel.text = [students objectAtIndex:indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 40;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsCellsController *newscells = [NewsCellsController new];
    newscells.img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[_hi objectAtIndex:indexPath.row]objectForKey:@"image"]]]];
    newscells.news_title = [[_hi objectAtIndex:indexPath.row]objectForKey:@"description"];
    [self.navigationController pushViewController:newscells animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
