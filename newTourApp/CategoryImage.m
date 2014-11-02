//
//  CategoryImage.m
//  newTourApp
//
//  Created by Avialdo on 28/10/2014.
//  Copyright (c) 2014 Avialdo. All rights reserved.
//

#import "CategoryImage.h"

@interface CategoryImage (){
    NSArray *fixedButtons;
    UIButton *category_button;
}

@end

@implementation CategoryImage

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
    
    fixedButtons = [[NSArray alloc]initWithObjects:@"building images",@"building lobby",@"amenities",@"day care",@"path connection",@"public transit",@"parking",@"elevators",@"elevator lobby",@"suit entrance",@"condition of premises",@"views",@"IT room",@"frieght elevator",@"green aspects", nil];
    
    [self drawCategoryButtons];

}

-(void)drawCategoryButtons{
    int x=50;
    int y=90;
    
    for(int i=1;i<=[fixedButtons count];i++){
        
        category_button = [[UIButton alloc]initWithFrame:CGRectMake(x, y, 180, 50)];
        [category_button setTitle:[[fixedButtons objectAtIndex:i-1]capitalizedString]forState:normal];
        [category_button setTitleColor:[UIColor blackColor] forState:normal];
        [category_button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        category_button.layer.borderWidth = 1.0f;
        category_button.layer.borderColor = [UIColor grayColor].CGColor;
        
        if(self.selected_category == -1)
        {
            if(i==1)
            {
                [category_button setBackgroundColor:[UIColor grayColor]];
            }
        }
        else
        {
             if((i-1) == self.selected_category)
             {
                 [category_button setBackgroundColor:[UIColor grayColor]];
             }
        }
        
        category_button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        category_button.titleLabel.textAlignment = NSTextAlignmentCenter;
        category_button.tag = i-1;
        
        [self.view addSubview:category_button];
        
        x+=185;
        
        if(i%5 == 0){
            y+=60;
            x=50;
        }
    }
}

-(void)buttonClicked:(id)sender{
        
    [category_button setBackgroundColor:[UIColor whiteColor]];
    
    category_button = (UIButton *)sender;
    NSLog(@"Button clicked with tag %d", category_button.tag);
    
    [category_button setBackgroundColor:[UIColor grayColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
