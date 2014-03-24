//
//  PriceTableViewCell.m
//  Yelp
//
//  Created by Arpan Nanavati on 3/23/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "PriceTableViewCell.h"

@implementation PriceTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - price table view cell methods

- (PriceTableViewCell *) priceSegments:(NSArray *) segments
{
   [self.priceSegments removeAllSegments];
    
    [segments enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        [self.priceSegments insertSegmentWithTitle:(NSString *)object atIndex:idx animated:NO];
        [self.priceSegments setWidth:70.0f forSegmentAtIndex:idx];
        [self.priceSegments setEnabled:YES forSegmentAtIndex:idx];
    }];
    
    self.priceSegments.selectedSegmentIndex = 2;
    [self.priceSegments addTarget:self
                           action:@selector(pickOne:)
                 forControlEvents:UIControlEventValueChanged];
    
    return self;
}

//Action method executes when user touches the button
-(void) pickOne:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(priceTableViewCellDidFinish:)]) {
        [self.delegate priceTableViewCellDidFinish:sender];
    }
}

@end
