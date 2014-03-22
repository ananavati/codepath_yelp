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

@end

@implementation YelpBusiness

- (YelpBusiness *)initWithDictionary:(NSDictionary *)business
{
    self = [super init];
    
	if (self) {
		self.business = business;
        
		[self setName:self.business[@"name"]];
//		[self setSynopsis:self.movie[@"synopsis"]];
//		[self setThumbUrl:self.movie[@"posters"][@"profile"]];
//		[self setPosterUrl:self.movie[@"posters"][@"original"]];
//        
//		self.castMembers = [[NSMutableArray alloc] init];
//		for (NSDictionary *cast in self.movie[@"abridged_cast"]) {
//			[self.castMembers addObject:cast[@"name"]];
//		}
	}
    
	return self;
}

@end
