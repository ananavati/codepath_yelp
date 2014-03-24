//
//  GenericTableViewCell.m
//  Yelp
//
//  Created by Arpan Nanavati on 3/23/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "GenericUISliderTableViewCell.h"

@implementation GenericUISliderTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - slider table view cell methods

- (void) setupSliderCell:(NSString *) title
{
    [self.titleLabel setText:title];
}

@end
