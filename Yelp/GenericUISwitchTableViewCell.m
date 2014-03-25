//
//  GenericTableViewCell.m
//  Yelp
//
//  Created by Arpan Nanavati on 3/23/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "GenericUISwitchTableViewCell.h"

@implementation GenericUISwitchTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    [self.onoffSwitch addTarget:self action: @selector(flip:) forControlEvents:UIControlEventValueChanged];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - slider table view cell methods

- (void) setupSwitchCell:(NSString *)title key:(NSString *)switchIdentifier
{
    [self.titleLabel setText:title];
    [self setSwitchIdentifier:switchIdentifier];
}

- (void) flip:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(switchFlipped:key:)]) {
        [self.delegate switchFlipped:sender key:self.switchIdentifier];
    }
    
//    if (self.onoffSwitch.on) NSLog(@"On");
//    else  NSLog(@"Off");
}
@end
