//
//  PhotoListTableViewController.m
//  ObjCExample
//
//  Created by Dzung Tran on 10/8/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "PhotoListTableViewController.h"
#import "PhotoDetailViewController.h"

#define TITLE @"title"
#define FILENAME @"filename"


@interface PhotoListTableViewController ()

@property (nonatomic, strong) NSArray *photos;

@end

@implementation PhotoListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.photos = @[@{TITLE: @"Flying girl", FILENAME: @"photo1.jpg"},
                    @{TITLE: @"Sunset on mountain", FILENAME: @"photo2.jpg"},
                    @{TITLE: @"Golden Gate bridge", FILENAME: @"photo3.jpg"},
                    @{TITLE: @"Sunrise on the sea", FILENAME: @"photo4.jpg"}
                    ];
    
    self.tableView.rowHeight = 60.0;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.photos count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *photo = [self.photos objectAtIndex:indexPath.row];
    
    cell.textLabel.text = photo[TITLE];
    
    CGSize itemSize = CGSizeMake(80, 50);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [[UIImage imageNamed:photo[FILENAME]] drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return cell;
}


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoDetailViewController *photoDetail = [PhotoDetailViewController new];

    photoDetail.image = [UIImage imageNamed:[self.photos objectAtIndex:indexPath.row][FILENAME]];
    
    [self.navigationController pushViewController:photoDetail animated:YES];
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
