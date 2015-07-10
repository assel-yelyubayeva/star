//
//  VideoCollectionViewCell.m
//  The star
//
//  Created by Assel Yelyubayeva on 05.07.15.
//  Copyright (c) 2015 Assel Yelyubayeva. All rights reserved.
//

#import "VideoCollectionViewCell.h"
#import "Video.h"
#import <AVFoundation/AVFoundation.h>
@implementation VideoCollectionViewCell

-(void) layoutSubviews{
    [super layoutSubviews];
}
-(void) setVideo:(Video *)video{
    _video=video;
    UIImageView *imageView = [[UIImageView alloc] init];
    NSURL *url = [NSURL URLWithString:self.video.videoFile.url];
    imageView.image=[self thumbnailFromVideoAtURL:url];
    [imageView setFrame:CGRectMake (0, 0, 338, 250)];
    [imageView setBackgroundColor: [UIColor blackColor]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imageView];
    [self addSubview:[self setupTextView]];
}
- (void) playVideo{
    NSURL *url = [NSURL URLWithString:self.video.videoFile.url];
    MPMoviePlayerController *controller =[[MPMoviePlayerController alloc] initWithContentURL:url];
    self.videoController  =controller;
    [self.videoController.view setFrame:CGRectMake (0, 0, 338, 250)];
    [self.videoController.view addSubview:[self setupTextView]];
    [self addSubview:[self.videoController view]];
    [self.videoController play];
}
-(UIImage *)thumbnailFromVideoAtURL:(NSURL *)contentURL {
    UIImage *theImage = nil;
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:contentURL options:nil];
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generator.appliesPreferredTrackTransform = YES;
    NSError *err = NULL;
    CMTime time = CMTimeMake(11, 1);
    CGImageRef imgRef = [generator copyCGImageAtTime:time actualTime:NULL error:&err];
    theImage = [[UIImage alloc] initWithCGImage:imgRef];
    CGImageRelease(imgRef);
    return theImage;
}
-(UITextView*) setupTextView{
    NSMutableString *str = [NSMutableString string];
    [str appendString:self.video.title];
    [str appendString:@"\n"];
    [str appendString:self.video.genre];
    [str appendString:@": "];
    [str appendString:self.video.theatricalCharacter];
    [str appendString:@"\n"];
    [str appendString:self.video.descr];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange boldedRange = NSMakeRange(0, self.video.title.length);
    NSRange allRange = NSMakeRange(0, attrString.length);
    [attrString beginEditing];
    [attrString addAttribute:NSFontAttributeName
                       value:[UIFont fontWithName:@"Helvetica" size:15.0]
                       range:allRange];
    [attrString addAttribute:NSFontAttributeName
                       value:[UIFont fontWithName:@"Helvetica-Bold" size:18.0]
                       range:boldedRange];
    [attrString endEditing];
    UITextView *textView = [[UITextView alloc] init];
    textView.attributedText=attrString;
    textView.editable=NO;
    textView.scrollEnabled=YES;
    [textView setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    [textView setFrame:CGRectMake (0, 0, 338, 46)];
    return textView;
}
- (void) stopVideo{
    [self.videoController stop];
}
@end
