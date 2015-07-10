//
//  Talent.m
//  The star
//
//  Created by Assel Yelyubayeva on 03.07.15.
//  Copyright (c) 2015 Assel Yelyubayeva. All rights reserved.
//

#import "Talent.h"

@implementation Talent
-(instancetype)initWithFullName:(NSString *)fullName andAvatar:(UIImage *)avatar andCity:(NSString *)city andCountry:(NSString *)country andGender:(NSString *)gender andAge:(NSNumber *)age andHeight:(NSNumber *)height andSkills:(NSArray *)skills andLanguages:(NSArray *)languages andPhotos:(NSMutableArray *)photos andVideos:(NSMutableArray *)videos{
    self = [super init];
    if(self) {
        self.fullName=fullName;
        self.avatar=avatar;
        self.city=city;
        self.gender=gender;
        self.age=age;
        self.height=height;
        self.skills=skills;
        self.languages=languages;
        self.photos=photos;
        self.videos=videos;
        self.country=country;
    }
    return self;
}
@end
