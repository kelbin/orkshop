//
//  GoodsCustomCellController.h
//  OrkShoper
//
//  Created by Келбин on 12.06.17.
//  Copyright © 2017 Келбин. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodsCustomCellController;
@protocol CustomCellDelegate <NSObject>

//-(void)layoutSubviews;
-(void)test;

@end

@interface GoodsCustomCellController : UITableViewCell


@property (strong) UILabel *quantity;
@property (nonatomic,strong) UIButton * quantityplus;
@property (nonatomic,strong) UIButton *quantityminus;
@property (nonatomic, assign) id <CustomCellDelegate> delegate;

@end
