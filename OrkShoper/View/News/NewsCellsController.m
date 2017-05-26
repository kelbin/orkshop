//
//  NewsCellsController.m
//  OrkShoper
//
//  Created by Келбин on 10.05.17.
//  Copyright © 2017 Келбин. All rights reserved.
//

#import "NewsCellsController.h"
#import "NewsController.h"

@implementation NewsCellsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self postimage];
    [self.navigationItem.backBarButtonItem setTintColor:[UIColor blackColor]];
    UILabel *loglabel = [UILabel new];
    loglabel.font = [UIFont fontWithName:@"Arial" size:10];
    loglabel.numberOfLines = 0;
    loglabel.text = _news_title;
    loglabel.frame = CGRectMake(10, 250, 300, 200);
    loglabel.textColor = [UIColor blackColor];
    [self.view addSubview:loglabel];
}


-(void)postimage {
    UIImageView*back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, 320, 250)];
    back.image = _img;
    [self.view addSubview:back];
}


@end
