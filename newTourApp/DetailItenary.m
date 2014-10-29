//
//  DetailItenary.m
//  newTourApp
//
//  Created by Avialdo on 28/10/2014.
//  Copyright (c) 2014 Avialdo. All rights reserved.
//

#import "DetailItenary.h"
#import "MasterItenary.h"

@interface DetailItenary (){
    NSArray *leftDataFields;
    NSArray *rightDataFields;
    NSArray *fixedProperties;
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
    
    leftDataFields = [[NSArray alloc]initWithObjects:@"building_images",@"building_lobby",@"amenities",@"sec_inf_day_care",@"path_connection",@"public_transit",@"sec_inf_parking",@"sec_inf_elevators",@"sec_inf_elevator_lobby",@"sec_inf_suit_entrance",@"sec_inf_condition_of_premises",@"sec_inf_views",@"sec_inf_IT_rooms",@"sec_inf_frieght_elevator",@"sec_inf_green_aspects", nil];
    
    fixedProperties = [[NSArray alloc]initWithObjects:@"address",@"type",@"term",@"square footage",@"parking available",@"monthly parking rate",@"floorplan",@"asking net rate psf",@"additional rent psf",@"total rent psf",@"monthly cost", nil];
    
    rightDataFields = [[NSArray alloc]initWithObjects:@"property_name",@"type",@"term",@"sq_ft",@"parking",@"monthly_parking_rate",@"floor_plan",@"asking_net_psf",@"additional_rent_psf",@"total_rent_psf",@"monthly_cost", nil];
    
    [self drawLeftData];
    [self drawRightData];
    [self drawFixedPropertyValues];
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

            UILabel *property_data = [[UILabel alloc]initWithFrame:CGRectMake(x, y, 170, 50)];
            
            property_data.text = [@"  " stringByAppendingString:[[[MasterItenary getFlatData] valueForKey:[leftDataFields objectAtIndex:i-1]]objectAtIndex:self.flat_number]];
            if([property_data.text isEqualToString:@"  "]){
                property_data.text = @"  No Data Available";
            }
            property_data.textColor= [UIColor blackColor];
            property_data.numberOfLines = 2;
            property_data.layer.borderWidth = 1.0f;
            property_data.layer.borderColor = [UIColor grayColor].CGColor;
            
            [self.view addSubview:property_data];
            
            y+=55;
        if(i %5 ==0){
            x+=185;
            y=400;
        }
            
        }
    
}

-(void)drawRightData{
    
    int x=800;
    int y=200;
    
    for(int i=0;i<[rightDataFields count];i++){
        
        UILabel *property_data = [[UILabel alloc]initWithFrame:CGRectMake(x, y, 200, 30)];
        
        property_data.text = [@"  " stringByAppendingString:[[[MasterItenary getFlatData] valueForKey:[rightDataFields objectAtIndex:i]]objectAtIndex:self.flat_number]];
        if([property_data.text isEqualToString:@"  "]){
            property_data.text = @"  No Data Available";
        }
        property_data.textColor= [UIColor blackColor];
        
        property_data.layer.borderWidth = 1.0f;
        property_data.layer.borderColor = [UIColor grayColor].CGColor;
        
        [self.view addSubview:property_data];
        
        y+=30;
        
    }
    
}

-(void)drawFixedPropertyValues{
    
    int x=600;
    int y=200;
    
    for(int i=0;i<[fixedProperties count];i++){
        
        UILabel *fixed_property_value = [[UILabel alloc]initWithFrame:CGRectMake(x, y, 200, 30)];
        fixed_property_value.text = [@"  " stringByAppendingString:[[fixedProperties objectAtIndex:i]capitalizedString]];
        fixed_property_value.textColor= [UIColor blackColor];
        [fixed_property_value setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17.f]];
        fixed_property_value.layer.borderWidth = 1.0f;
        fixed_property_value.layer.borderColor = [UIColor grayColor].CGColor;
        
        [self.view addSubview:fixed_property_value];
        
        y+=30;
    }
    
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
