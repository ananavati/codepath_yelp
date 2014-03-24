//
//  PriceTableViewCell.h
//  Yelp
//
//  Created by Arpan Nanavati on 3/23/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PriceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UISegmentedControl *priceSegments;

- (PriceTableViewCell *) priceSegments:(NSArray *) segments;
@end
