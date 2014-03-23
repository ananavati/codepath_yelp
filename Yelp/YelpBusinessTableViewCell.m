//
//  YelpBusinessTableViewCell.m
//  Yelp
//
//  Created by Arpan Nanavati on 3/22/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "YelpBusinessTableViewCell.h"

@implementation YelpBusinessTableViewCell

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

- (void) getImage:(NSString *) imageUrl imagetype:(NSString *) imageType
{
    NSURL *URL = [NSURL URLWithString:imageUrl];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:URL];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([imageType  isEqual: @"yelp"])
        {
            self.yelpImageView.image = responseObject;
        }
        else
        {
            self.ratingImageView.image = responseObject;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Image error: %@", error);
    }];
    
    [requestOperation start];
}

- (YelpBusinessTableViewCell *) setModel:(YelpBusiness *) business
{
    [self.name setText:business.name];
    [self getImage:business.imageUrl imagetype:@"yelp"];
    [self getImage:business.ratingImageUrl imagetype:@"rating"];
    [self.reviewCountLabel setText:[NSString stringWithFormat:@"%d Reviews", business.reviewsCount]];
    [self.addressLabel setText:business.address];
    [self.categoryLabel setText:business.categoriesText];
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
