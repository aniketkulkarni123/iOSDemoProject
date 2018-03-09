//
//  TableViewCell.m
//  iOSDemoProject
//
//  Created by Yash on 09/03/18.
//  Copyright © 2018 infosys. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //Configure title, description and image
        self.rowTitle = [[UILabel alloc] initWithFrame:CGRectMake(170,0,300, 30)];
        self.rowTitle.textColor = [UIColor blackColor];
        self.rowTitle.font = [UIFont fontWithName:@"Arial-Bold" size:12.0f];
        
        self.rowDescription = [[UILabel alloc] initWithFrame:CGRectMake(170,20,self.contentView.frame.size.width-130,90)];
        self.rowDescription.textColor = [UIColor blackColor];
        self.rowDescription.font = [UIFont fontWithName:@"Arial" size:12.0f];
        self.rowDescription.numberOfLines = 0;
        self.rowDescription.translatesAutoresizingMaskIntoConstraints = false;
        
        self.rowImage = [[UIImageView alloc] initWithFrame:CGRectMake(15,10,150,100)];
        UIImage *myImage = [UIImage imageNamed: @"noImage.png"];
        self.rowImage.image = myImage;
        
        [self addSubview:self.rowTitle];
        [self addSubview:self.rowImage];
        [self addSubview:self.rowDescription];
    }
    return self;
}
@end
