//
//  ViewController.m
//  newTourApp
//
//  Created by Avialdo on 28/10/2014.
//  Copyright (c) 2014 Avialdo. All rights reserved.
//

#import "Login.h"
#import "WebService.h"
#import "Constants.h"

@interface Login (){
    
}
@end

static NSArray *result;

@implementation Login{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.username.delegate = self;
    self.password.delegate = self;
    
    self.loginButton.layer.cornerRadius = 7;
    self.loginButton.clipsToBounds = YES;
    
    self.cancelButton.layer.cornerRadius = 7;
    self.cancelButton.clipsToBounds = YES;
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)LoginButtonPressed:(id)sender {
    
    WebService *w = [[WebService alloc]init];
    result = [w FilePath:LOGIN parameterOne:self.username.text parameterTwo:self.password.text];
    
    if([result valueForKey:@"user_email"] !=nil ){
    
        [self performSegueWithIdentifier:@"StartLoginProcess" sender:self];
    }
    
}

- (IBAction)cancelButtonPressed:(id)sender {
    
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationBeginsFromCurrentState:YES];
	self.LoginView.frame = CGRectMake(self.LoginView.frame.origin.x + 200.0, self.LoginView.frame.origin.y, self.LoginView.frame.size.width, self.LoginView.frame.size.height);
	[UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationBeginsFromCurrentState:YES];
	self.LoginView.frame = CGRectMake(self.LoginView.frame.origin.x - 200.0, self.LoginView.frame.origin.y , self.LoginView.frame.size.width, self.LoginView.frame.size.height);
	[UIView commitAnimations];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

+(NSArray *)getUserArray{

    return result;
    
}
@end
