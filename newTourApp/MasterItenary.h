//
//  MasterItenary.h
//  newTourApp
//
//  Created by Avialdo on 28/10/2014.
//  Copyright (c) 2014 Avialdo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterItenary : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *client_name;

+(NSArray *)getFlatData;
@end
