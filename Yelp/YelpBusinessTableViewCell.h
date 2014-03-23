//
//  YelpBusinessTableViewCell.h
//  Yelp
//
//  Created by Arpan Nanavati on 3/22/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>

#import "YelpBusiness.h"

@interface YelpBusinessTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *yelpImageView;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImageView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *dollarValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewCountLabel;


- (YelpBusinessTableViewCell *) setModel:(YelpBusiness *) business;

@end
