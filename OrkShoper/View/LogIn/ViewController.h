//
//  ViewController.h
//  OrkShoper
//
//  Created by Келбин on 20.04.17.
//  Copyright © 2017 Келбин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ViewController : UIViewController {
UIImageView *back;
    NSArray *items;
    
}


@property (readonly, strong) NSPersistentContainer *persistentContainer;

-(UIImageView*)background;
-(void)loginup;
-(void)login;

@end

