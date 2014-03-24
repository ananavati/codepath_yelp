//
//  MainViewController.h
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import "YelpBusinessTableViewCell.h"
#import "YelpBusiness.h"
#import "SearchFilerViewController.h"

@interface MainViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIScrollViewDelegate, CLLocationManagerDelegate>

@property (strong) YelpBusinessTableViewCell *cellPrototype;

@property (strong, nonatomic) CLLocationManager *locationManager;

@end
