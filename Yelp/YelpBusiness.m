//
//  YelpBusiness.m
//  Yelp
//
//  Created by Arpan Nanavati on 3/22/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "YelpBusiness.h"

@interface YelpBusiness ()

@property NSDictionary *business;
@property NSArray *categories;

@end

@implementation YelpBusiness

- (YelpBusiness *)initWithDictionary:(NSDictionary *)business
{
    self = [super init];
    
	if (self) {
		[self setName:business[@"name"]];
        [self setImageUrl:business[@"image_url"]];
        [self setRatingImageUrl:business[@"rating_img_url_small"]];
        [self setReviewsCount:[business[@"review_count"] intValue]];
        [self setAddress:business[@"location"][@"address"][0]];
        
        self.categories = business[@"categories"];
	}
    
	return self;
}

- (NSString *) categoriesText
{
	return [self.categories[0] componentsJoinedByString:@", "];
}


@end
