//
//  GoodsCustomCellController.h
//  OrkShoper
//
//  Created by Келбин on 12.06.17.
//  Copyright © 2017 Келбин. All rights reserved.
//

#import <UIKit/UIKit.h>

/*@class GoodsCustomCellController;
@protocol CustomCellDelegate <NSObject>

//-(void)layoutSubviews;
//-(void)test;
//-(void)setQuantity:(UILabel*)quantity;

@end*/

@interface GoodsCustomCellController : UITableViewCell

@property (nonatomic,retain) UILabel *quantity;
@property (nonatomic,strong) UIButton * quantityplus;
@property (nonatomic,strong) UIButton *quantityminus;
//@property (nonatomic, weak) id <CustomCellDelegate> delegate;

@end
