//
//  SearchFilerViewController.h
//  Yelp
//
//  Created by Arpan Nanavati on 3/23/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PriceTableViewCell.h"
#import "GenericUISliderTableViewCell.h"

@class SearchFilerViewController;

@protocol SearchFilerViewControllerDelegate <NSObject>

@optional
- (void)addItemViewController:(SearchFilerViewController *)controller didFinishEnteringItem:(NSDictionary *)item;
@end


@interface SearchFilerViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, PriceTableViewCellDelegate>

@property (nonatomic, weak) id <SearchFilerViewControllerDelegate> delegate;

@end
