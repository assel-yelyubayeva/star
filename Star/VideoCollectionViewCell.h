//
//  VideoCollectionViewCell.h
//  The star
//
//  Created by Assel Yelyubayeva on 05.07.15.
//  Copyright (c) 2015 Assel Yelyubayeva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Video.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
@interface VideoCollectionViewCell : UICollectionViewCell
@property (nonatomic) Video *video;
@property (strong, nonatomic) MPMoviePlayerController *videoController;
-(void) playVideo;
-(void) stopVideo;
@end
