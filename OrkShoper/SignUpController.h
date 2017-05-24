//
//  SignUpController.h
//  OrkShoper
//
//  Created by Келбин on 25.04.17.
//  Copyright © 2017 Келбин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface SignUpController : UIViewController
{
    
    UITextField *email;
    UITextField *login;
    UITextField *pass;
    

}
@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (nonatomic, strong) NSArray* fetchedObjects;
-(void)saveContext;

-(void)insertQueryForDatabase;

@end
