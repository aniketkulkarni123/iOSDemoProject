//
//  ViewController.h
//  iOSDemoProject
//
//  Created by Yash on 08/03/18.
//  Copyright © 2018 infosys. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
     NSMutableData *responseData;
}

@property (nonatomic,assign) NSMutableArray *tableRowsArray;
@property (strong, nonatomic) NSMutableData *responseData;
@property (strong, nonatomic) UITableViewCell *tableRowCell;
@property (strong,nonatomic) UILabel *rowTitle;
@property (strong, nonatomic) UIImageView *rowImage;
@property (strong,nonatomic) UILabel *rowDescription;
@property (strong,nonatomic) UITableView *tableview;
@property (strong,nonatomic) NSURLConnection *urlConnection;
@property (strong,nonatomic) NSDictionary *jsonDict;

@end

