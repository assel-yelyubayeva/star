//
//  User.m
//  The star
//
//  Created by Assel Yelyubayeva on 06.07.15.
//  Copyright (c) 2015 Assel Yelyubayeva. All rights reserved.
//

#import "User.h"

@implementation User
-(instancetype) initWithFullName:(NSString *)fullName andAvatar:(UIImage *)avatar andUserID:(NSString *)userID{
    self = [super init];
    if(self) {
        self.fullName=fullName;
        self.avatar=avatar;
        self.userID=userID;
    }
    return self;
}
@end
