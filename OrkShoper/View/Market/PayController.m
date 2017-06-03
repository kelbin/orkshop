//
//  PayController.m
//  OrkShoper
//
//  Created by Келбин on 01.06.17.
//  Copyright © 2017 Келбин. All rights reserved.
//

#import "PayController.h"
#import <QuartzCore/QuartzCore.h>

@interface PayController () <PKViewDelegate,UITextFieldDelegate> {}

@end

@implementation PayController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.paymentView = [[PKView alloc] initWithFrame:CGRectMake(10, 270, 290, 55)];
    self.paymentView.delegate = self;
    [self.view addSubview:self.paymentView];
    [self labelForName];
    [self textForName];
    [self labelForSecondName];
    [self textForSecondName];
    [self labelForThirdName];
    [self textForThirdName];
    [self labelForAddress];
    [self textForAddress];
    [self pay];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) paymentView:(PKView*)paymentView withCard:(PKCard *)card isValid:(BOOL)valid {
    NSLog(@"Card number: %@", card.number);
    NSLog(@"Card expiry: %lu/%lu", (unsigned long)card.expMonth, (unsigned long)card.expYear);
    NSLog(@"Card cvc: %@", card.cvc);
    NSLog(@"Address zip: %@", card.addressZip);
    
    // self.navigationItem.rightBarButtonItem.enabled = valid;
}

-(void)labelForName {
    UILabel *labforname = [UILabel new];
    labforname.text = @"Имя:";
    labforname.frame = CGRectMake(30, 40, 100, 100);
    labforname.textColor = [UIColor blackColor];
    [self.view addSubview:labforname];

}


-(void)textForName {
    UITextField *textforname = [UITextField new];
    textforname.frame = CGRectMake(115, 80, 110, 25);
    textforname.delegate = self;
    [textforname setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:textforname];

}


-(void)labelForSecondName {
    UILabel *labforname = [UILabel new];
    labforname.text = @"Фамилия:";
    labforname.frame = CGRectMake(30, 80, 100, 100);
    labforname.textColor = [UIColor blackColor];
    [self.view addSubview:labforname];

}


-(void)textForSecondName {
    UITextField *textforname = [UITextField new];
    textforname.frame = CGRectMake(115, 120, 110, 25);
    textforname.delegate = self;
    [textforname setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:textforname];
    
}


-(void)labelForThirdName {
    UILabel *labforname = [UILabel new];
    labforname.text = @"Отчество:";
    labforname.frame = CGRectMake(30, 120, 100, 100);
    labforname.textColor = [UIColor blackColor];
    [self.view addSubview:labforname];
    
}


-(void)textForThirdName {
    UITextField *textforname = [UITextField new];
    textforname.frame = CGRectMake(115, 160, 110, 25);
    textforname.delegate = self;
    [textforname setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:textforname];

}


-(void)labelForAddress {
    UILabel *labforname = [UILabel new];
    labforname.text = @"Адрес:";
    labforname.frame = CGRectMake(30, 180, 100, 100);
    labforname.textColor = [UIColor blackColor];
    [self.view addSubview:labforname];
    
}

-(void)textForAddress {
    UITextField *textforname = [UITextField new];
    textforname.frame = CGRectMake(115, 215, 110, 25);
    textforname.delegate = self;
    [textforname setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:textforname];
}

-(void)pay {
    UIButton *paynow = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [paynow setTitle:@"Оплатить"  forState:UIControlStateNormal];
    [paynow setTitleColor:[UIColor colorWithRed:250 green:250 blue:250 alpha:.77] forState:UIControlStateNormal];
    paynow.frame = CGRectMake(80.0, 350.0, 160.0, 40.0);
    paynow.layer.cornerRadius = 10;
   /* [paynow addTarget:self action:@selector(pushtopaycon)
     forControlEvents:UIControlEventTouchUpInside]; */
    paynow.backgroundColor = [UIColor blackColor];
    [self.view addSubview:paynow];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
