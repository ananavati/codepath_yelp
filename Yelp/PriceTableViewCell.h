//
//  PriceTableViewCell.h
//  Yelp
//
//  Created by Arpan Nanavati on 3/23/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PriceTableViewCellDelegate;

@interface PriceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UISegmentedControl *priceSegments;

@property  (nonatomic, weak) id <PriceTableViewCellDelegate> delegate;

- (PriceTableViewCell *) priceSegments:(NSArray *) segments;
@end

@protocol PriceTableViewCellDelegate <NSObject>

- (void) priceTableViewCellDidFinish:(id)sender;

@optional
-(void)optionalDelegateMethodOne;

@end


