//
//  TableViewCell.m
//  iOSDemoProject
//
//  Created by Yash on 09/03/18.
//  Copyright © 2018 infosys. All rights reserved.
//

#import "TableViewCell.h"
#import "Masonry.h"
#import "constants.h"

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
        self.rowTitle = [[UILabel alloc] init];
        self.rowTitle.textColor = [UIColor blackColor];
        self.rowTitle.numberOfLines = 0;
        self.rowTitle.font = [UIFont fontWithName:ARIAL_FONT_BOLD size:FONT_SIZE];
        
        self.rowDescription = [[UILabel alloc] init];
        self.rowDescription.textColor = [UIColor blackColor];
        self.rowDescription.font = [UIFont fontWithName:ARIAL_FONT size:FONT_SIZE];
        self.rowDescription.numberOfLines = 0;
        self.rowDescription.translatesAutoresizingMaskIntoConstraints = false;
        
        self.rowImage = [[UIImageView alloc] init];
        UIImage *myImage = [UIImage imageNamed:DEFAULT_IMAGE];
        self.rowImage.image = myImage;
        
        [self addSubview:self.rowImage];
        [self.rowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.left.equalTo(@15);
            make.top.equalTo(@10);
            make.width.equalTo(@150);
            make.height.equalTo(@100);
        }];
        
        [self addSubview:self.rowTitle];
        [self.rowTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.rowImage.mas_trailing).with.offset(5);
            make.top.equalTo(self.rowImage.mas_top);
        }];
        [self addSubview:self.rowDescription];
        
        [self.rowDescription mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.rowTitle.mas_leading);
            make.top.mas_equalTo(self.rowTitle.mas_top).with.offset(20);
            make.trailing.mas_equalTo(self.contentView.mas_trailing).with.offset(-10);            
        }];
        
    }
    return self;
}
@end
