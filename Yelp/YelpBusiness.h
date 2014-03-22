//
//  YelpBusiness.h
//  Yelp
//
//  Created by Arpan Nanavati on 3/22/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YelpBusiness : NSObject

@property (weak, nonatomic) NSString *name;

- (YelpBusiness *)initWithDictionary: (NSDictionary *) business;

@end
