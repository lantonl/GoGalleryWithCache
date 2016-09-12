//
//  galleryDescriptionViewController.m
//  GoGallery
//
//  Created by Anton A on 29.08.16.
//  Copyright © 2016 goit. All rights reserved.
//

#import "galleryDescriptionViewController.h"

@interface galleryDescriptionViewController ()

@property (weak, nonatomic) IBOutlet UITableViewCell   *timeCell;
@property (weak, nonatomic) IBOutlet UITableViewCell   *mapPointerCell;
@property (weak, nonatomic) IBOutlet UITableViewCell   *phoneCell;
@property (weak, nonatomic) IBOutlet UITableViewCell   *linkCell;
@property (weak, nonatomic) IBOutlet UITableViewCell   *facebookCell;





@end

@implementation galleryDescriptionViewController


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.tableView.alwaysBounceVertical = NO;
    NSInteger num = indexPath.row;
    UITableViewCell *cell;
    
    switch (num) {
        case 0:
            cell = self.timeCell;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@\n%@", [self.gallery.schedule objectAtIndex:0], [self.gallery.schedule objectAtIndex:1]];
            break;
        case 1:
            cell = self.mapPointerCell;
            cell.detailTextLabel.text = self.gallery.address;
            break;
        case 2:
            cell = self.phoneCell;
            cell.detailTextLabel.text = self.gallery.phone;
            break;
        case 3:
            cell = self.linkCell;
            cell.detailTextLabel.text = self.gallery.link;
            break;
        case 4:
            cell = self.facebookCell;
            cell.detailTextLabel.text = self.gallery.facebook;
            break;

    }
    return cell;
 
}


@end
