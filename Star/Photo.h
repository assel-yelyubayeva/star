//
//  Photo.h
//  The star
//
//  Created by Assel Yelyubayeva on 03.07.15.
//  Copyright (c) 2015 Assel Yelyubayeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface Photo : NSObject
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *title;
-(instancetype) initWithFile: (PFFile *) file andTitle: (NSString*) title;
@end
