//
//  GoodsCustomCellController.m
//  OrkShoper
//
//  Created by Келбин on 12.06.17.
//  Copyright © 2017 Келбин. All rights reserved.
//

#import "GoodsCustomCellController.h"

@implementation GoodsCustomCellController
@synthesize delegate;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)layoutSubviews {
    [super layoutSubviews];
    [self test];
    self.quantity = [UILabel new];
    self.quantityplus = [UIButton new];
    self.quantityminus = [UIButton new];
    self.quantity.text = @"1";
    self.quantity.frame = CGRectMake(275, 10, 19, 15);
    self.quantity.font = [UIFont fontWithName:@"Arial" size:13];
    
    [self.quantityplus setTitle:@"+"  forState:UIControlStateNormal];
    [self.quantityplus setTitleColor:[UIColor colorWithRed:250 green:250 blue:250 alpha:.77] forState:UIControlStateNormal];
    self.quantityplus.frame = CGRectMake(250, 10, 15, 15);
    [self.quantityplus addTarget:self action:@selector(plus)
     forControlEvents:UIControlEventTouchUpInside];
    self.quantityplus.backgroundColor = [UIColor blackColor];
    
    [self.quantityminus setTitle:@"-"  forState:UIControlStateNormal];
    [self.quantityminus setTitleColor:[UIColor colorWithRed:250 green:250 blue:250 alpha:.77] forState:UIControlStateNormal];
    self.quantityminus.frame = CGRectMake(290, 10, 15, 15);
    [self.quantityminus addTarget:self action:@selector(minus)
                forControlEvents:UIControlEventTouchUpInside];
    self.quantityminus.backgroundColor = [UIColor blackColor];
    [self addSubview:self.quantity];
    [self addSubview:self.quantityminus];
    [self addSubview:self.quantityplus];
    
}

-(void)test {
    NSLog(@"Privet");
    [self.delegate test];
}

-(IBAction)minus {
    NSInteger b = [_quantity.text integerValue];
    b --;
    NSString *a = [NSString stringWithFormat:@"%ld", (long)b];
    self.quantity.text = a;
}

-(IBAction)plus {
    NSInteger b = [_quantity.text integerValue];
    b ++;
    NSString *a = [NSString stringWithFormat:@"%ld", (long)b];
    self.quantity.text = a;
}

@end
