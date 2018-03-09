//
//  TableViewCell.h
//  iOSDemoProject
//
//  Created by Yash on 09/03/18.
//  Copyright © 2018 infosys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (strong,nonatomic) UILabel *rowTitle;
@property (strong, nonatomic) UIImageView *rowImage;
@property (strong,nonatomic) UILabel *rowDescription;

@end
