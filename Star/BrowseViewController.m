//
//  ViewController.m
//  Star
//
//  Created by Assel Yelyubayeva on 09.07.15.
//  Copyright (c) 2015 Assel Yelyubayeva. All rights reserved.
//

#import "BrowseViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>
@interface BrowseViewController ()
@property (weak, nonatomic) IBOutlet UILabel *welcomelabel;

@end

@implementation BrowseViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([PFUser currentUser]) {
        self.welcomelabel.text = [NSString stringWithFormat:NSLocalizedString(@"Welcome %@!", nil), [[PFUser currentUser] username]];
    } else {
        self.welcomelabel.text = NSLocalizedString(@"Not logged in", nil);
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
