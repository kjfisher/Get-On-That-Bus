//
//  ViewController.m
//  GetOnThatBus
//
//  Created by Kristen L. Fisher on 5/28/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "BusStopDetailViewController.h"

@interface ViewController () <MKMapViewDelegate>
@property NSArray *busStopArray;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/mobile-makers-lib/bus.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:NSJSONReadingAllowFragments
                                                                     error:&connectionError];
        self.busStopArray = [dictionary objectForKey:@"row"];
        //NSLog(@"%@", self.busStopArray);
        [self busStopPinsCreator];

    }];
}

-(void)busStopPinsCreator
{
    for (NSDictionary *dictionary in self.busStopArray)
    {
        NSString *longitude = [dictionary objectForKey:@"longitude"];
        NSString *latitude = [dictionary objectForKey:@"latitude"];
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = CLLocationCoordinate2DMake([latitude floatValue], [longitude floatValue]);
        point.title = [dictionary objectForKey:@"cta_stop_name"];
        point.subtitle = [dictionary objectForKey:@"routes"];

        [self.mapView addAnnotation:point];
        self.busStopAnnotation = point;
        NSLog(@"%@",longitude);
    }
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];

        pin.canShowCallout = YES;
        pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];

        return pin;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"%@", view.title);
    [self performSegueWithIdentifier:@"detailSegue" sender:view];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    BusStopDetailViewController *detailVC = [[BusStopDetailViewController alloc] init];
    detailVC.passedDictionary = self.selectedDictionary;

}





@end
