//
//  ViewController.m
//  OrkShoper
//
//  Created by Келбин on 20.04.17.
//  Copyright © 2017 Келбин. All rights reserved.
//

#import "ViewController.h"
#import "SignUpController.h"
#import "NewsController.h"

@interface ViewController () <UITextFieldDelegate,UITabBarControllerDelegate> {

    UIImageView *imganim;
    sqlite3 *hello;
    UITextField *login;
    UITextField *pass;
    BOOL enter;
}

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataFromDatabase];
    [self background];
    [self tabBarItem];
    [self topline];
    [self loginup];
    [self signup];
    [self login];
    [self password];
    [self bottomline];
    [self labelforlogin];
    [self labelforpass];

}
-(void)loadDataFromDatabase {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSFetchRequest *req = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Clients" inManagedObjectContext:context];
    [req setEntity:entity];
    [req setPropertiesToFetch:@[@"login",@"password"]];
    [req setResultType:NSDictionaryResultType];
    [req setReturnsDistinctResults:YES];
    req.returnsObjectsAsFaults = NO;
    NSError *error;
    if (![context save:&error]){
    }
    items = [context executeFetchRequest:req error:&error];
    for (NSManagedObject *priv in items){
        NSLog(@"%@", priv);
        
    }

}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

-(IBAction)checktoent {
    if ([items containsObject:@{@"login":login.text,@"password": pass.text}]) {
        NewsController *news = [NewsController new];
        [self.navigationController pushViewController:news animated:YES];
    }
    else {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Ошибка"
                                      message:@"Введеные данные не верны"
                                      preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    if ([login.text  isEqual: @""] && [pass.text  isEqual: @""]) {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Ошибка"
                                      message:@"Поля пустые"
                                      preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(UIImageView*)background {
    back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, 250)];
    back.image = [UIImage imageNamed:@"mainback4.png"];
    [self.view addSubview:back];
    return back;
}

- (void)topline {
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(80, 350, 150, 2)];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.layer.cornerRadius = 3;
    [self.view addSubview:lineView];
}

- (void)loginup {
    UIButton *logup = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [logup setTitle:@"Войти"  forState:UIControlStateNormal];
    [logup setTitleColor:[UIColor colorWithRed:250 green:250 blue:250 alpha:.77] forState:UIControlStateNormal];
    logup.frame = CGRectMake(120.0, 460.0, 80.0, 40.0);
    logup.layer.cornerRadius = 10;
    [logup addTarget:self action:@selector(checktoent)
    forControlEvents:UIControlEventTouchUpInside];
    logup.backgroundColor = [UIColor blackColor];
    [self.view addSubview:logup];
}

- (void)actionsignup:(UIButton *)signup  {
    SignUpController *mainsignup = [[SignUpController alloc] init];
    [self.navigationController pushViewController:mainsignup animated:YES];
}

-(void)signup {
    UIButton *signup = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [signup setTitle:@"Зарегистрироваться"  forState:UIControlStateNormal];
    [signup setTitleColor:[UIColor colorWithRed:250 green:250 blue:250 alpha:.77] forState:UIControlStateNormal];
    signup.frame = CGRectMake(80.0, 520.0, 160.0, 40.0);
    signup.layer.cornerRadius = 10;
    [signup addTarget:self action:@selector(actionsignup:)
    forControlEvents:UIControlEventTouchUpInside];
    signup.backgroundColor = [UIColor blackColor];
    [self.view addSubview:signup];
}

-(void)login {
    login = [UITextField new];
    login.delegate = self;
    login.frame = CGRectMake(80, 290, 100, 100);
    login.textColor = [UIColor blackColor];
    login.tintColor = [UIColor blackColor];
    [self.view addSubview:login];
}

-(void)bottomline {
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(80, 430, 150, 2)];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.layer.cornerRadius = 3;
    [self.view addSubview:lineView];
}

-(void)password {
    pass = [UITextField new];
    pass.delegate = self;
    pass.frame = CGRectMake(80, 370, 100, 100);
    pass.textColor = [UIColor blackColor];
    pass.tintColor = [UIColor blackColor];
    pass.secureTextEntry = YES;
    [self.view addSubview:pass];
}

-(void)labelforlogin {
    UILabel *loglabel = [UILabel new];
    loglabel.text = @"Логин";
    loglabel.frame = CGRectMake(80, 260, 100, 100);
    loglabel.textColor = [UIColor blackColor];
    [self.view addSubview:loglabel];
}

-(void)labelforpass {
    UILabel *logpass = [UILabel new];
    logpass.text = @"Пароль";
    logpass.frame = CGRectMake(80, 340, 100, 100);
    logpass.textColor = [UIColor blackColor];
    [self.view addSubview:logpass];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
/*
-(void)animateimage {
    imganim = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, 250)];
    imganim.image = [UIImage imageNamed:@"o3.png"];
    [self.view addSubview:imganim];
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(moveimage) userInfo:nil repeats:YES];

}
                                                                    //animated block
-(IBAction)moveimage {
    CGPoint pointOne=CGPointMake(300, 300);
    imganim.center=pointOne;

}
*/


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Model"];
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
