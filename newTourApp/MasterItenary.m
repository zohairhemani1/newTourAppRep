//
//  MasterItenary.m
//  newTourApp
//
//  Created by Avialdo on 28/10/2014.
//  Copyright (c) 2014 Avialdo. All rights reserved.
//

#import "MasterItenary.h"
#import "WebService.h"
#import "Constants.h"
#import "Login.h"
#import "DetailItenary.h"

@interface MasterItenary (){
    NSArray *fixedProperties;
    NSArray *dataFields;
    UIScrollView *scroll;
    NSString *profilePic;
    NSString *imagePathString;
    NSURL *imagePathUrl;
    NSData *data;
   // UIImage *flat;
    UIActivityIndicatorView *image_loading;
    int number;
}

@end
static NSArray *result;
@implementation MasterItenary

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
    
    fixedProperties = [[NSArray alloc]initWithObjects:@"address",@"type",@"term",@"square footage",@"parking available",@"monthly parking rate",@"floorplan",@"asking net rate psf",@"additional rent psf",@"total rent psf",@"monthly cost", nil];
    
    dataFields = [[NSArray alloc]initWithObjects:@"property_name",@"type",@"term",@"sq_ft",@"parking",@"monthly_parking_rate",@"floor_plan",@"asking_net_psf",@"additional_rent_psf",@"total_rent_psf",@"monthly_cost", nil];
    
    
    [self generateFlatData];
    [self drawFixedPropertyValues];
    [self drawFlatData];
    [self drawImages];
    [self.view addSubview:scroll];
    
    self.client_name.text = [[Login getUserArray]valueForKey:@"user_name"];
    
    scroll.contentSize = CGSizeMake([result count]*180+500, 200);
    scroll.showsHorizontalScrollIndicator = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

-(void)drawFixedPropertyValues{
    
    int x=40;
    int y=370; // scroll starting y value + image size(200) + time size (30)
    
    for(int i=0;i<[fixedProperties count];i++){
        
        UIView *arrow_and_fixed_view = [[UIView alloc]initWithFrame:CGRectMake(x, y, 220, 35)];
        
        UIImageView *arrow_imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
        UIImage *arrow = [UIImage imageNamed:@"arrow"];
        
        arrow_imageView.image = arrow;
        
        UILabel *fixed_property_value = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 200, 30)];
        fixed_property_value.text = [@"  " stringByAppendingString:[[fixedProperties objectAtIndex:i]capitalizedString] ];
        fixed_property_value.textColor= [UIColor blackColor];
        
        [fixed_property_value setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17.f]];
        
        [arrow_and_fixed_view addSubview:fixed_property_value];
        [arrow_and_fixed_view addSubview:arrow_imageView];
        
        arrow_and_fixed_view.layer.borderWidth = 1.0f;
        arrow_and_fixed_view.layer.borderColor = [UIColor grayColor].CGColor;
        
        [self.view addSubview:arrow_and_fixed_view];
       
        y+=35;
    }
    
}

-(void)drawFlatData{

    CGRect rect=CGRectMake(260,140,[result count] * 180,([dataFields count]*50)+150);
    scroll = [[UIScrollView alloc] initWithFrame:rect];
    
    int x=0;
    int y=230;
    
    for(int i=0;i<[result count];i++){
        for(int j=0;j<[dataFields count];j++){
        
        UILabel *property_data = [[UILabel alloc]initWithFrame:CGRectMake(x, y, 180, 35)];

        property_data.text = [[[result valueForKey:[dataFields objectAtIndex:j]]objectAtIndex:i]capitalizedString];
                if([property_data.text isEqualToString:@""]){
                    property_data.text = @"No Data Available";
                }
            
        property_data.textAlignment = NSTextAlignmentCenter;
        property_data.textColor= [UIColor blackColor];
        property_data.layer.borderWidth = 1.0f;
        property_data.layer.borderColor = [UIColor grayColor].CGColor;
        
        [scroll addSubview:property_data];
        
        y+=35;
            
        }
        x+=180;
        y = 230;
    }
}


-(void)drawImages{
    
    int x=0;
    int y=0;
    
    for(int i=0;i<[result count];i++){
        
        UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(x, y, 180, 30)];
        
        time.text = [[result valueForKey:@"visit_time"]objectAtIndex:i];
        if([time.text isEqualToString:@""]){
            time.text = @"No Time Given";
        }
        time.textColor= [UIColor blackColor];
        time.textAlignment = NSTextAlignmentCenter;
        time.layer.borderWidth = 1.0f;
        time.layer.borderColor = [UIColor grayColor].CGColor;
        
        [scroll addSubview:time];
        
        image_loading = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(x+40,y+70,100,100)];
        [image_loading setBackgroundColor:[UIColor grayColor]];
        [image_loading setColor:[UIColor whiteColor]];
        [scroll addSubview:image_loading];
        
        [image_loading startAnimating];
        
        UIImageView *flat_imageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y+30, 180, 200)];
        profilePic = [[result valueForKey:@"property_path"] objectAtIndex:i];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ImageClicked:)];
        singleTap.numberOfTapsRequired = 1;
        [flat_imageView setUserInteractionEnabled:YES];
        [flat_imageView addGestureRecognizer:singleTap];
        
        imagePathString = [GETIMAGE stringByAppendingString:profilePic];
        NSLog(@"the image path is %@",imagePathString);
        imagePathUrl = [NSURL URLWithString:imagePathString];
        data = [[NSData alloc]initWithContentsOfURL:imagePathUrl];
        
        dispatch_queue_t myqueue = dispatch_queue_create("myqueue", NULL);
        dispatch_async(myqueue, ^(void) {
            
            
            UIImage *flat = [[UIImage alloc]initWithData:data];
            
            flat_imageView.layer.borderColor = [UIColor grayColor].CGColor;
            flat_imageView.layer.borderWidth = 1.0f;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                flat_imageView.image = flat;
                flat_imageView.tag = i;
                [scroll addSubview:flat_imageView];
                [image_loading stopAnimating];
            });
        });

        x+=180;
    }
}

-(void)ImageClicked:(id)sender{
    
    number = ((UIGestureRecognizer *)sender).view.tag;
    [self performSegueWithIdentifier:@"TimeForFlatDetail" sender:self];
    
}

-(void)generateFlatData{
    WebService *w = [[WebService alloc]init];
   // result = [w FilePath:LOGIN parameterOne:nil parameterTwo:nil parameterThree:[[Login getUserArray]valueForKey:@"user_id"]];
    result = [w FilePath:FLATDATA parameterOne:nil parameterTwo:nil parameterThree:@"4"];
}

+(NSArray *)getFlatData{
    return result;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailItenary *d = segue.destinationViewController;
    d.flat_number = number;
}

@end
