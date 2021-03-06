//
//  ViewController.m
//  iOSDemoProject
//
//  Created by Yash on 08/03/18.
//  Copyright © 2018 infosys. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "constants.h"
#import "Masonry.h"
#import "AFNetworking.h"
#import "Reachability.h"

@interface ViewController ()
@end

@implementation ViewController
@synthesize tableRowsArray;
@synthesize responseData;


- (void)viewDidLoad {
    
    [super viewDidLoad];   
    self.tableview.rowHeight = UITableViewAutomaticDimension;
    self.tableview.estimatedRowHeight = 200.0f;
    
    [self.tableview registerClass:[TableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER];
    UINavigationBar* navbar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    UINavigationItem* navItem = [[UINavigationItem alloc] initWithTitle:PAGE_TITLE];
    [navbar setItems:@[navItem]];
    [self.view addSubview:navbar];
    navbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    NSURL *URL = [NSURL URLWithString:REMOTE_URL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    //First check whether we are connected to internet.
    if([self connected]){
    [manager GET:URL.absoluteString
         parameters:nil
           progress:nil
            success:^(NSURLSessionTask *task, id responseObject) {
                //NSLog(@"JSON: %@",);
                NSData *data = [[[NSString alloc] initWithData:responseObject encoding:NSISOLatin1StringEncoding] dataUsingEncoding:NSUTF8StringEncoding];
                _jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                tableRowsArray = [_jsonDict valueForKey:@"rows"];
                [self.tableview reloadData];
                [self.tableview sizeToFit];
            }
            failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
            }
     ];
    }
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.translatesAutoresizingMaskIntoConstraints = false;
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    [self.tableview addSubview:refreshControl];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) refreshView: (UIRefreshControl *)refresh {
    [self.tableview reloadData];
    [refresh endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];
    //Create UITableView with constraints
    [self makeTableView];
}

-(void)makeTableView
{
    self.tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(self.view.frame.size.height);
        make.leading.mas_equalTo(@0);
        make.top.mas_equalTo(50);
        make.trailing.mas_equalTo(@0);
        make.bottom.mas_equalTo(@0);
    }];
}

#pragma Table View Data Source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160.0f;
}

// Return the number of sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// Return the number of rows for each section in your static table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableRowsArray.count;
}

// Return the row for the corresponding section and row
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = CELL_IDENTIFIER;
    TableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    id title = [[tableRowsArray objectAtIndex:indexPath.row] valueForKey:@"title"];
    //check if value is null if it is put it to blank ""
    cell.rowTitle.text = (title == [NSNull null]) ? @"":[[tableRowsArray objectAtIndex:indexPath.row] valueForKey:@"title"];
    
    id description = [[tableRowsArray objectAtIndex:indexPath.row] valueForKey:@"description"];
    cell.rowDescription.text = (description == [NSNull null]) ? @"":[[tableRowsArray objectAtIndex:indexPath.row] valueForKey:@"description"];
    
    // Fetch images using GCD lazy loading
    dispatch_queue_t downloadThumbnailQueue = dispatch_queue_create("GetImage", NULL);
    dispatch_async(downloadThumbnailQueue, ^{
        id imageUrl = [[tableRowsArray objectAtIndex:indexPath.row] valueForKey:@"imageHref"];  
        imageUrl = (imageUrl == [NSNull null]) ? @"": imageUrl;
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",imageUrl]];
        UIImage *image = [UIImage imageWithCIImage:[CIImage imageWithContentsOfURL:url]];
        if(imageUrl == [NSNull null]){
            image = [UIImage imageNamed:DEFAULT_IMAGE];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            TableViewCell *cellToUpdate = [self.tableview cellForRowAtIndexPath:indexPath];
            if (cellToUpdate != nil) {
                [cellToUpdate.rowImage setImage:image];
                [cellToUpdate setNeedsLayout];                
            }
        });
    });
    return cell;
}
#pragma Table View Delegate
// Customize the section headings for each section
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_jsonDict valueForKey:@"title"];
}

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

@end
