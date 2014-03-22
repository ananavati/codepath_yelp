//
//  ImageView.h
//  rotten_tomatoes
//
//  Created by Arpan Nanavati on 3/15/14.
//  Copyright (c) 2014 Arpan Nanavati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"

@interface ImageView : UIImageView

- (void)setImageWithURL:(NSString *)url
       placeholderImage:(UIImage *)placeholderImage
                success:(void (^)(BOOL cachedImage))success
                failure:(void (^)(void))failure;
@end
