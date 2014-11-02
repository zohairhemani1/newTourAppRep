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
#import "DBManager.h"

@interface Login ()
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
        
        [[NSUserDefaults standardUserDefaults ] setObject:[result valueForKey:@"user_email"] forKey:@"user_email"];
        [[NSUserDefaults standardUserDefaults ] setObject:[result valueForKey:@"user_id"] forKey:@"user_id"];
        [[NSUserDefaults standardUserDefaults ] setObject:[result valueForKey:@"user_name"] forKey:@"user_name"];
        [[NSUserDefaults standardUserDefaults ] setObject:[result valueForKey:@"user_status"] forKey:@"user_status"];
    
        [self performSegueWithIdentifier:@"StartLoginProcess" sender:self];
        
//        [[DBManager getSharedInstance]saveData:@"img.name"comments:@"I love this image" category:@"Bathroom1" userID:@"2" isSync:1];
//        
//        [[DBManager getSharedInstance]saveData:@"img1.name"comments:@"I love this image" category:@"Bathroom1" userID:@"2" isSync:1];
//        
//        [[DBManager getSharedInstance]saveData:@"img2.name"comments:@"I love this image" category:@"Bathroom2" userID:@"3" isSync:1];
//        
//        [[DBManager getSharedInstance]saveData:@"img3.name"comments:@"I love this image" category:@"Bathroom2" userID:@"3" isSync:1];
    }
    
}

- (IBAction)cancelButtonPressed:(id)sender {
    
    //[[DBManager getSharedInstance]findByUserID:@"3"Sync:-1 Category:nil];
    
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
