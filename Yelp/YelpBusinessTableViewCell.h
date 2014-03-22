//
//  YelpBusinessTableViewCell.h
//  Yelp
//
//  Created by Arpan Nanavati on 3/22/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YelpBusiness.h"

@interface YelpBusinessTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *businessName;
@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;

- (YelpBusinessTableViewCell *) setModel:(YelpBusiness *) business;

@end
