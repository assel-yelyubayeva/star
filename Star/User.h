//
//  User.h
//  The star
//
//  Created by Assel Yelyubayeva on 06.07.15.
//  Copyright (c) 2015 Assel Yelyubayeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface User : NSObject
@property (nonatomic) NSString *fullName;
@property (nonatomic) UIImage *avatar;
@property (nonatomic) NSString *userID;
-(instancetype) initWithFullName: (NSString*) fullName andAvatar:(UIImage*) avatar andUserID:(NSString*)userID;
@end
