//
//  PhotoCollectionViewController.h
//  The star
//
//  Created by Assel Yelyubayeva on 03.07.15.
//  Copyright (c) 2015 Assel Yelyubayeva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCollectionViewController : UICollectionViewController
+(void)imageForPhoto: (NSDictionary *) photo size: (NSString *) size completion:(void(^)(UIImage *image)) completion;
@end
    