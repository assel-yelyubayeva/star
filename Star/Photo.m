//
//  Photo.m
//  The star
//
//  Created by Assel Yelyubayeva on 03.07.15.
//  Copyright (c) 2015 Assel Yelyubayeva. All rights reserved.
//

#import "Photo.h"
#import <Parse/Parse.h>
@implementation Photo
-(instancetype) initWithFile:(PFFile *)file andTitle:(NSString *)title{
    self = [super init];
    if(self){
        NSData *photoData= [file getData];
        self.image= [UIImage imageWithData:photoData];
        self.title=title;
    }
    return self;
}

@end
