//
//  ViewController.h
//  iOSDemoProject
//
//  Created by Yash on 08/03/18.
//  Copyright © 2018 infosys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCell.h"


@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) NSMutableArray *tableRowsArray;
@property (strong, nonatomic) NSMutableData *responseData;
@property (strong, nonatomic) TableViewCell *tableRowCell;
@property (strong,nonatomic) UITableView *tableview;
@property (strong,nonatomic) NSURLConnection *urlConnection;
@property (strong,nonatomic) NSDictionary *jsonDict;

@end

