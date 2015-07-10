//
//  ImageCollectionViewCell.m
//  The star
//
//  Created by Assel Yelyubayeva on 03.07.15.
//  Copyright (c) 2015 Assel Yelyubayeva. All rights reserved.
//

#import "ImageCollectionViewCell.h"
#import "Photo.h"
@implementation ImageCollectionViewCell

-(void) layoutSubviews{
    [super layoutSubviews];
}
-(void) setPhoto:(Photo *)photo{
    _photo=photo;
    self.imageView.image=photo.image;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2;
    self.imageView.clipsToBounds = YES;
    self.textLabel.text=photo.title;
}
@end
