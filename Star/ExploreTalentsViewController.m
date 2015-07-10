//
//  ExploreTalentsViewController.m
//  The star
//
//  Created by Assel Yelyubayeva on 06.07.15.
//  Copyright (c) 2015 Assel Yelyubayeva. All rights reserved.
//

#import "ExploreTalentsViewController.h"
#import <Parse/Parse.h>
#import "User.h"
#import "Photo.h"
#import "TalentProfileViewController.h"
#import "TalentsTableViewCell.h"
@interface ExploreTalentsViewController ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *curUsers;
@property (nonatomic) NSInteger curUser;

@end

@implementation ExploreTalentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchTextField.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    //[self getTalentsFromParse];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField != self.searchTextField) {
        return YES;
    }else{
     //   [self getTalentsFromParse];
        return NO;
    }
 
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.curUsers count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TalentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell" forIndexPath:indexPath];
    User *user =self.curUsers[indexPath.row];
    //[cell setImage:user.avatar andTitle:user.fullName];
    return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.curUser=indexPath.row;
    [self performSegueWithIdentifier:@"showTalentSegue" sender:self];
}
/*
-(void) getTalentsFromParse{
    NSLog(@"GET TALENTS....");
    NSMutableArray *users = [[NSMutableArray alloc] init];
    PFQuery *talentQuery = [PFQuery queryWithClassName:@"User"];
    [talentQuery whereKey:@"fullName" containsString:self.searchTextField.text];
    [talentQuery whereKey:@"type" equalTo:@"talent"];
    talentQuery.limit=30;
    [talentQuery findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        for(int i=0; i<results.count; i++){
            PFObject *object = results[i];
            Photo *photo  =[[Photo alloc] initWithFile:object[@"photo"] andTitle:object[@"fullName"]];
            User *user = [[User alloc] initWithFullName:object[@"fullName"] andAvatar:photo.image andUserID:object.objectId];
            [users addObject:user];
        }
        self.curUsers=users;
        [self.tableView reloadData];
    }];

}*/

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"showTalentSegue"]){
        TalentProfileViewController *nextVC = [segue destinationViewController];
        User *user = self.curUsers[self.curUser];
     //   nextVC.userID=user.userID;
    }

}


@end
