//
//  TalentsTableViewCell.m
//  The star
//
//  Created by Assel Yelyubayeva on 06.07.15.
//  Copyright (c) 2015 Assel Yelyubayeva. All rights reserved.
//

#import "TalentsTableViewCell.h"

@implementation TalentsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) setImage:(UIImage *)image andTitle:(NSString *)title{
    self.imageView.image=image;
    self.label.text=title;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2;
    self.imageView.clipsToBounds = YES;
}
@end
