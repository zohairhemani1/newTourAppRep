//
//  SavingImage.m
//  newTourApp
//
//  Created by Avialdo on 28/10/2014.
//  Copyright (c) 2014 Avialdo. All rights reserved.
//

#import "SavingImage.h"

@interface SavingImage (){
    NSArray *fixedButtons;
    UIButton *category_button;
}

@end

@implementation SavingImage

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
    
    self.captured_image.image = self.image_from_previous_screen;
    
    fixedButtons = [[NSArray alloc]initWithObjects:@"building images",@"building lobby",@"amenities",@"day care",@"path connection",@"public transit",@"parking",@"elevators",@"elevator lobby",@"suit entrance",@"condition of premises",@"views",@"IT room",@"frieght elevator",@"green aspects", nil];
    
    [self drawCategoryButtons];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)drawCategoryButtons{
    int x=450;
    int y=200;
    
    for(int i=1;i<=[fixedButtons count];i++){
        
        category_button = [[UIButton alloc]initWithFrame:CGRectMake(x, y, 180, 55)];
        [category_button setTitle:[[fixedButtons objectAtIndex:i-1]capitalizedString]forState:normal];
        [category_button setTitleColor:[UIColor blackColor] forState:normal];
        [category_button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        category_button.layer.borderWidth = 1.0f;
        category_button.layer.borderColor = [UIColor grayColor].CGColor;

        category_button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        category_button.titleLabel.textAlignment = NSTextAlignmentCenter;
        category_button.tag = i-1;
        
        [self.view addSubview:category_button];
        y+=60;
        if(i %5 ==0){
            x+=185;
            y=200;
        }
    }
}

-(void)buttonClicked:(id)sender{
    
    category_button = (UIButton *)sender;
    NSLog(@"Button clicked with tag %d", category_button.tag);
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
