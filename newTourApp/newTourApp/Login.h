//
//  ViewController.h
//  newTourApp
//
//  Created by Avialdo on 28/10/2014.
//  Copyright (c) 2014 Avialdo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Login : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
- (IBAction)LoginButtonPressed:(id)sender;

- (IBAction)cancelButtonPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *LoginView;

+(NSArray *)getUserArray;

@end
