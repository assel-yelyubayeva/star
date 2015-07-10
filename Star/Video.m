//
//  Video.m
//  The star
//
//  Created by Assel Yelyubayeva on 05.07.15.
//  Copyright (c) 2015 Assel Yelyubayeva. All rights reserved.
//

#import "Video.h"
#import <Parse/Parse.h>
@implementation Video
-(instancetype) initWithFile: (PFFile *) videoFile andTitle: (NSString*) title andScreen:(PFFile*) screenFile andGenre:(NSString *)genre andTheatricalCharacter:(NSString *)tc andDescr:(NSString *)descr{
    self = [super init];
    if(self){
        NSData *screenData= [screenFile getData];
        self.screen= [UIImage imageWithData:screenData];
        self.title=title;
        self.videoFile=videoFile;
        self.genre=genre;
        self.theatricalCharacter=tc;
        self.descr=descr;
    }
    return self;
}
@end
