//
//  Video.h
//  The star
//
//  Created by Assel Yelyubayeva on 05.07.15.
//  Copyright (c) 2015 Assel Yelyubayeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface Video : NSObject
@property (nonatomic, strong) UIImage *screen;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *genre;
@property (nonatomic, strong) NSString *descr;
@property (nonatomic, strong) NSString *theatricalCharacter;
@property (nonatomic, strong) PFFile *videoFile;
-(instancetype) initWithFile: (PFFile *) videoFile andTitle: (NSString*) title andScreen:(PFFile*) screenFile andGenre:(NSString*) genre andTheatricalCharacter:(NSString*) tc andDescr: (NSString*) descr;
@end
