//
//  ViewController.m
//  The star
//
//  Created by Assel Yelyubayeva on 02.07.15.
//  Copyright (c) 2015 Assel Yelyubayeva. All rights reserved.
//

#import "TalentProfileViewController.h"
#import <Parse/Parse.h>
#import "Talent.h"
#import "Photo.h"
#import "Video.h"
#import "ImageCollectionViewCell.h"
#import "VideoCollectionViewCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "DetailViewController.h"
@interface TalentProfileViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *lblfullName;
@property (weak, nonatomic) IBOutlet UILabel *lblInfo;
@property (weak, nonatomic) IBOutlet UITextView *txtSkills;
@property (weak, nonatomic) IBOutlet UITextView *txtLanguages;
@property (weak, nonatomic) IBOutlet UICollectionView *miniPhotoCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *videoCollectionView;
@property (nonatomic, strong) IBOutlet UICollectionViewFlowLayout *flowLayout;

@end

@implementation TalentProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.miniPhotoCollectionView.delegate=self;
    self.miniPhotoCollectionView.dataSource=self;
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [self.flowLayout setItemSize:CGSizeMake(77, 81)];
    [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.flowLayout.minimumInteritemSpacing = 2.0;
    [self.miniPhotoCollectionView setCollectionViewLayout:self.flowLayout];
    self.miniPhotoCollectionView.bounces = YES;
    [self.miniPhotoCollectionView setShowsHorizontalScrollIndicator:NO];
    [self.miniPhotoCollectionView setShowsVerticalScrollIndicator:NO];
    
    self.videoCollectionView.delegate=self;
    self.videoCollectionView.dataSource=self;
    [self downloadTalent];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if([collectionView isEqual:self.miniPhotoCollectionView]){
        return self.talent.photos.count;
    }else{
        return self.talent.videos.count;
    }
}
-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if([collectionView isEqual:self.miniPhotoCollectionView]){
        ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"miniPhotoCell" forIndexPath:indexPath];
        Photo *photo =  self.talent.photos[indexPath.item];
        [cell setPhoto:photo];
        return cell;
    }else{
        VideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"videoCell" forIndexPath:indexPath];
        Video *video = self.talent.videos[indexPath.item];
        [cell setVideo:video];
       // [cell playVideo];
        return cell;
    }
}
-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if([collectionView isEqual:self.miniPhotoCollectionView]){
        Photo *photo = self.talent.photos[indexPath.item];
        DetailViewController *vc =[DetailViewController new];
        vc.modalPresentationStyle=UIModalPresentationCustom;
        vc.photo=photo;
        [self presentViewController:vc animated:YES completion:nil];
    }else{
        VideoCollectionViewCell *cell = [self.videoCollectionView cellForItemAtIndexPath:indexPath];
        [cell playVideo];
    }
}
-(void) collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    if([collectionView isEqual:self.miniPhotoCollectionView]){

    }else{
        VideoCollectionViewCell *cell = [self.videoCollectionView cellForItemAtIndexPath:indexPath];
        [cell stopVideo];
    }
}
-(void) downloadTalent{
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    [query getObjectInBackgroundWithId:self.userID block:^(PFObject *user, NSError *error) {
        // Do something with the returned PFObject in the gameScore variable.
            NSString *tFullName= user[@"fullName"];
            
            PFFile *avatarFile= user[@"photo"];
            NSData *avatarData= [avatarFile getData];
            UIImage *tAvatar = [UIImage imageWithData:avatarData];
            __block NSNumber *tAge = [[NSNumber alloc] init];
            __block NSNumber *tHeight = [[NSNumber alloc]init];
            __block NSString *tCity = [[NSString alloc] init];
            __block NSString *tCountry = [[NSString alloc] init];
            __block NSString *tGender = [[NSString alloc] init];
            __block NSArray *tSkills = [[NSArray alloc]init];
            __block NSArray *tLanguages = [[NSArray alloc]init];
        
            PFQuery *queryTalent = [PFQuery queryWithClassName:@"Talent"];
            [queryTalent whereKey:@"userID" equalTo:self.userID];
            [queryTalent findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *errorTalent) {
                tAge=objects[0][@"age"];
                tHeight=objects[0][@"height"];
                tCity=objects[0][@"city"];
                tCountry=objects[0][@"country"];
                tGender=objects[0][@"gender"];
                tSkills= objects[0][@"skills"];
                tLanguages = objects[0][@"languages"];
   
                PFQuery *queryPhotos = [PFQuery queryWithClassName:@"Photo"];
                [queryPhotos whereKey:@"userID" equalTo:self.userID];
                [queryPhotos findObjectsInBackgroundWithBlock:^(NSArray *photos, NSError *errorPhoto) {
                    NSMutableArray *photosArray = [[NSMutableArray alloc] init];

                    for(int i=0; i<photos.count; i++){
                        Photo *p = [[Photo alloc] initWithFile:photos[i][@"file"] andTitle:photos[i][@"title"] ];
                        [photosArray addObject:p];
                    }
                    
                    PFQuery *queryVideos = [PFQuery queryWithClassName:@"Video"];
                    [queryVideos whereKey:@"userID" equalTo:self.userID];
                    [queryVideos findObjectsInBackgroundWithBlock:^(NSArray *videos, NSError *errorVideo) {
                        NSMutableArray *videosArray = [[NSMutableArray alloc] init];
                        
                        for(int i=0; i<videos.count; i++){
                            Video *v = [[Video alloc] initWithFile:videos[i][@"file"] andTitle:videos[i][@"title"] andScreen:videos[i][@"screen"] andGenre:videos[i][@"genre"] andTheatricalCharacter:videos[i][@"theatricalCharacter"] andDescr:videos[i][@"description"]];
                            [videosArray addObject:v];
                        }
                        self.talent=[[Talent alloc] initWithFullName:tFullName andAvatar:tAvatar andCity:tCity andCountry:tCountry andGender:tGender andAge:tAge andHeight:tHeight andSkills:tSkills andLanguages:tLanguages andPhotos:photosArray andVideos:videosArray];
                        [self setupTalent];
                    }];
                }];
            }];
 }];
}
-(void) setupTalent {
     self.lblfullName.text=self.talent.fullName;
    self.imageView.image=self.talent.avatar;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2;
    self.imageView.clipsToBounds = YES;
    
    NSMutableString *info = [NSMutableString string];
    
    NSNumber *ageN =self.talent.age;
    NSString *age = [NSString stringWithFormat:@"%@", ageN];
    [info appendString: age];
    [info appendString:@" years old, "];
    NSNumber *heightN =self.talent.height;
    NSString *height = [NSString stringWithFormat:@"%@", heightN];
    [info appendString:height];
    [info appendString:@" cm, "];
    [info appendString:self.talent.city];
    [info appendString:@", "];
    [info appendString:self.talent.country];
    self.lblInfo.text=info;
    
    NSMutableString *skillsStr = [NSMutableString string];
    [skillsStr appendString:@"I can \n"];
    for(int i=0; i<self.talent.skills.count; i++){
        [skillsStr appendString:self.talent.skills[i]];
        [skillsStr appendString:@"\n"];
    }
    self.txtSkills.text=skillsStr;
    
    NSMutableString *langStr = [NSMutableString string];
    [langStr appendString:@"I speak \n"];
    for(int i=0; i<self.talent.languages.count; i++){
        [langStr appendString:self.talent.languages[i]];
        [langStr appendString:@"\n"];
    }
    self.txtLanguages.text=langStr;
    [self.miniPhotoCollectionView reloadData];
    [self.videoCollectionView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
