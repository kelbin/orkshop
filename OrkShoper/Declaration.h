//
//  Declaration.h
//  OrkShoper
//
//  Created by Келбин on 26.04.17.
//  Copyright © 2017 Келбин. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol Declaration <NSObject>
@optional

-(void)background;

@end

@interface Declaration : NSObject

@property (nonatomic,weak) id <Declaration> delegate;

@end
