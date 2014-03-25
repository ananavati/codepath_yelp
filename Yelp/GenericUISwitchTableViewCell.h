//
//  GenericTableViewCell.h
//  Yelp
//
//  Created by Arpan Nanavati on 3/23/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GenericUISwitchTableViewCellDelegate;

@interface GenericUISwitchTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *onoffSwitch;

@property  (nonatomic, weak) id <GenericUISwitchTableViewCellDelegate> delegate;
@property (weak, nonatomic) NSString *switchIdentifier;

- (void) setupSwitchCell:(NSString *)title key:(NSString *)switchIdentifier;
@end

@protocol GenericUISwitchTableViewCellDelegate <NSObject>

- (void) switchFlipped:(id)sender key:(NSString *)key;

@end