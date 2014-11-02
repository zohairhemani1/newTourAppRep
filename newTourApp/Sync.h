//
//  Sync.h
//  newTourApp
//
//  Created by Avialdo on 28/10/2014.
//  Copyright (c) 2014 Avialdo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Sync : UIViewController
- (IBAction)syncButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *syncButton;
@property (weak, nonatomic) IBOutlet UILabel *client_name;

@end
