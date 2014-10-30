//
//  SavingImage.h
//  newTourApp
//
//  Created by Avialdo on 28/10/2014.
//  Copyright (c) 2014 Avialdo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SavingImage : UIViewController<UITextViewDelegate>

@property (weak,nonatomic) UIImage *image_from_previous_screen;
@property (weak, nonatomic) IBOutlet UIImageView *captured_image;
@property (weak, nonatomic) IBOutlet UITextView *commentsView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
- (IBAction)saveButtonPressed:(id)sender;

@end
