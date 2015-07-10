//
//  TalentsTableViewCell.h
//  The star
//
//  Created by Assel Yelyubayeva on 06.07.15.
//  Copyright (c) 2015 Assel Yelyubayeva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TalentsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;
-(void) setImage: (UIImage*) image andTitle:(NSString*) title;
@end
