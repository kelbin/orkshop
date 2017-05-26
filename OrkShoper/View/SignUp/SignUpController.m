//
//  SignUpController.m
//  OrkShoper
//
//  Created by Келбин on 25.04.17.
//  Copyright © 2017 Келбин. All rights reserved.
//

#import "SignUpController.h"
#import "ViewController.h"
#import <sqlite3.h>

@interface SignUpController ()<UITextFieldDelegate>
{
    UIButton *signup;
    NSString *car;
    sqlite3 *orkshoper;
    NSMutableArray *items;
  
}

@end

@implementation SignUpController 

- (void)viewDidLoad {
    [super viewDidLoad];
    [self topline];
    [self middleline];
    [self backgroundreg];
    [self bottomline];
    [self labelfornick];
    [self labelforemail];
    [self labelforpass];
    [self signup];
    [self login];
    [self email];
    [self pass];
    [self backbutton];
    
    
    
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

-(void)insertQueryForDatabase{
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSManagedObject *users = [NSEntityDescription insertNewObjectForEntityForName:@"Users" inManagedObjectContext:context];
    [users setValue:email.text forKey:@"email"];
    [users setValue:login.text forKey:@"login"];
    [users setValue:pass.text  forKey:@"password"];
    NSError *error;
    if (![context save:&error]){
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Ошибка"
                                      message:@"Ошибка при сохранении данных"
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
    else {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Регистрация"
                                      message:@"Регистрация успешно завершена"
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
    if ([email.text isEqual:@""] && [pass.text isEqual:@""]){
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
    if (email.text.length < 4 && pass.text.length < 4){
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Ошибка"
                                      message:@"Поля должны иметь не менее 4-х символов"
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
    NSFetchRequest *req = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:context];
    [req setEntity:entity];
    _fetchedObjects = [context executeFetchRequest:req error:&error];
    for (NSManagedObject *object in _fetchedObjects) {
        NSLog(@"Found %@", [object valueForKey:@"email"]);
    }
    NSLog(@"here");
    items = [NSMutableArray arrayWithObject:_fetchedObjects];
    NSLog(@"PRIVETIK %@", items);

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)backgroundreg{
    UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, 250)];
    back.image = [UIImage imageNamed:@"View/img/mainback4.png"];
    [self.view addSubview:back];
}

- (void)topline {
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(100, 350, 150, 2)];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.layer.cornerRadius = 3;
    [self.view addSubview:lineView];
}
-(void)labelfornick{
    UILabel *loglabel = [UILabel new];
    loglabel.text = @"Логин";
    loglabel.frame = CGRectMake(100, 335, 100, 100);
    loglabel.textColor = [UIColor blackColor];
    [self.view addSubview:loglabel];
}

-(void)labelforemail{
    UILabel *emlabel = [UILabel new];
    emlabel.text = @"Почта";
    emlabel.frame = CGRectMake(100, 265, 100, 100);
    emlabel.textColor = [UIColor blackColor];
    [self.view addSubview:emlabel];

}

-(BOOL)labelforpass {
    UILabel *passlabel = [UILabel new];
    passlabel.text = @"Пароль";
    passlabel.frame = CGRectMake(100, 405, 100, 100);
    passlabel.textColor = [UIColor blackColor];
    [self.view addSubview:passlabel];
    return YES;
}

-(void)signup {
    signup = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [signup setTitle:@"Зарегистрироваться"  forState:UIControlStateNormal];
    [signup setTitleColor:[UIColor colorWithRed:250 green:250 blue:250 alpha:.77] forState:UIControlStateNormal];
    signup.frame = CGRectMake(10.0, 520.0, 160.0, 40.0);
    signup.layer.cornerRadius = 10;
    [signup addTarget:self action:@selector(lol)
     forControlEvents:UIControlEventTouchUpInside];
    [signup addTarget:self action:@selector(insertQueryForDatabase)
     forControlEvents:UIControlEventTouchUpInside];
    signup.backgroundColor = [UIColor blackColor];
    [self.view addSubview:signup];
    
}

-(void)actionsign {
    NSLog(@"Hello");

}

-(void)login {
    login = [UITextField new];
    login.delegate = self;
    login.frame = CGRectMake(100, 360, 100, 100);
    login.textColor = [UIColor blackColor];
    login.tintColor = [UIColor blackColor];
    [self.view addSubview:login];
}
-(void)email {
    email= [UITextField new];
    email.delegate = self;
    email.frame = CGRectMake(100, 290, 150, 100);
    email.textColor = [UIColor blackColor];
    email.tintColor = [UIColor blackColor];
    [self.view addSubview:email];
}

-(IBAction)lol {
    NSString *emailt = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
    NSPredicate *emailtest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailt];
        if ([emailtest evaluateWithObject:email.text] == NO) {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"Ошибка"
                                          message:@"Пожалуйста, введите верный электронный адрес вашей почты"
                                          preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     //Do some thing here
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
}

-(void)pass {
    pass = [UITextField new];
    pass.delegate = self;
    pass.frame = CGRectMake(100, 430, 100, 100);
    pass.textColor = [UIColor blackColor];
    pass.tintColor = [UIColor blackColor];
    pass.secureTextEntry = YES;
    [self.view addSubview:pass];
}

-(void)backbutton {
    UIButton *backbutt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backbutt setTitle:@"Назад"  forState:UIControlStateNormal];
    [backbutt setTitleColor:[UIColor colorWithRed:250 green:250 blue:250 alpha:.77] forState:UIControlStateNormal];
    backbutt.frame = CGRectMake(200.0, 520.0, 100.0, 40.0);
    backbutt.layer.cornerRadius = 10;
    [backbutt addTarget:self action:@selector(actionsignup)
     forControlEvents:UIControlEventTouchUpInside];
    backbutt.backgroundColor = [UIColor blackColor];
    [self.view addSubview:backbutt];
}

-(void)labelfor{
    UILabel *emlabel = [UILabel new];
    emlabel.text = @"Почта";
    emlabel.frame = CGRectMake(200, 270, 100, 100);
    emlabel.textColor = [UIColor blackColor];
    [self.view addSubview:emlabel];
    
}
- (void)actionsignup {
    ViewController *mainsignup = [[ViewController alloc] init];
    [self.navigationController pushViewController:mainsignup animated:YES];
}

-(void)middleline {
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(100, 420, 150, 2)];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.layer.cornerRadius = 3;
    [self.view addSubview:lineView];
}

-(void)bottomline {
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(100, 490, 150, 2)];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.layer.cornerRadius = 3;
    [self.view addSubview:lineView];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"core"];
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
