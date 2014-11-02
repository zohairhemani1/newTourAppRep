//
//  Sync.m
//  newTourApp
//
//  Created by Avialdo on 28/10/2014.
//  Copyright (c) 2014 Avialdo. All rights reserved.
//

#import "Sync.h"
#import "WebService.h"
#import "Constants.h"

@interface Sync ()
@end

static NSArray *result;

@implementation Sync

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.syncButton.layer.cornerRadius = 7;
    self.syncButton.clipsToBounds = YES;
    
    self.client_name.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"user_name"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)syncButtonPressed:(id)sender {
    
    [self.progressView setProgress:1.0 animated:YES];
    
    WebService *w = [[WebService alloc]init];
    //[w FilePathOfSendingImage:ADDIMAGE parameterOne:nil parameterTwo:@"1" parameterThree:@"2" parameterFour:@"buildinglobby"];
    
    [self performSegueWithIdentifier:@"showMaster" sender:self];
    
}
@end
