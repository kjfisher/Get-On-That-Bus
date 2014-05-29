//
//  BusStopDetailViewController.m
//  GetOnThatBus
//
//  Created by Kristen L. Fisher on 5/28/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "BusStopDetailViewController.h"

@interface BusStopDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *busRoutesLabel;
@property (weak, nonatomic) IBOutlet UILabel *transfersLabel;

@end

@implementation BusStopDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.addressLabel.text = [NSString stringWithFormat:@"Web Address %@",[self.passedDictionary objectForKey:@"_address"]];
    self.busRoutesLabel.text = [NSString stringWithFormat:@"Bus Routes %@",[self.passedDictionary objectForKey:@"routes"]];
    self.transfersLabel.text = [NSString stringWithFormat:@"Transfer %@",[self.passedDictionary objectForKey:@"inter_modal"]];
    self.title = [self.passedDictionary objectForKey:@"cta_stop_name"];
}

@end
