//
//  DetailItenary.m
//  newTourApp
//
//  Created by Avialdo on 28/10/2014.
//  Copyright (c) 2014 Avialdo. All rights reserved.
//

#import "DetailItenary.h"
#import "MasterItenary.h"
#import "Constants.h"
#import "SavingImage.h"

@interface DetailItenary (){
    NSArray *leftDataFields;
    NSArray *rightDataFields;
    NSArray *fixedProperties;
    UIView *rightDataView;
    NSString *profilePic;
    NSString *imagePathString;
    NSURL *imagePathUrl;
    NSData *data;
    UIImage *flat;
    UIActivityIndicatorView *image_loading;
    UIImage *uploadedimage;
}

@end

@implementation DetailItenary

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
    
    leftDataFields = [[NSArray alloc]initWithObjects:@"building images",@"building lobby",@"amenities",@"day care",@"path connection",@"public transit",@"parking",@"elevators",@"elevator lobby",@"suit entrance",@"condition of premises",@"views",@"IT room",@"frieght elevator",@"green aspects", nil];
    
    fixedProperties = [[NSArray alloc]initWithObjects:@"address",@"type",@"term",@"square footage",@"parking available",@"monthly parking rate",@"floorplan",@"asking net rate psf",@"additional rent psf",@"total rent psf",@"monthly cost", nil];
    
    rightDataFields = [[NSArray alloc]initWithObjects:@"property_name",@"type",@"term",@"sq_ft",@"parking",@"monthly_parking_rate",@"floor_plan",@"asking_net_psf",@"additional_rent_psf",@"total_rent_psf",@"monthly_cost", nil];
    
    [self drawLeftData];
    [self drawFixedPropertyValues];
    [self drawRightData];
    [self.view addSubview:rightDataView];
    [self drawFlatImage];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)drawLeftData{

    int x=30;
    int y=400;
    
    for(int i=1;i<=[leftDataFields count];i++){

        UIButton *category_button = [[UIButton alloc]initWithFrame:CGRectMake(x, y, 170, 50)];
            
        category_button = [[UIButton alloc]initWithFrame:CGRectMake(x, y, 180, 55)];
        [category_button setTitle:[[leftDataFields objectAtIndex:i-1]capitalizedString]forState:normal];
        [category_button setTitleColor:[UIColor blackColor] forState:normal];
        [category_button addTarget:self action:@selector(categoryButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        category_button.layer.borderWidth = 1.0f;
        category_button.layer.borderColor = [UIColor blackColor].CGColor;
        
        category_button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        category_button.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            [self.view addSubview:category_button];
            
            y+=55;
            if(i%5 ==0)
            {
                x+=185;
                y=400;
            }
            
        }
    
}

-(void)drawRightData{
    
    int x=200;
    int y=0;
    
    for(int i=0;i<[rightDataFields count];i++){
        
        UILabel *property_data = [[UILabel alloc]initWithFrame:CGRectMake(x, y, 200, 35)];
        
        property_data.text = [[@"  " stringByAppendingString:[[[MasterItenary getFlatData] valueForKey:[rightDataFields objectAtIndex:i]]objectAtIndex:self.flat_number]]capitalizedString];
        if([property_data.text isEqualToString:@"  "]){
            property_data.text = @"  No Data Available";
        }
        property_data.textColor= [UIColor blackColor];
        
        property_data.layer.borderWidth = 1.0f;
        property_data.layer.borderColor = [UIColor grayColor].CGColor;
        
        [rightDataView addSubview:property_data];
        
        y+=35;
        
    }
    
    rightDataView.layer.borderWidth = 2.0f;
    rightDataView.layer.borderColor = [UIColor blackColor].CGColor;
    
}

-(void)drawFixedPropertyValues{
    
    rightDataView = [[UIView alloc]initWithFrame:CGRectMake(600, 285, 400, [rightDataFields count]*35)];
    
    int x=0;
    int y=0;
    
    for(int i=0;i<[fixedProperties count];i++){
        
        UILabel *fixed_property_value = [[UILabel alloc]initWithFrame:CGRectMake(x, y, 200, 35)];
        fixed_property_value.text = [@"  " stringByAppendingString:[[fixedProperties objectAtIndex:i]capitalizedString]];
        fixed_property_value.textColor= [UIColor blackColor];
        [fixed_property_value setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17.f]];
        fixed_property_value.layer.borderWidth = 1.0f;
        fixed_property_value.layer.borderColor = [UIColor grayColor].CGColor;
        
        [rightDataView addSubview:fixed_property_value];
        
        y+=35;
    }
    
}

-(void)drawFlatImage{
    image_loading = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(self.flat_image.bounds.origin.x+50,self.flat_image.bounds.origin.y+200,100,100)];
    [image_loading setBackgroundColor:[UIColor grayColor]];
    [image_loading setColor:[UIColor whiteColor]];
    [self.view addSubview:image_loading];
    
    [image_loading startAnimating];
    
    
    profilePic = [[[MasterItenary getFlatData] valueForKey:@"property_path"] objectAtIndex:self.flat_number];

    
    imagePathString = GETIMAGE;
    imagePathString = [imagePathString stringByAppendingString:profilePic];
    imagePathUrl = [NSURL URLWithString:imagePathString];
    
    dispatch_queue_t myqueue = dispatch_queue_create("myqueue", NULL);
    dispatch_async(myqueue, ^(void) {
        
        data = [[NSData alloc]initWithContentsOfURL:imagePathUrl];
        flat = [[UIImage alloc]initWithData:data];

        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.flat_image.image = flat;
            [self.view addSubview:self.flat_image];
            [image_loading stopAnimating];
        });
    });
}

- (IBAction)cameraButtonPressed:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"What do you want to do?"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Camera", @"Photos", nil];
    
    [actionSheet showInView:self.view];
    
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Camera"]) {
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Photos"]) {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    else{
        return;
    }
    [self presentViewController:picker animated:YES completion:nil];

}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    uploadedimage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    [self performSegueWithIdentifier:@"ImageTaken" sender:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ImageTaken"])
    {
     SavingImage *s = segue.destinationViewController;
     s.image_from_previous_screen = uploadedimage;
    }
    
    else if ([segue.identifier isEqualToString:@"categoryDetail"])
    {
        
    }

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

-(void)categoryButtonClicked:(id)sender{
    
    NSLog(@"Button Clicked");
    [self performSegueWithIdentifier:@"categoryDetail" sender:self];
}

@end
